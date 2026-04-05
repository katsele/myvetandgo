# Technical Architecture — My Vet&Go Galaxy

**Author:** Arnaud
**Date:** April 2026
**Status:** Proposal v1 — Galaxy (ambitious multi-specialty vision)
**Reference:** `galaxy/prd-galaxy.md`, `architecture-myvetandgo.md` (niche v2)

---

## 1. Executive Summary

This document extends the niche emergency architecture (`architecture-myvetandgo.md`) to support the Galaxy vision: a multi-specialty veterinary CE platform covering 20+ disciplines, 5 countries, bilingual FR/NL, with AI clinical search, multi-tenant B2B, and a target of 5,500+ subscribers at maturity.

**Key architectural changes from niche to Galaxy:**

| Concern            | Niche                         | Galaxy                                                       | Architectural Impact                                          |
| ------------------ | ----------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------- |
| Content scope      | 1 specialty (ECC)             | 20+ specialties                                              | Data model expansion (Specialty entity), content pipeline     |
| User scale         | ±500 users                    | ±5,500+ users                                                | Caching strategy, CDN, DB optimization                        |
| B2B / multi-tenant | Single org (Vet&Go)           | Multi-org + enterprise groups                                | Tenant isolation, license management, RBAC expansion          |
| AI search corpus   | ±100 videos, ±10K segments    | ±2,000+ videos, ±200K+ segments                              | Vector index scaling, embedding pipeline, cost management     |
| Localization       | FR primary + NL subtitles     | Native FR + NL (UI, content, search)                         | Full i18n infrastructure, per-locale content variants         |
| Payments           | Internal only → simple Stripe | Multi-tier subscriptions + B2B invoicing                     | Stripe Connect / billing engine, tax compliance (5 countries) |
| Compliance         | Belgian accreditation         | 5-country accreditation + Qualiopi + GDPR multi-jurisdiction | Per-country CE point rules engine, data residency             |
| Content production | Small editorial team          | 50–100+ external contributors                                | Contributor portal, review workflow, rights management        |

**Core architectural decision maintained:** Full custom (no headless CMS). Galaxy reinforces this choice — the complexity of multi-specialty curricula, multi-tenant B2B, AI search, and 5-country CE compliance is far beyond any CMS.

**Stack remains:** Next.js (App Router) + PostgreSQL (Neon) + Neon Auth + Vimeo + pgvector. Galaxy adds: Stripe Billing, contributor portal, expanded RBAC, and a content pipeline.

---

## 2. System Architecture Overview

```
┌──────────────────────────────────────────────────────────────────────┐
│                          CLIENTS                                     │
│     Browser (Next.js SSR/CSR)    │    Mobile (PWA → Native Ph5)     │
└───────────────────┬──────────────┴──────────────────────────────────┘
                    │ HTTPS
┌───────────────────▼──────────────────────────────────────────────────┐
│                      EDGE / CDN (Vercel)                             │
│  Static assets, ISR pages, Edge Middleware (geo, locale, auth)       │
└───────────────────┬──────────────────────────────────────────────────┘
                    │
┌───────────────────▼──────────────────────────────────────────────────┐
│                  APPLICATION (Next.js 16 on Vercel)                   │
│                                                                       │
│  ┌─────────────┐  ┌──────────────┐  ┌──────────────┐                │
│  │ App Router  │  │ Server       │  │  API Routes   │                │
│  │  (SSR/RSC)  │  │ Actions      │  │  /api/*       │                │
│  └──────┬───────┘  └──────┬───────┘  └──────┬────────┘                │
│         │                 │                  │                         │
│  ┌──────▼─────────────────▼──────────────────▼────────┐               │
│  │              BUSINESS LOGIC LAYER                   │               │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌────────┐│               │
│  │  │ Content  │ │ Quiz /   │ │ AI Search│ │ Billing││               │
│  │  │ Service  │ │ CE Points│ │ (RAG)    │ │ Service││               │
│  │  └──────────┘ └──────────┘ └──────────┘ └────────┘│               │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌────────┐│               │
│  │  │ Auth /   │ │ Progress │ │Contributor│ │ Export ││               │
│  │  │ RBAC     │ │ Tracking │ │ Pipeline │ │ / PDF  ││               │
│  │  └──────────┘ └──────────┘ └──────────┘ └────────┘│               │
│  └────────────────────────────────────────────────────┘               │
└───┬──────────┬──────────┬──────────┬──────────┬──────────────────────┘
    │          │          │          │          │
    ▼          ▼          ▼          ▼          ▼
┌────────┐ ┌────────┐ ┌────────┐ ┌──────────┐ ┌───────────────────────┐
│ Neon   │ │ Vimeo  │ │ Stripe │ │ LLM API  │ │  External Services    │
│ PG +   │ │ Player │ │Billing │ │(OpenAI / │ │  - Resend (email)     │
│pgvector│ │ SDK +  │ │        │ │ Claude)  │ │  - Sentry (errors)    │
│        │ │ API    │ │        │ │          │ │  - R2 (PDF/assets)    │
│        │ │        │ │        │ │          │ │  - Upstash (rate lim) │
│        │ │        │ │        │ │          │ │  - Vercel Cron (jobs) │
└────────┘ └────────┘ └────────┘ └──────────┘ └───────────────────────┘
```

