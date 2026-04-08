# My VET&GO — Brand Identity, Styleguide & Motion

**Version:** 1.1 — April 2026
**Author:** Arnaud (OSTRO Brothers SRL)
**Status:** Foundation — ready for UI design
**Scope:** My VET&GO Galaxy learning platform (web, responsive, future native)
**Source references:** VET&GO mini charte graphique (05.2019), Figma Hi-Fi Homepage 3 (node 1279:233), PRD Galaxy v1, deep market research v2, learning experience landscape research

> This document covers brand DNA, personality, voice & tone, typography, imagery, motion, and brand signature elements. For UX/UI patterns see [03b-ux-patterns.md](./03b-ux-patterns.md). For design tokens and component theming see [03c-design-tokens.md](./03c-design-tokens.md).

---

## 1. Brand DNA & Emotional Territory

### 1.1 Brand Essence

My VET&GO is the professional learning arm of VET&GO, Belgium's veterinary emergency network. The platform bridges two worlds: the **clinical urgency** of emergency medicine and the **structured calm** of professional development. Every design decision must resolve this tension — the brand must feel authoritative enough for a specialist reviewing a critical protocol at 2 AM, yet approachable enough for a general practitioner browsing a dentistry course on a Sunday afternoon.

**One-line positioning:** The clinical intelligence tool that busy veterinary professionals actually want to open.

### 1.2 Brand Personality (five-trait model)

| Trait                        | Expression                                                                     | What it is NOT                                                               |
| ---------------------------- | ------------------------------------------------------------------------------ | ---------------------------------------------------------------------------- |
| **Clinically authoritative** | Deep teal palette, structured layouts, medical-grade precision in data display | Not academic or institutional — no university aesthetics                     |
| **Urgently available**       | Speed-first interactions, bold CTAs, high contrast, immediate visual hierarchy | Not aggressive or alarming — urgency without anxiety                         |
| **Warmly professional**      | Rounded shapes, organic wave patterns, animal photography, humanist typography | Not cute, childish, or overly playful — no cartoon animals                   |
| **Quietly confident**        | Generous whitespace, restrained animation, neutral UI chrome, editorial tone   | Not loud, salesy, or boastful — never Wizzvet's "thousands of videos" energy |
| **Bilingually native**       | Equal treatment of FR/NL, no flags, culturally neutral design patterns         | Not "translated" — both languages feel like the original                     |

### 1.3 Emotional Design Principles

These six principles guide every UI decision. When in doubt, refer back to these.

**1. Speed is respect.** Veterinary professionals operate under time pressure — during consultations, between patients, on night shifts. Every unnecessary click, animation, or loading state communicates disrespect for their time. Target: sub-100ms feedback, 3-tap rule for any core action, zero-click answer panels for AI clinical reference.

**2. Expertise deserves expertise.** The platform must feel like it was designed by someone who understands clinical work. Use medical terminology naturally (not dumbed down). Display data densely when appropriate. Never call a quiz a "quiz" — it's a Clinical Assessment. Never say "wrong answer" — say "learning opportunity." The UI should feel like a peer, not a teacher.

**3. Calm under pressure.** The dark mode default exists for a reason: veterinarians use this tool in dim consultation rooms, during night shifts, in surgery prep. The interface must be visually quiet — low contrast chrome, high contrast content. The ECG pulse line motif from the VET&GO homepage is the perfect metaphor: steady rhythm, controlled energy, ready to act.

**4. Progress is visible.** Professional stagnation contributes to the 37% early-career dropout rate in Belgian veterinary practice. Every interaction should make the user feel like they're growing. Competency radars that expand, credit counters that fill, streaks that build — visible progress combats burnout.

**5. Independence is integrity.** My VET&GO is pharma-independent. This must be felt, not just stated. No sponsored content badges, no "brought to you by" banners. The visual language should feel editorially independent — closer to a medical journal than a pharma-sponsored webinar platform.

**6. Bilingualism is invisible.** The platform should never feel "translated." Both FR and NL must be first-class. Design all components with 35% text expansion margin. Use `FR | NL` text toggles — never flags. URL structure: `galaxy.be/fr/` and `galaxy.be/nl/`.

