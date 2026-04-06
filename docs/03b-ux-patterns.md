# My VET&GO — UX/UI Design Patterns & Considerations

**Version:** 1.1 — April 2026
**Author:** Arnaud (OSTRO Brothers SRL)
**Status:** Foundation — ready for UI design
**Scope:** My VET&GO Galaxy learning platform (web, responsive, future native)
**Stack:** Next.js · Tailwind CSS v4 · shadcn/ui · Nivo charts

> This document covers layout, iconography, component patterns, responsive behavior, and accessibility. For brand identity and tone see [03a-brand-identity.md](./03a-brand-identity.md). For design tokens see [03c-design-tokens.md](./03c-design-tokens.md).

---

## 1. Spacing & Layout

### 1.1 Spacing Scale

Based on a 4px grid with an 8px base unit. Maps directly to Tailwind's default spacing scale.

| Token        | Value | Tailwind | Usage                                 |
| ------------ | ----- | -------- | ------------------------------------- |
| `--space-0`  | 0px   | `0`      | —                                     |
| `--space-1`  | 4px   | `1`      | Tight gaps, icon-to-label             |
| `--space-2`  | 8px   | `2`      | Inline spacing, badge padding         |
| `--space-3`  | 12px  | `3`      | Input padding, small card padding     |
| `--space-4`  | 16px  | `4`      | Standard padding, between form fields |
| `--space-5`  | 20px  | `5`      | Card padding                          |
| `--space-6`  | 24px  | `6`      | Section padding (mobile)              |
| `--space-8`  | 32px  | `8`      | Section gaps                          |
| `--space-10` | 40px  | `10`     | Content area margins                  |
| `--space-12` | 48px  | `12`     | Section spacing                       |
| `--space-16` | 64px  | `16`     | Major section breaks                  |
| `--space-20` | 80px  | `20`     | Page-level vertical rhythm            |
| `--space-24` | 96px  | `24`     | Hero padding                          |

### 1.2 Grid System

| Breakpoint  | Name    | Columns | Gutter | Margin | Max width |
| ----------- | ------- | ------- | ------ | ------ | --------- |
| 0–639px     | Mobile  | 4       | 16px   | 16px   | 100%      |
| 640–1023px  | Tablet  | 8       | 24px   | 24px   | 100%      |
| 1024–1439px | Desktop | 12      | 24px   | 40px   | 100%      |
| 1440px+     | Wide    | 12      | 24px   | auto   | 1200px    |

The VET&GO website uses a 1440px canvas with 120px margins and 1200px content width. My VET&GO inherits this grid for marketing/landing pages but uses a fluid layout for the application shell (sidebar + content area).

### 1.3 Application Layout Structure

```
┌─────────────────────────────────────────────────────┐
│  Top Bar (48px height)                               │
│  [Logo] [Search / Cmd+K] [Lang] [Profile] [Theme]   │
├──────────┬──────────────────────────────────────────┤
│ Sidebar  │  Content Area                             │
│ (240px)  │                                           │
│          │  ┌──────────────────────────────────────┐ │
│ Nav      │  │  Page Header                         │ │
│ items    │  │  (breadcrumb + title + actions)       │ │
│          │  ├──────────────────────────────────────┤ │
│ Sections │  │  Main Content                        │ │
│ grouped  │  │  (scrollable, max-width 960px        │ │
│          │  │   for reading content)                │ │
│ Collapse │  │                                       │ │
│ on       │  └──────────────────────────────────────┘ │
│ mobile   │                                           │
├──────────┴──────────────────────────────────────────┤
│  Mobile: Bottom Navigation (56px)                    │
│  [Home] [Explore] [Search] [Progress] [Profile]      │
└─────────────────────────────────────────────────────┘
```

**Video learning layout (desktop):**

```
┌──────────────────────────────────────────────────────┐
│  ┌──────────────────────┬─────────────────────────┐  │
│  │  Video Player        │  Sidebar (30–40%)       │  │
│  │  (60–70%)            │  ┌───────────────────┐  │  │
│  │                      │  │ Tabs:             │  │  │
│  │  [chaptered playbar] │  │ Chapters │ Transc │  │  │
│  │  [speed] [theater]   │  │ Notes │ Resources │  │  │
│  │                      │  │                   │  │  │
│  │                      │  │ (synced content)  │  │  │
│  └──────────────────────┴─────────────────────────┘  │
│  [Continue to next chapter →]                         │
└──────────────────────────────────────────────────────┘
```