---

## 3. Data Model — Galaxy Extensions

The Galaxy data model extends the niche schema with four major additions: **Specialties**, **Multi-tenant Organizations**, **Subscriptions/Billing**, and **Contributor Management**.

### 3.1 Specialty & Content Hierarchy

```prisma
// NEW: Specialty as top-level content organizer
model Specialty {
  id            String       @id @default(cuid())
  slug          String       @unique          // "urgences-ecc", "dentisterie", "dermatologie"
  nameFr        String
  nameNl        String
  descriptionFr String?
  descriptionNl String?
  iconUrl       String?                       // Specialty icon for UI
  wave          Int          @default(1)      // Rollout wave (1-4)
  isActive      Boolean      @default(false)  // Published on platform
  curricula     Curriculum[]
  sortOrder     Int          @default(0)
  createdAt     DateTime     @default(now())
}

// EXTENDED: Curriculum now belongs to a Specialty
model Curriculum {
  id            String           @id @default(cuid())
  specialtyId   String
  specialty     Specialty        @relation(fields: [specialtyId], references: [id])
  nameFr        String
  nameNl        String
  descriptionFr String?
  descriptionNl String?
  profile       Profile          // VET, ASV, WELLBEING
  type          CurriculumType   // SYSTEM, TRANSVERSAL, PROCEDURAL
  level         CurriculumLevel  @default(BEGINNER) // NEW: progression level
  durationHours Float?           // Estimated total hours
  videos        CurriculumVideo[]
  certificates  SpecialtyCertificate[]
  sortOrder     Int              @default(0)
  createdAt     DateTime         @default(now())
}

enum CurriculumLevel {
  BEGINNER
  INTERMEDIATE
  ADVANCED
}

enum CurriculumType {
  SYSTEM        // By medical system
  TRANSVERSAL   // Cross-system
  PROCEDURAL    // Technique-focused
}

// NEW: Specialty-level certificates (after completing all curricula in a specialty)
model SpecialtyCertificate {
  id            String     @id @default(cuid())
  userId        String
  user          User       @relation(fields: [userId], references: [id])
  curriculumId  String
  curriculum    Curriculum @relation(fields: [curriculumId], references: [id])
  pdfUrl        String
  issuedAt      DateTime   @default(now())
}
```

### 3.2 Multi-Tenant Organizations & RBAC

```prisma
// EXTENDED: Organization for multi-tenant B2B
model Organization {
  id            String        @id @default(cuid())
  name          String
  type          OrgType
  slug          String        @unique
  country       Country       @default(BE)     // NEW: country for CE rules
  parentId      String?                         // NEW: group hierarchy (IVC Evidensia → clinics)
  parent        Organization? @relation("OrgHierarchy", fields: [parentId], references: [id])
  children      Organization[] @relation("OrgHierarchy")
  subscription  Subscription?                   // NEW: billing
  maxSeats      Int?                            // NEW: license cap
  users         User[]
  createdAt     DateTime      @default(now())
}

enum OrgType {
  INTERNAL      // Vet&Go
  EXTERNAL      // Individual subscriber
  CLINIC        // Single clinic
  GROUP         // Multi-clinic group (IVC Evidensia, AniCura...)
}

enum Country { BE, FR, LU, NL, CH }

// EXTENDED: User with expanded roles
model User {
  id              String   @id @default(cuid())
  email           String   @unique
  firstName       String
  lastName        String
  language        Language @default(FR)
  role            UserRole @default(VET)
  orderNumber     String?
  country         Country  @default(BE)
  organizationId  String
  organization    Organization @relation(fields: [organizationId], references: [id])
  // ... existing relations (progress, quizAttempts, certificates, etc.)
  specialtyCerts  SpecialtyCertificate[]
  contributions   VideoContribution[]      // NEW: if user is also a contributor
  createdAt       DateTime @default(now())
  deactivatedAt   DateTime?
}

enum UserRole {
  VET
  ASV
  MANAGER         // Clinic/org manager
  GROUP_ADMIN     // Multi-clinic group admin (NEW)
  CONTRIBUTOR     // Content contributor (NEW)
  ADMIN           // Platform admin
}
```