### 1.4 Brand Values Mapped to Design Decisions

| Value                 | Design manifestation                                                                                            |
| --------------------- | --------------------------------------------------------------------------------------------------------------- |
| **Urgence maîtrisée** | Bold red CTA for emergency actions only; teal for standard interactions. Red is reserved — never decorative.    |
| **Rigueur clinique**  | Data-dense layouts, evidence grading on AI answers, citation-linked content, medical-grade precision in numbers |
| **Accessibilité**     | Dark mode default, WCAG AA minimum, offline capability for rural practice, voice search for hands-free use      |
| **Indépendance**      | No sponsored content markers needed because there is no sponsored content. Clean, editorial visual language.    |
| **Bilinguisme**       | Text-only language switcher, no cultural bias in imagery, parallel FR/NL content versions                       |
| **Communauté**        | Peer comparison data ("72% des praticiens ont répondu correctement"), team dashboards, shared progress          |

---

## 2. Voice & Tone

### 2.1 Tone by Context

| Context                     | Tone                                                    | Example (FR)                                                                             | Example (NL)                                                                        |
| --------------------------- | ------------------------------------------------------- | ---------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| **AI clinical reference**   | Direct, evidence-based, concise. No hedging.            | "Protocole recommandé : midazolam 0,2 mg/kg IV"                                          | "Aanbevolen protocol: midazolam 0,2 mg/kg IV"                                       |
| **Course descriptions**     | Authoritative but inviting. Speak peer-to-peer.         | "Ce cursus vous guide de la radiographie de base à l'interprétation avancée des thorax." | "Dit traject leidt u van basale radiografie tot gevorderde thoraxinterpretatie."    |
| **Progress & achievements** | Warm, factual, non-patronizing. No gamification cringe. | "12 crédits FC obtenus ce trimestre. 8 restants pour votre cycle."                       | "12 PE-punten behaald dit kwartaal. 8 resterend voor uw cyclus."                    |
| **Error states**            | Helpful, blame-free, action-oriented.                   | "Ce contenu n'a pas pu charger. Vérifiez votre connexion ou réessayez."                  | "Deze inhoud kon niet worden geladen. Controleer uw verbinding of probeer opnieuw." |
| **Empty states**            | Encouraging, directional, never hollow.                 | "Votre parcours commence ici. Choisissez votre première spécialité."                     | "Uw traject begint hier. Kies uw eerste specialisatie."                             |
| **Assessment feedback**     | Respectful of expertise. Clinical framing.              | "Niveau de maîtrise : Avancé. Axe de progression identifié : pharmacologie d'urgence."   | "Beheersingsniveau: Gevorderd. Groeias geïdentificeerd: spoedfarmacolie."           |

### 2.2 Vocabulary Guidelines

**Words to use:** Cursus, parcours, spécialité, maîtrise, compétence, référence clinique, progression, validation, praticien(ne).

**Words to avoid:** Cours (too academic), leçon (too scholastic), étudiant (use praticien), score (use niveau de maîtrise), test (use évaluation clinique), facile/difficile (use niveaux 1–5 with clinical hammer icons à la AMBOSS).

### 2.3 Terminology Reference (UX Copy)

Consistent terminology is critical across FR/NL and across the platform.

| Concept            | FR term             | NL term              | Never use                              |
| ------------------ | ------------------- | -------------------- | -------------------------------------- |
| Learning pathway   | Cursus              | Traject              | Cours, Leçon                           |
| Single module      | Module              | Module               | Chapitre (reserved for video chapters) |
| Video segment      | Chapitre            | Hoofdstuk            | Clip, Extrait                          |
| Assessment         | Évaluation clinique | Klinische evaluatie  | Quiz, Test, Examen                     |
| CE credits         | Crédits FC          | PE-punten            | Points, Heures                         |
| Skill level        | Niveau de maîtrise  | Beheersingsniveau    | Score, Note                            |
| User               | Praticien(ne)       | Beoefenaar           | Étudiant, Apprenant                    |
| Specialty          | Spécialité          | Specialisatie        | Matière, Sujet                         |
| Progress           | Progression         | Voortgang            | Avancement                             |
| Certificate        | Certificat          | Certificaat          | Diplôme                                |
| Team (B2B)         | Équipe              | Team                 | Groupe                                 |
| Manager (B2B)      | Responsable         | Verantwoordelijke    | Admin                                  |
| Clinical reference | Référence clinique  | Klinische referentie | Base de données                        |
| Difficulty level   | Niveau ◆◆◆◇◇        | Niveau ◆◆◆◇◇         | Facile/Difficile                       |
| Correct answer     | Bonne réponse       | Juist antwoord       | —                                      |
| Incorrect answer   | Axe de progression  | Leerkans             | Mauvaise réponse, Faux                 |
| Weekly streak      | Série hebdomadaire  | Weekreeks            | Streak                                 |