---

## 2. Iconography

### 2.1 Icon System — HugeIcons Rounded

My VET&GO uses **HugeIcons Rounded** as its primary and only icon library. The rounded stroke style aligns with the platform's personality: premium without being cold, approachable without being childish, tech-forward without being sterile. The soft terminals echo Filson Pro's rounded character, creating a cohesive visual language.

| Layer                 | Style                              | Size    | Stroke | Notes                                         |
| --------------------- | ---------------------------------- | ------- | ------ | --------------------------------------------- |
| **UI Navigation**     | HugeIcons Rounded (Solid variant)  | 20px    | —      | Sidebar nav, tab bar, status indicators       |
| **UI Actions**        | HugeIcons Rounded (Stroke variant) | 24px    | 1.5px  | Toolbar actions, card actions, inline buttons |
| **Section Eyebrows**  | HugeIcons Rounded (Stroke variant) | 16px    | 1.5px  | Scaled down, color-matched to eyebrow text    |
| **Specialty Badges**  | HugeIcons Rounded (Bulk variant)   | 32–48px | —      | Two-tone: accent fill + neutral stroke        |
| **Status Indicators** | System dots/rings                  | 8–12px  | —      | Semantic color fills                          |

**Why not Heroicons, Lucide, or Phosphor?**

- Heroicons (in the current Figma file) has a sharp, utilitarian feel — great for developer tools, but lacks the warmth My VET&GO needs.
- Lucide is clean but generic — widely used in shadcn/ui defaults, making it hard to differentiate.
- Phosphor Rounded is a strong alternative but has a smaller catalog. HugeIcons offers **4,000+ icons** in the Rounded style, covering medical, education, and UI categories comprehensively.

**Implementation:** Install via `@hugeicons/react` (tree-shakeable, each icon ~200 bytes). Use the `strokeRounded` variant for most UI, `solidRounded` for filled/active states, and `bulkRounded` for large specialty badges where a two-tone effect is needed.

```tsx
import { Stethoscope02Icon } from '@hugeicons/core-free-icons';
import { HugeiconsIcon } from '@hugeicons/react';

<HugeiconsIcon icon={Stethoscope02Icon} size={24} />;
```

### 2.2 Icon Usage Rules

| Context                       | Variant        | Size | Color                      |
| ----------------------------- | -------------- | ---- | -------------------------- |
| Sidebar navigation (inactive) | Stroke Rounded | 20px | `text-muted-foreground`    |
| Sidebar navigation (active)   | Solid Rounded  | 20px | `text-primary`             |
| Button with label             | Stroke Rounded | 18px | Inherits button text color |
| Button icon-only              | Stroke Rounded | 20px | `text-foreground`          |
| Input prefix/suffix           | Stroke Rounded | 16px | `text-muted-foreground`    |
| Eyebrow label                 | Stroke Rounded | 16px | Same as eyebrow text       |
| Toast / alert                 | Stroke Rounded | 20px | Semantic color             |
| Empty state                   | Stroke Rounded | 48px | `text-muted-foreground`    |
| Specialty badge (course card) | Bulk Rounded   | 32px | Specialty accent + neutral |

**Consistency rule:** Never mix HugeIcons Rounded with other icon libraries. If an edge-case icon doesn't exist in HugeIcons, design a custom one following the Rounded style parameters: 1.5px stroke, round line caps, round line joins, 24px canvas with 2px padding.

### 2.3 Specialty Iconography

Each veterinary specialty uses a HugeIcons Rounded icon in its Bulk variant (two-tone: specialty accent fill + neutral stroke outline). These must be immediately recognizable by veterinary professionals and functional at 24px (sidebar nav) and 48px (card header).

| Specialty       | HugeIcons icon name       | Notes                                    |
| --------------- | ------------------------- | ---------------------------------------- |
| Urgences / ECC  | `pulse-02` or `heartbeat` | ECG reference, brand heritage            |
| Anesthésie      | `injection`               | Syringe — universal clinical association |
| Imagerie        | `x-ray` or `scan`         | Diagnostic visual                        |
| Dentisterie     | `dental-tooth`            | Clinical, not cartoon                    |
| Dermatologie    | `search` + custom         | Dermatoscope reference                   |
| Chirurgie       | `scalpel`                 | Clean, professional                      |
| Oncologie       | `microscope`              | Medical precision                        |
| Comportement    | `brain-02`                | Neurobehavioral                          |
| Médecine féline | `cat`                     | Geometric, elegant                       |
| Cardiologie     | `heart-check`             | Anatomical check, not emoji              |
| Neurologie      | `brain`                   | Anatomical                               |
| NAC             | `rabbit`                  | Matches platform animal categories       |