### 3.3 Subscriptions & Billing

```prisma
model Subscription {
  id                String           @id @default(cuid())
  organizationId    String           @unique
  organization      Organization     @relation(fields: [organizationId], references: [id])
  stripeCustomerId  String           @unique
  stripeSubId       String?          @unique
  plan              SubscriptionPlan
  status            SubStatus        @default(TRIALING)
  seats             Int              @default(1)
  pricePerSeat      Int                           // Cents — varies by tier
  currentPeriodEnd  DateTime
  cancelAtPeriodEnd Boolean          @default(false)
  createdAt         DateTime         @default(now())
  updatedAt         DateTime         @updatedAt
}

enum SubscriptionPlan {
  INDIVIDUAL_MONTHLY    // 29 €/month
  INDIVIDUAL_ANNUAL     // 299 €/year
  CLINIC_ANNUAL         // 199-169 €/seat/year (2-15 seats)
  GROUP_ANNUAL          // 129-149 €/seat/year (16+ seats, negotiated)
}

enum SubStatus {
  TRIALING
  ACTIVE
  PAST_DUE
  CANCELED
  PAUSED
}
```

### 3.4 Contributor Pipeline

```prisma
// NEW: External contributor management
model Contributor {
  id            String   @id @default(cuid())
  userId        String?  @unique              // Linked user account (optional)
  user          User?    @relation(fields: [userId], references: [id])
  firstName     String
  lastName      String
  email         String   @unique
  title         String?                       // "DipECVECC", "DipACVIM", etc.
  specialties   String[]                      // Specialty slugs
  bio           String?
  videos        VideoContribution[]
  createdAt     DateTime @default(now())
}

model VideoContribution {
  id             String      @id @default(cuid())
  videoId        String
  video          Video       @relation(fields: [videoId], references: [id])
  contributorId  String
  contributor    Contributor @relation(fields: [contributorId], references: [id])
  role           ContribRole @default(PRESENTER)
}

enum ContribRole {
  PRESENTER        // Main speaker
  REVIEWER         // Clinical reviewer
  QUIZ_AUTHOR      // Quiz question writer
}
```

### 3.5 CE Points Rules Engine

```prisma
// NEW: Per-country CE accreditation rules
model CeAccreditation {
  id            String   @id @default(cuid())
  country       Country
  bodyName      String                       // "CFCV", "CRFOMV", "NGROD", "SVS", "CKRD"
  accreditationId String?                    // External reference number
  pointsPerHour Float                        // 1 for most, 2 for BE interactive
  maxElearningPct Float  @default(100)       // 50% for France, 60% for Belgium
  validFrom     DateTime
  validTo       DateTime?
  createdAt     DateTime @default(now())
}
```

---

## 4. Architecture by Phase — Galaxy Additions

### Phase 1–2: Identical to Niche

No architectural changes. Galaxy Phase 1–2 = niche Phase 1–2. The Specialty model can be seeded with a single specialty ("Urgences/ECC") from day one, but the architecture is the same.

### Phase 2b: Multi-Specialty Extension (Month 6–18)

**New routes:**

```
/[lang]/specialties/                      → Specialty catalog
/[lang]/specialties/[specialty]/          → Specialty page (curricula list)
/[lang]/specialties/[specialty]/[curriculum]/   → Curriculum detail
/[lang]/specialties/[specialty]/[curriculum]/[video]  → Video page
/profile/competency-map                   → Radar chart of specialty progress
```