---

## 3. Typography

### 3.1 Font Stack

My VET&GO uses a dual-font system that bridges the VET&GO brand heritage with a modern professional platform identity.

#### Brand Typography (from VET&GO charter)

| Role           | Font       | Weight | Charter usage                 |
| -------------- | ---------- | ------ | ----------------------------- |
| Brand wordmark | Filson Pro | Bold   | "VET&GO" logotype             |
| Brand tagline  | Filson Pro | Medium | "VETERINARY EMERGENCY CENTER" |

#### Platform Typography (My VET&GO)

Filson Pro replaces Dax Condensed as the display font across the platform. Its rounded terminals, generous proportions, and warm character are more aligned with VET&GO's brand personality — approachable yet professional. Dax Condensed's narrow, angular forms feel dated and clinical-cold rather than clinical-warm.

For the application UI — navigation, course content, clinical reference, dashboards — the system uses Inter for its screen-optimized legibility and neutral professionalism.

| Role                 | Font           | Weight         | Size range | Line height | Usage                                                                |
| -------------------- | -------------- | -------------- | ---------- | ----------- | -------------------------------------------------------------------- |
| **Display / Hero**   | Filson Pro     | Bold           | 40–64px    | 1.1         | Homepage hero, brand statements, section headings on marketing pages |
| **Section Header**   | Filson Pro     | Medium         | 28–36px    | 1.2         | Section titles within app (e.g., "Urgences/ECC", "Mes cursus")       |
| **UI Heading H1**    | Inter          | SemiBold (600) | 28–32px    | 1.25        | Page titles within the app                                           |
| **UI Heading H2**    | Inter          | SemiBold (600) | 22–24px    | 1.3         | Card group headers, module titles                                    |
| **UI Heading H3**    | Inter          | Medium (500)   | 18–20px    | 1.35        | Subsection headers, sidebar titles                                   |
| **Body**             | Inter          | Regular (400)  | 16px       | 1.5         | Running text, descriptions, clinical content                         |
| **Body Small**       | Inter          | Regular (400)  | 14px       | 1.45        | Metadata, timestamps, secondary info                                 |
| **Caption**          | Inter          | Medium (500)   | 12px       | 1.4         | Labels, badges, eyebrow text                                         |
| **Monospace / Code** | JetBrains Mono | Regular (400)  | 14px       | 1.5         | Drug dosages, clinical values, technical references                  |
| **Eyebrow**          | Inter          | SemiBold (600) | 11–12px    | 1.3         | Category labels, uppercase (tracked +0.08em)                         |

**Why Filson Pro for display:** Filson Pro's rounded, humanist character makes headlines feel warm and approachable — essential for a platform that must invite busy professionals back daily. Its generous letter spacing and soft terminals communicate confidence without rigidity. It's the typographic equivalent of a trusted colleague, not a corporate memo.

**Why Inter for the application UI:** Inter is designed for screens, supports Latin Extended (covers all FR/NL diacriticals), has excellent legibility at small sizes, and its variable weight axis enables smooth transitions. It reads neutrally professional — closer to Linear and Superhuman than to a learning app.

### 3.2 Typographic Scale

Based on a 1.25 ratio (Major Third), anchored at 16px body:

```
12px  — Caption
14px  — Body Small
16px  — Body (base)
20px  — H3
24px  — H2
28px  — H1 (app)
36px  — Section Header (Filson)
48px  — Display (Filson)
64px  — Hero (Filson)
```

### 3.3 Bilingual Typography Rules

French strings are typically 10–20% longer than Dutch equivalents. All UI components must be designed with a **35% text expansion margin** to accommodate both languages without layout shifts.

| Component | FR example                 | NL example               | Expansion |
| --------- | -------------------------- | ------------------------ | --------- |
| Button    | "Découvrir nos centres"    | "Ontdek onze centra"     | FR +15%   |
| Eyebrow   | "Dernières vidéos"         | "Laatste video's"        | FR +20%   |
| Nav item  | "Consultations & Conseils" | "Raadplegingen & Advies" | FR +12%   |
| CTA       | "En savoir plus"           | "Meer weten"             | FR +33%   |

**Rule:** Never truncate translated text. If a label overflows, the component must grow — not clip.

---

## 4. Imagery & Photography

### 4.1 Photography Direction

The VET&GO website uses two categories of photography:

**Clinical photography** — real veterinary staff in action, scrubs, consultation rooms, medical equipment. These images are desaturated slightly and overlaid with brand-color masks (the Figma hero uses a red gradient mask over clinical imagery). For My VET&GO:

- Use clinical photography for course thumbnails (procedural content)
- Always show real equipment, real settings, real professionals
- Color treatment: slight desaturation, warm white balance
- Never stock-photo-generic — images must feel specific to veterinary practice

**Animal photography** — warm, emotionally resonant images of pets. Used for empathy moments (the "About" section, testimonials, the advice section). For My VET&GO:

- Use for onboarding, empty states, achievement celebrations
- Warm color grading, natural light
- Species diversity: dogs, cats, NAC (rabbits, birds, reptiles)
- Never anthropomorphized — always natural behavior

### 4.2 Illustration Style

For diagrams, anatomical references, and procedural illustrations:

- Clean line drawings, 1.5px stroke weight
- Two-tone: neutral outline + accent color highlights
- Medical accuracy is non-negotiable — always validated by clinical staff
- Annotation style: numbered callouts with Inter Medium 12px labels

### 4.3 Image Masks & Shapes

The Figma design uses organic blob shapes to mask photography — not rectangular crops. These shapes echo the wave pattern language and create a distinctive, ownable visual signature.

```
Photo masks: organic blob shapes with smooth curves
Corner radius on cards: 12px (content), 50% (avatars)
Thumbnail ratio: 16:9 (video), 1:1 (avatar/profile), circular (steps)
```

---

## 5. Brand Signature Elements

### 5.1 Wave Pattern

The VET&GO website uses animated layered wave SVGs as section dividers — three overlapping wave shapes in varying opacities of the brand colors. This is a distinctive brand element that must carry into My VET&GO.

```
Usage:
- Section dividers between major content blocks on marketing pages
- Subtle background texture in hero areas
- Loading states (gentle wave animation)

Colors:
  Wave 1 (front): --primary at 100%    (tertiary teal)
  Wave 2 (mid):   --primary at 60%
  Wave 3 (back):  --primary at 30%

Height: 80–125px
Animation: gentle horizontal oscillation, 8–12s period, ease-in-out

RULE: Never use waves inside the application UI (course viewer, dashboard).
      Waves are reserved for brand moments and transitions.
```

### 5.2 ECG Pulse Line

From the Figma hero section — a horizontal ECG-style pulse line that reinforces the emergency medicine identity.

```
Usage:
- Hero section accent (behind/around headline)
- Loading animation (pulse travels left to right)
- Subtle background element on the login/onboarding screens

Color: --destructive (VET&GO red #D10A10) at 80% opacity
Stroke: 2px
Animation: continuous left-to-right travel, 3s period

RULE: The pulse line is a brand grace note, not a UI element.
      Use sparingly — hero, loading, login. Never in content areas.
```

---

## 6. Motion & Animation

### 6.1 Animation Principles