### 2.4 Animal Category Icons (from charter)

The Figma design includes circular animal category icons for the "Besoin de conseils?" section:

- **Chien** (dog) — circular frame, 96×96px, photographic/illustrated style
- **Chat** (cat) — same treatment
- **NAC** (rabbit) — same treatment

These icons sit inside rounded containers with a subtle background fill. For My VET&GO, this pattern extends to species-based content filtering (Canine / Feline / Exotic toggle in search).

---

## 3. Component Patterns

All components are built on **shadcn/ui** primitives and extended with VET&GO theming. Components use shadcn's token convention (`bg-primary`, `text-foreground`, etc.) — see [03c-design-tokens.md](./03c-design-tokens.md) for the full mapping.

### 3.1 Buttons

#### Primary Button (Brand Teal)

Used for the main action on a page. One per viewport.

```
Background: bg-primary          (tertiary teal #00808C)
Text:       text-primary-foreground (#FFFFFF)
Font:       Inter SemiBold 16px
Padding:    16px 32px
Radius:     radius-md (shadcn --radius)
Min-height: 48px (touch target)
Min-width:  120px

States:
  Hover:    bg-primary/90
  Active:   bg-primary/80
  Focus:    ring-2 ring-ring ring-offset-2
  Disabled: opacity-40, cursor-not-allowed
```

#### Emergency CTA Button (Brand Red)

Reserved exclusively for emergency actions: calling the clinic, accessing the emergency hotline (1717).

```
Background: bg-destructive       (VET&GO red #D10A10)
Text:       text-destructive-foreground (#FFFFFF)
Font:       Inter Bold 18px
Padding:    20px 32px
Radius:     radius-md

RULE: This button style appears ONLY for emergency phone/action CTAs.
Never use red buttons for "Delete", "Cancel", or navigation.
```

#### Secondary Button (Outline)

```
Background: bg-transparent
Border:     border border-input
Text:       text-foreground
Font:       Inter Medium 16px
Padding:    14px 24px
Radius:     radius-md

Hover: bg-accent text-accent-foreground
```

#### Ghost Button (Text-only)

```
Background: bg-transparent
Text:       text-primary (teal)
Font:       Inter Medium 14px
Padding:    8px 12px

Hover: bg-accent
Used for: "En savoir plus →", inline actions, sidebar items
```

### 3.2 Cards

#### Course Card

```
┌──────────────────────────────────┐
│  [Thumbnail — 16:9 ratio]        │
│  ┌────────────────────────────┐  │
│  │ [FR] [NL]  ⏱ 2h30  🎓 4CE │  │
│  │                            │  │
│  │ Anesthésie brachycéphale   │  │
│  │ du chat : protocoles       │  │
│  │                            │  │
│  │ ████████░░ 65% complété    │  │
│  │                            │  │
│  │ Chapitre 4 · ~8 min restant│  │
│  └────────────────────────────┘  │
└──────────────────────────────────┘

Background:  bg-card
Border:      border border-border
Radius:      radius-lg (12px)
Padding:     0 (thumbnail bleeds to top)
Content:     p-4
Shadow:      shadow-sm (light mode only; none in dark)

Hover: border-primary, translateY(-2px)
```

#### Review/Testimonial Card (from Figma)

The Figma design shows clinic review cards (Uccle 4.5, Woluwe 4.6, Corbais 4.2, Namur 4.6) with colored accent backgrounds. For My VET&GO, this pattern adapts to **specialist testimonial cards** and **clinic rating cards**.

```
Background: bg-primary or specialty accent
Radius:     radius-lg
Content:    rating number (large, Filson Pro Bold), name, brief quote
```

### 3.3 Navigation

#### Eyebrow Label (from Figma)

A distinctive VET&GO pattern: small icon + uppercase label above section headings.

```
[●] A PROPOS          [♥] NOS CLINIQUES          [☀] SERVICES DE JOUR

Icon:    12×12px, semantic or section-specific
Gap:     8px between icon and text
Font:    Inter SemiBold 11px, uppercase, letter-spacing +0.08em
Color:   text-muted-foreground (or specialty accent)
```