**Competency map:** Aggregate `CurriculumProgress` by specialty. Display as a radar chart (Recharts or D3) with axes = specialties, values = % completion. Server Component fetches data, client component renders the chart.

**Content pipeline for new specialties:**

```
New Specialty Request
    │
    ├─ 1. Contributor recruited (Contributor model)
    ├─ 2. Videos uploaded to Vimeo (Vimeo API)
    ├─ 3. Metadata entered via admin portal (Video, Curriculum, Chapter)
    ├─ 4. Transcripts extracted (Vimeo subtitles API)
    ├─ 5. Quiz questions authored (Quiz, Question models)
    ├─ 6. Review & publish (admin toggle: Specialty.isActive)
    └─ 7. Embedding pipeline indexes transcripts (pgvector)
```

### Phase 3: AI Search at Scale (Month 12–24)

**Scaling concern:** Niche = ±10K vector segments. Galaxy = ±200K+ segments.

pgvector with HNSW indexing handles 200K vectors efficiently on Neon. Expected query latency: <50ms for top-20 retrieval. If performance degrades beyond 500K vectors, migrate to a dedicated vector DB (Qdrant Cloud — same query interface, simple migration).

**Multi-specialty search:** The RAG pipeline adds specialty metadata to each segment, enabling filtered search ("search only within dentistry") or cross-specialty search (default).

```typescript
// Pseudo-code: Galaxy RAG query with optional specialty filter
async function searchGalaxy(query: string, specialtySlug?: string) {
  const embedding = await embed(query);

  const segments = await prisma.$queryRaw`
    SELECT ts.*, v."titleFr", v."titleNl", s."nameFr" as "specialtyName"
    FROM "TranscriptSegment" ts
    JOIN "Transcript" t ON ts."transcriptId" = t.id
    JOIN "Video" v ON t."videoId" = v.id
    JOIN "CurriculumVideo" cv ON v.id = cv."videoId"
    JOIN "Curriculum" c ON cv."curriculumId" = c.id
    JOIN "Specialty" s ON c."specialtyId" = s.id
    WHERE ${specialtySlug ? Prisma.sql`s.slug = ${specialtySlug} AND` : Prisma.empty}
      ts.embedding <=> ${embedding}::vector < 0.8
    ORDER BY ts.embedding <=> ${embedding}::vector
    LIMIT 20
  `;

  return generateResponse(query, segments);
}
```

**Cost management:** At 200K segments × ±$0.00002/embedding = ±$4 for full re-indexing. Runtime search: ±$0.00001/query. At 5,500 users × 5 queries/day = ±$0.83/day. Negligible.

LLM response generation: ±$0.002/query (GPT-4o-mini) or ±$0.003 (Claude Haiku). At 27,500 queries/day max = ±$55–82/day = ±$1,700–2,500/month at full scale. Manageable. Implement response caching for repeated queries.

### Phase 4: Billing & Multi-Tenant (Month 18–30)

**Stripe Billing integration:**

```
┌────────────────┐     ┌──────────────────────┐
│  Pricing Page   │────▶│  Stripe Checkout     │
│  (Next.js)      │     │  (hosted or embedded) │
└────────────────┘     └──────────┬───────────┘
                                  │
                       ┌──────────▼───────────┐
                       │  Stripe Webhooks      │
                       │  /api/webhooks/stripe  │
                       └──────────┬───────────┘
                                  │
              ┌───────────────────┼───────────────────┐
              │                   │                     │
    ┌─────────▼────────┐ ┌──────▼──────┐ ┌──────────▼────────┐
    │ checkout.session  │ │ invoice.    │ │ customer.         │
    │ .completed        │ │ paid/failed │ │ subscription.*    │
    │ → Create Sub      │ │ → Update    │ │ → Status changes  │
    └──────────────────┘ └─────────────┘ └───────────────────┘
```

**Multi-tenant access control:**

```typescript
// Middleware: check subscription + seat limit
async function checkAccess(userId: string) {
  const user = await getUser(userId);
  const org = await getOrg(user.organizationId);
  const sub = await getSubscription(org.id);

  if (!sub || sub.status !== 'ACTIVE') {
    // Internal Vet&Go users bypass subscription check
    if (org.type === 'INTERNAL') return { access: true };
    return { access: false, reason: 'no_active_subscription' };
  }

  const activeSeats = await countActiveUsers(org.id);
  if (activeSeats > sub.seats) {
    return { access: false, reason: 'seat_limit_exceeded' };
  }

  return { access: true, plan: sub.plan };
}
```