| Principle      | Implementation                                                         |
| -------------- | ---------------------------------------------------------------------- |
| **Purposeful** | Every animation communicates state change, not decoration              |
| **Quick**      | 150–300ms for micro-interactions, 300–500ms for layout transitions     |
| **Respectful** | Always respect `prefers-reduced-motion` — reduce to opacity crossfades |
| **Calm**       | Ease-out for entries, ease-in for exits. No bouncing, no overshoot.    |

### 6.2 Interaction Animations

| Interaction             | Duration | Easing      | Notes                           |
| ----------------------- | -------- | ----------- | ------------------------------- |
| Button hover            | 150ms    | ease-out    | Background color transition     |
| Card hover lift         | 200ms    | ease-out    | translateY(-2px) + border color |
| Modal open              | 250ms    | ease-out    | Scale from 0.95 + fade in       |
| Modal close             | 200ms    | ease-in     | Scale to 0.95 + fade out        |
| Sidebar collapse        | 300ms    | ease-in-out | Width transition                |
| Progress bar fill       | 600ms    | ease-out    | On value change                 |
| Competency radar update | 800ms    | ease-out    | Shape morph on data change      |
| Page transition         | 200ms    | ease-out    | Opacity crossfade               |
| Toast entry             | 300ms    | ease-out    | Slide in from top-right         |
| Toast exit              | 200ms    | ease-in     | Fade out                        |

### 6.3 Progress Node Animations (Pathway Map)

Inspired by Brilliant.org's Rive animations — satisfying micro-interactions that reward progress without being childish.

| State transition        | Animation                                            |
| ----------------------- | ---------------------------------------------------- |
| Not started → Available | Gentle pulse (opacity 0.6 → 1.0, 1s loop)            |
| Available → In progress | Fill from bottom, 400ms                              |
| In progress → Completed | Checkmark draws in, 300ms, haptic feedback on mobile |
| Completed → Mastered    | Gold shimmer sweep, 600ms, subtle particle burst     |

---

## 7. Platform Personality Summary

If My VET&GO were a person, they would be:

**A senior emergency veterinarian who also happens to be a brilliant teacher.** They've seen everything — the 3 AM gastric dilatation-volvulus, the toxicology case with no clear history, the cardiac arrest that responded to a protocol they learned last month. They're calm under pressure, precise in their language, generous with their knowledge, and deeply respectful of their colleagues' time. They never talk down to you. They never waste your time. They hand you exactly what you need, exactly when you need it.

They wear scrubs, not a suit. They speak your language — literally (FR or NL, your choice). They've got a quiet confidence that comes from competence, not from titles. And when you've just nailed a difficult clinical assessment, they give you a nod — not a standing ovation. Because you're a professional, and so are they.

That's the emotional register of every screen, every interaction, every notification, every loading state in My VET&GO.

---

## 8. Do's and Don'ts — Brand & Tone

### Do's

- **Do** default to dark mode and design dark-first
- **Do** use clinical framing for assessments ("Évaluation clinique", not "Quiz")
- **Do** provide Senior DVM Insight callouts to create mentorship feeling
- **Do** use Inter for application UI and Filson Pro for brand display moments
- **Do** present drug dosages and clinical values in JetBrains Mono
- **Do** show clinical photography with real veterinary settings
- **Do** use `FR | NL` text labels for language switching
- **Do** design all text components with 35% expansion margin for FR/NL
- **Do** respect `prefers-reduced-motion` in all animations

### Don'ts

- **Don't** use flags for language selection — Belgium's linguistic politics make flag icons inappropriate
- **Don't** use cartoon or anthropomorphized animal illustrations — keep imagery clinical and professional
- **Don't** use gamification language ("points", "badges", "leaderboard") — use professional equivalents
- **Don't** call users "students" or "learners" — they are "practitioners" (praticiens/beoefenaars)
- **Don't** use "wrong" or "failed" language in assessment feedback — reframe as growth opportunities
- **Don't** add sponsored content markers or pharma-branded sections — the platform is editorially independent
- **Don't** design components that only work in one language — always test with both FR and NL strings

---

_Part of the My VET&GO Design System. See also: [UX Patterns](./03b-ux-patterns.md) · [Design Tokens](./03c-design-tokens.md)_