#### Breadcrumb

```
Urgences/ECC  ›  Polytrauma  ›  Chapitre 3 : Choc hypovolémique

Font:         Inter Regular 14px
Separator:    › (right angle bracket)
Current page: Inter Medium, text-foreground
Parent pages: text-primary, clickable
```

#### Language Toggle

```
FR | NL

Font:       Inter Medium 14px
Active:     text-foreground, underline 2px border-primary
Inactive:   text-muted-foreground
Separator:  | in text-muted-foreground

Position: top-right of header bar
RULE: Never use flags. Text only.
```

### 3.4 Progress Indicators

#### Linear Progress Bar

```
Track:  4px height, bg-muted
Fill:   4px height, bg-primary (or specialty accent)
Corner: radius-full

Label (optional): "65% complété" — Inter Regular 12px
```

#### Competency Radar Chart

7–9 axes mapped to veterinary specialties. Two overlaid shapes:

```
Current Level: solid fill, primary at 30% opacity, solid stroke
Target Level:  dashed stroke, text-muted-foreground

Axes:  specialty names in Inter Medium 12px
Scale: 0–5 (Novice → Expert), concentric pentagons/polygons

Click on axis gap → recommended CE courses
```

#### CE Credit Counter (Ring)

```
Apple Fitness-inspired ring, 3 concentric:
  Outer:  CE Credits earned (primary)
  Middle: Assessments passed (chart-2, success green)
  Inner:  Specialties engaged (specialty accent blend)

Center: "12/20 CE" — Inter SemiBold 18px
Label:  "Cycle 2024–2026"
```

#### Weekly Streak

```
Peloton-style weekly (not daily) streak.
7 dots for Mon–Sun, filled = activity day.
Count: "12 semaines" — Inter SemiBold 14px
Icon:  HugeIcons `fire` Rounded (chart-4, amber when active)
```

### 3.5 Assessment / Quiz Components

#### Clinical Case Question

```
┌──────────────────────────────────────────────────────┐
│  ÉVALUATION CLINIQUE · Question 4/10 · ◆◆◆◇◇        │
│                                                       │
│  Un chat européen mâle castré de 8 ans est présenté  │
│  en urgence pour dyspnée aiguë. La radiographie      │
│  thoracique montre...                                 │
│                                                       │
│  [Image: radiographie thoracique]                     │
│                                                       │
│  ○  Épanchement pleural bilatéral                     │
│  ○  Pneumothorax                                      │
│  ○  Cardiomégalie avec œdème pulmonaire               │
│  ○  Masse médiastinale                                │
│                                                       │
│  Votre confiance : [Faible] [Moyenne] [Élevée]        │
│                                                       │
│  [Valider ma réponse]                                 │
└──────────────────────────────────────────────────────┘

Difficulty:    ◆ filled diamonds (1–5), à la AMBOSS hammer
Confidence:    3 ghost buttons, mutually exclusive
Answer options: radio buttons with generous 48px tap targets
```

#### Post-Answer Explanation

```
┌──────────────────────────────────────────────────────┐
│  ✓ Bonne réponse — Cardiomégalie avec œdème          │
│                                                       │
│  Explication pour chaque choix :                      │
│                                                       │
│  ✓ Cardiomégalie avec œdème pulmonaire               │
│    Le VHS de 9.2 et la distribution péri-hilaire...  │
│                                                       │
│  ✗ Épanchement pleural bilatéral                     │
│    L'absence de rétraction lobaire et...             │
│                                                       │
│  ┌──────────────────────────────────────────────┐    │
│  │ 💡 CONSEIL SENIOR DVM                        │    │
│  │ "En pratique d'urgence, je regarde toujours  │    │
│  │ le VHS avant de considérer..."               │    │
│  └──────────────────────────────────────────────┘    │
│                                                       │
│  72% des praticiens ont répondu correctement          │
│                                                       │
│  [Question suivante →]                                │
└──────────────────────────────────────────────────────┘

Correct:        chart-2 (success green) background tint, check icon
Incorrect:      destructive icon, but neutral background
Senior DVM:     bg-muted callout box with 💡 icon
Peer comparison: text-muted-foreground, factual, non-judgmental
```

### 3.6 Search / Command Palette (Cmd+K)