**Tax compliance (5 countries):** Use Stripe Tax for automatic VAT calculation. Belgium 21%, France 20%, Luxembourg 17%, Netherlands 21%, Switzerland 8.1%. Stripe handles B2C reverse-charge rules.

**B2B invoicing:** For GROUP_ANNUAL plans (16+ seats), use Stripe Invoicing with net-30 terms. Manual provisioning via admin portal.

### Phase 5: Scale & Native Mobile (Month 24–48)

**Performance at scale (5,500+ users):**

- **Database:** Neon Pro ($19/mo) handles this easily. Add read replicas if needed.
- **Caching:** Vercel ISR for specialty/curriculum pages (revalidate: 3600). Redis (Upstash) for session data and frequent queries.
- **CDN:** Vercel Edge Network for static assets. Vimeo CDN for video delivery.
- **API routes:** Serverless functions scale automatically on Vercel.

**Mobile strategy:**

Option A (recommended): **Progressive Web App (PWA)** with offline support for downloaded video metadata and search results. Avoids App Store overhead and dual codebase.

Option B (Phase 5+): **React Native** or **Expo** for iOS/Android if PWA adoption is insufficient. Share business logic via a shared TypeScript package. API routes become the de facto REST API.

Decision criteria: If mobile usage exceeds 40% of sessions by Phase 4, invest in native. Otherwise, PWA is sufficient.

---

## 5. Galaxy-Specific Technical Concerns

### 5.1 Internationalization (i18n)

**Content i18n:** Dual-language content at the model level (nameFr/nameNl fields on every content entity). This is maintained from the niche architecture.

**UI i18n:** Next.js `[lang]` segment with `fr` and `nl` locales. Translations stored in JSON files (`messages/fr.json`, `messages/nl.json`). Use `next-intl` or a lightweight i18n library.

**Search i18n:** The RAG pipeline indexes transcripts in their original language. Queries in French search French transcripts; queries in Dutch search Dutch transcripts. Cross-language search (query in FR, results in NL) is out of scope — content should exist natively in both languages.

### 5.2 CE Points Rules Engine

CE point calculation varies by country:

| Country      | Body       | Points/hour | E-learning cap     | Interactive bonus      |
| ------------ | ---------- | ----------- | ------------------ | ---------------------- |
| Belgium (FR) | CRFOMV     | 1 pt/h      | 60% of total       | 2 pts/h if quiz passed |
| Belgium (NL) | NGROD/EBP  | 1 pt/h      | 60% of total       | 2 pts/h if quiz passed |
| France       | CFCV       | 1 CFC/20h   | 50% of total CFC   | —                      |
| Luxembourg   | Coll. Vét. | 1 pt/h      | No cap identified  | —                      |
| Netherlands  | CKRD       | 1 pt/h      | No cap (voluntary) | —                      |
| Switzerland  | SVS        | 1 pt/h      | No cap identified  | —                      |

Implementation: A `CePointsCalculator` service reads the user's country, applies the relevant rules from `CeAccreditation`, and generates the correct point value and certificate format.

```typescript
// Simplified CE points calculation
function calculateCePoints(
  video: Video,
  quizPassed: boolean,
  userCountry: Country,
): number {
  const rules = getCeRules(userCountry);
  const basePoints = (video.durationMin / 60) * rules.pointsPerHour;

  if (quizPassed && rules.interactiveMultiplier) {
    return basePoints * rules.interactiveMultiplier; // Belgium: ×2
  }
  return basePoints;
}
```

### 5.3 Contributor Portal (Admin Extension)

External contributors (50–100+ specialists) need a lightweight portal to:

- Upload video files (→ Vimeo via API)
- Add metadata (title, description, specialty, chapters)
- Author quiz questions
- Review and approve content before publication

This is implemented as an extension of the existing `/admin` routes with a `CONTRIBUTOR` role that has scoped access (only their own content).

### 5.4 Analytics & Reporting

**User-facing analytics (Profile):**

- Competency radar chart (per specialty)
- CE points tracker (per country accreditation body)
- Learning streak and activity history

**Manager dashboard (B2B):**

- Team heatmap (rows = members, columns = specialties, cells = % completion)
- CE compliance alerts (users approaching deadlines)
- Comparative analytics (team vs. platform average)
- Export: Excel (via `xlsx` library) and PDF

**Platform analytics (Admin):**

- Active users, retention cohorts, churn analysis
- Content engagement (views, completions, quiz pass rates by specialty)
- Revenue metrics (MRR, ARPU, LTV, CAC)
- AI search usage (queries/day, satisfaction, cost)

Implementation: Server Components query aggregated data. For complex analytics (cohorts, funnels), consider a lightweight analytics pipeline (Vercel Analytics + custom events → PostgreSQL aggregation tables updated by daily Cron jobs).

---

## 6. Infrastructure & Cost Projection

### Monthly cost estimate at scale (An 5, 5,500 users)

| Service                          | Tier                          | Estimated Monthly Cost           |
| -------------------------------- | ----------------------------- | -------------------------------- |
| **Vercel**                       | Pro                           | $20 + usage (±$50–100)           |
| **Neon PostgreSQL**              | Pro (Scale)                   | $69 + storage/compute            |
| **Vimeo**                        | Business/Premium              | $50–75 (existing)                |
| **Stripe**                       | 1.4% + €0.25/transaction (EU) | ±$500–800 (on ±$170K/mo revenue) |
| **OpenAI / Anthropic (LLM)**     | Pay-per-use                   | $800–2,500                       |
| **Cloudflare R2**                | Pay-per-use                   | $5–20                            |
| **Resend**                       | Pro                           | $20–50                           |
| **Sentry**                       | Team                          | $26                              |
| **Upstash (Redis + Rate Limit)** | Pay-per-use                   | $10–30                           |
| **Domain + DNS**                 | —                             | $15                              |
| **TOTAL**                        | —                             | **$1,500–3,700/month**           |

At An 5 revenue of ±$170K/month (2M€ ARR), infrastructure costs represent **0.9–2.2% of revenue** — excellent margins for a SaaS.

### Scaling triggers

| Trigger                 | Action                                                       |
| ----------------------- | ------------------------------------------------------------ |
| >10K concurrent users   | Add Vercel Edge Functions, evaluate Neon read replicas       |
| >500K vector segments   | Evaluate Qdrant Cloud migration                              |
| >50K search queries/day | Implement response caching (Redis), evaluate self-hosted LLM |
| >$5K/month LLM costs    | Switch to smaller/self-hosted model for common queries       |
| Mobile usage >40%       | Evaluate React Native investment                             |

---

## 7. Security & Compliance

### GDPR Multi-Jurisdiction

Galaxy operates in 5 EU/EEA countries + Switzerland. Key requirements:

- **Data residency:** Neon PostgreSQL in EU region (Frankfurt). Vimeo CDN is global but data is not user-specific. R2 in EU region.
- **User data export:** API endpoint `/api/user/export` generates a JSON/CSV of all user data (GDPR Article 20).
- **Right to deletion:** `/api/user/delete` soft-deletes user data, hard-deletes after 30 days. Certificates preserved (regulatory obligation).
- **Consent management:** Cookie banner with granular consent (analytics, functional). Consent stored per-user.
- **DPA (Data Processing Agreement):** Required with Vercel, Neon, Vimeo, Stripe, OpenAI/Anthropic.

### Authentication & Authorization

- **Neon Auth** (`@neondatabase/auth`) — built on Better Auth, stores auth data in the `neon_auth` schema within the same Neon database. Provides email/password, email OTP (magic link), and OAuth (Phase 4+). Pre-built UI components (`AuthView`, `AccountView`) and admin APIs (`admin.listUsers()`, `admin.banUser()`, `admin.setRole()`).
- **User sync:** DB trigger on `neon_auth.user` auto-creates/links app `User` rows (with domain fields: role, country, language, organizationId). `ON CONFLICT (email)` handles invitation-first flow where admins pre-create User rows before signup.
- **Invitation-only** (Phase 1–3), **open registration** (Phase 4+) via feature flag (`FEATURE_OPEN_REGISTRATION`).
- **RBAC:** 6 roles (VET, ASV, MANAGER, GROUP_ADMIN, CONTRIBUTOR, ADMIN). Permissions checked at Server Action / API route level via app-layer guards (`requireAuth()`, `requireRole()`). Neon Auth handles identity; the app handles authorization.
- **Row-Level Security:** Users can only access their own progress, certificates, and organization data. Managers see their org's users only. Group admins see child organizations.