```
┌──────────────────────────────────────────────────────┐
│  🔍 Rechercher ou taper une commande...    ⌘K        │
│                                                       │
│  Résultats                                            │
│  ─────────                                            │
│  📚 Anesthésie brachycéphale — Cursus Anesthésie     │
│  🧠 Protocole midazolam chat — Réf. clinique IA      │
│  📊 Mes crédits FC — Tableau de bord                 │
│                                                       │
│  Actions rapides                                      │
│  ─────────                                            │
│  ▶  Reprendre la dernière vidéo                       │
│  🌙  Basculer dark/light mode                         │
│  🌐  Changer la langue                                │
└──────────────────────────────────────────────────────┘

Background:   bg-popover with backdrop-blur
Border:       border border-border
Radius:       radius-lg
Width:        640px (centered), max-height 480px
Input font:   Inter Regular 16px
Result font:  Inter Regular 14px, HugeIcons Rounded 16px
Shortcut:     JetBrains Mono 12px, text-muted-foreground
```

---

## 4. Responsive Behavior

### 4.1 Breakpoint Strategy

| Breakpoint                | Layout changes                                                                                                                                     |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Mobile (< 640px)**      | Single column. Bottom tab navigation. Sidebar hidden. Full-width cards. Video player stacks above sidebar tabs. Sticky mini-player when scrolling. |
| **Tablet (640–1023px)**   | Two-column grid where appropriate. Sidebar becomes slide-over drawer. Video player at full width, sidebar tabs below.                              |
| **Desktop (1024–1439px)** | Full application layout. Collapsible sidebar (240px). 60/40 split for video + sidebar. Command palette (Cmd+K).                                    |
| **Wide (1440px+)**        | Content max-width 1200px, centered. Generous margins. Three-column layouts for card grids.                                                         |

### 4.2 Mobile-Specific Patterns

- **Bottom navigation:** 5 items max (Home, Explore, Search, Progress, Profile), 56px height, icons 24px + label 10px
- **Touch targets:** 48×48px minimum (Android standard)
- **Thumb zone:** Primary actions in bottom 40% of screen
- **Swipe gestures:** Swipe between course chapters, swipe to dismiss modals
- **Mini-player:** Persistent bottom bar (64px) showing current video playback when navigating away
- **Offline indicator:** Subtle banner at top when offline, with sync status

---

## 5. Accessibility

### 5.1 Compliance Target

**WCAG 2.2 Level AA** minimum. European Accessibility Act (EAA) compliance is mandatory (effective June 2025).

### 5.2 Checklist

| Requirement         | Implementation                                                                       |
| ------------------- | ------------------------------------------------------------------------------------ |
| Color contrast      | 4.5:1 for normal text, 3:1 for large text and UI components                          |
| Focus indicators    | 2px outline, ring color, 2px offset. Visible in both themes.                         |
| Keyboard navigation | Full tab navigation, arrow keys in menus, Escape to close modals                     |
| Screen reader       | Semantic HTML, ARIA labels on interactive elements, live regions for dynamic content |
| Motion sensitivity  | `prefers-reduced-motion` support — reduce all animations to simple crossfades        |
| Text scaling        | UI readable up to 200% browser zoom without horizontal scrolling                     |
| Alternative text    | All clinical images, diagrams, and video thumbnails have descriptive alt text        |
| Video accessibility | Captions (FR/NL) on all video content. Transcript panel always available.            |
| Color independence  | Status never conveyed by color alone — always paired with icon + label               |

---

## 6. Do's and Don'ts — UX/UI

### Do's

- **Do** use tertiary teal (`bg-primary`) as the primary interactive color
- **Do** reserve red (`bg-destructive`) exclusively for emergency CTAs and critical alerts
- **Do** use the wave pattern for brand moments and section transitions only
- **Do** show progress visually at every opportunity (bars, rings, radars)
- **Do** use the shadcn command palette pattern for search (Cmd+K)

### Don'ts

- **Don't** use red for standard destructive actions (Delete, Cancel) — use outlined/ghost buttons instead
- **Don't** use wave patterns inside the application chrome (course viewer, dashboard)
- **Don't** use pure black (#000000) in dark mode — use `bg-background` (brand-tinted deep teal) to maintain brand tint
- **Don't** use light mode as default — dark mode is the primary surface
- **Don't** truncate labels to fit — let the component grow

---

_Part of the My VET&GO Design System. See also: [Brand Identity](./03a-brand-identity.md) · [Design Tokens](./03c-design-tokens.md)_