### Content Protection

- Vimeo domain-level restrictions (videos only playable on myvetandgo.com)
- Signed embed URLs with expiration tokens
- No video download capability
- Transcript segments served via API (not raw files)

---

## 8. Development Phasing & Team Scaling

### Phase 1–2 (Month 0–18): Small Team

**Team:** 1 full-stack developer (Arnaud) + 1 designer (contract)

Focus: Build the niche product (ECC only), validate the model. Galaxy data model is present but only one Specialty is active.

### Phase 3 (Month 12–24): Growing Team

**Team addition:** +1 full-stack developer, +1 content operations person

Focus: AI search, multi-specialty content pipeline, first specialty extensions.

### Phase 4–5 (Month 18–48): Scaling Team

**Team additions:** +1 backend developer (billing, B2B, compliance), +1 frontend developer (mobile PWA/native), +1 content editor-in-chief

Focus: Multi-country launch, B2B, full specialty coverage, mobile.

**Total team at maturity (An 3–4):** 4–5 developers + 1 designer + 1 content ops + 1 editor-in-chief = **6–8 people** (excluding content contributors who are external).

---

## 9. Migration Path: Niche → Galaxy

Galaxy is not a rewrite — it's an extension. The migration path is:

1. **Day 1 (niche launch):** Deploy with `Specialty` model seeded with one entry ("Urgences/ECC"). All existing curricula belong to this specialty. The UI shows curricula directly (no specialty selection needed with only one).

2. **Phase 2b (first extension):** Add 2–3 specialties. The UI evolves to show a specialty selector on the home page. Existing routes gain a `/specialties/[specialty]` prefix.

3. **Phase 3 (multi-specialty):** 10+ specialties active. The home page becomes a specialty catalog. Competency map and cross-specialty search become meaningful.

4. **Phase 4 (billing):** Add Subscription model, Stripe integration, access control middleware. Internal users remain free. External users require active subscription.

5. **Phase 5 (B2B):** Add Organization hierarchy, GROUP_ADMIN role, multi-site dashboard. Stripe Invoicing for enterprise contracts.

**No breaking migrations.** Each phase adds tables and columns; no destructive changes to existing schemas. Prisma migrations handle the evolution.

---

## 10. Key Architectural Decisions

| #   | Decision                                                         | Rationale                                                                                          | Alternatives Considered                       |
| --- | ---------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- | --------------------------------------------- |
| 1   | Full custom, no CMS                                              | Galaxy complexity (20+ specialties, multi-tenant B2B, AI, 5-country CE rules) far exceeds any CMS  | Sanity, Strapi, Contentful — all rejected     |
| 2   | Next.js monolith (no microservices)                              | Team size (1–5 devs) doesn't justify microservices overhead. Monolith with clear module boundaries | Separate API (Express/NestJS) + SPA           |
| 3   | pgvector over dedicated vector DB                                | Corpus size (200K segments) is well within pgvector's range. Avoids operational overhead           | Pinecone, Qdrant, Weaviate                    |
| 4   | Neon over Supabase                                               | Low vendor coupling, DB branching for previews, own auth layer                                     | Supabase (rejected: too much coupling)        |
| 5   | Stripe Billing over custom billing                               | Regulatory complexity (5 countries, VAT, invoicing) is Stripe's core competency                    | Custom billing engine (rejected: too risky)   |
| 6   | PWA over native mobile (until Phase 5)                           | Cost of dual codebase not justified until mobile usage > 40%                                       | React Native from day 1 (rejected: premature) |
| 7   | Dual-language fields (nameFr/nameNl) over CMS-style localization | Simple, explicit, no i18n framework overhead at the content level                                  | gettext, i18n CMS, translation API            |
| 8   | Per-country CE rules in DB over hardcoded                        | Rules change (FIF-PL reduction, new accreditations). DB-driven rules are admin-configurable        | Hardcoded logic (rejected: brittle)           |

---

_Architecture Galaxy v1 — April 2026. This document extends the niche architecture (architecture-myvetandgo.md) for the ambitious multi-specialty Galaxy vision. All niche architectural decisions remain valid and are reinforced by Galaxy requirements._
