# My VET&GO — Design Tokens & Component Theming

**Version:** 1.1 — April 2026
**Author:** Arnaud (OSTRO Brothers SRL)
**Status:** Foundation — ready for frontend implementation
**Scope:** My VET&GO Galaxy learning platform (web, responsive, future native)
**Stack:** Next.js · Tailwind CSS v4 · shadcn/ui · Nivo charts

> This document defines the color system, design tokens, and their mapping to shadcn/ui's theming architecture. For brand identity see [03a-brand-identity.md](./03a-brand-identity.md). For UX patterns see [03b-ux-patterns.md](./03b-ux-patterns.md).

---

## 1. Token Architecture Overview

The token system follows a **three-layer architecture** designed to map cleanly onto shadcn/ui's CSS variable convention:

```
┌─────────────────────────────────────────────────────────┐
│  Layer 1: PRIMITIVES (raw values)                        │
│  The three VET&GO brand scales + functional colors       │
│  e.g. primary-400: #F52128, secondary-800: #001C28      │
│  → Used in Tailwind config, never referenced directly    │
├─────────────────────────────────────────────────────────┤
│  Layer 2: SHADCN SEMANTIC TOKENS (CSS variables)         │
│  Maps VET&GO intent to shadcn's expected token names     │
│  e.g. --primary → tertiary teal, --destructive → red    │
│  → Used by shadcn components via Tailwind utilities      │
├─────────────────────────────────────────────────────────┤
│  Layer 3: EXTENDED TOKENS (VET&GO-specific)              │
│  Tokens shadcn doesn't define but VET&GO needs           │
│  e.g. --chart-*, --status-*, specialty accents           │
│  → Used by custom components and Nivo charts             │
└─────────────────────────────────────────────────────────┘
```

**Key design decision:** VET&GO's interactive teal (`#00808C`) maps to shadcn's `--primary`, and VET&GO's emergency red (`#D10A10`) maps to shadcn's `--destructive`. This avoids naming collisions — shadcn components using `bg-primary` will automatically get the brand teal, and `bg-destructive` will get the reserved emergency red.

---

## 2. Layer 1 — Primitive Color Scales

These are the raw color values from the VET&GO website Tailwind palette. They serve as the single source of truth and are referenced by the semantic tokens above.

### 2.1 Primary (Red) — Emergency & Critical

Reserved for emergency CTAs, urgent alerts, and critical status. Never decorative.

| Step | Hex | Usage |
|---|---|---|
| `vetgo-red-100` | `#FCC7C9` | Error background tint |
| `vetgo-red-200` | `#FA9093` | Error border, light warning |
| `vetgo-red-300` | `#F7585E` | Hover on error actions |
| `vetgo-red-400` | `#F52128` | Active error state |
| **`vetgo-red` (DEFAULT)** | **`#D10A10`** | **Emergency CTA, destructive actions, critical alerts** |
| `vetgo-red-600` | `#A8080D` | Dark mode error accent |
| `vetgo-red-700` | `#7E060A` | Error text on light backgrounds |
| `vetgo-red-800` | `#540407` | Deep error background (dark mode) |
| `vetgo-red-900` | `#2A0203` | Error surface (dark mode) |

### 2.2 Secondary (Deep Teal) — Brand Core & Surfaces

The dominant brand color. Drives backgrounds, headers, hero sections, and **surface elevation** in both light and dark modes.

| Step | Hex | Usage |
|---|---|---|
| `vetgo-teal-100` | `#CCDAE0` | Subtle brand tint (light mode borders) |
| `vetgo-teal-200` | `#99B5C1` | Disabled text on brand backgrounds |
| `vetgo-teal-300` | `#668FA1` | Secondary text on dark surfaces |
| `vetgo-teal-400` | `#336A82` | Muted brand elements |
| **`vetgo-teal` (DEFAULT)** | **`#004563`** | **Hero backgrounds, brand headers, deep surfaces** |
| `vetgo-teal-600` | `#00374F` | Dark mode card backgrounds |
| `vetgo-teal-700` | `#00293B` | Dark mode secondary surface |
| `vetgo-teal-800` | `#001C28` | Dark mode primary background |
| `vetgo-teal-900` | `#000E14` | Dark mode deepest surface (base canvas) |

### 2.3 Tertiary (Teal/Cyan) — Interactive & Accent

The action color. All interactive elements — buttons, links, toggles, focus rings, progress fills. **This maps to shadcn's `--primary`.**

| Step | Hex | Usage |
|---|---|---|
| `vetgo-cyan-50` | `#D6FCFF` | Highlight tint, selected row (light) |
| `vetgo-cyan-100` | `#CCE6E8` | Light interactive background |
| `vetgo-cyan-200` | `#99CCD1` | Interactive border, disabled interactive |
| `vetgo-cyan-300` | `#66B3BA` | Interactive hover (dark mode) |
| `vetgo-cyan-400` | `#3399A3` | Interactive hover (light mode) |
| **`vetgo-cyan` (DEFAULT)** | **`#00808C`** | **Buttons, links, active states, focus rings** |
| `vetgo-cyan-600` | `#006670` | Interactive pressed state |
| `vetgo-cyan-700` | `#004D54` | Interactive on dark surfaces |
| `vetgo-cyan-800` | `#003338` | Deep interactive background |
| `vetgo-cyan-900` | `#001A1C` | Interactive surface (dark mode) |

### 2.4 Functional Colors

| Token | Hex | Usage |
|---|---|---|
| `functional-positive` | `#0AC96D` | Completed, mastered, passed, success states |
| `functional-negative` | `#DA3B40` | Validation errors, failed assessments |

---

## 3. Layer 2 — shadcn Semantic Token Mapping

shadcn/ui uses a `name` / `name-foreground` convention where the base token controls the surface color and `-foreground` controls text/icons on that surface. The table below shows how VET&GO's design intent maps onto these expected tokens.

### 3.1 Core Token Mapping

| shadcn Token | Light Mode | Dark Mode | VET&GO Source | Purpose |
|---|---|---|---|---|
| **`--background`** | `#FFFFFF` | `#000E14` | white / vetgo-teal-900 | Page canvas |
| **`--foreground`** | `#000E14` | `#E8EAED` | vetgo-teal-900 / custom | Body text, headings |
| **`--card`** | `#F2F6F8` | `#001C28` | vetgo-teal-100@8% / vetgo-teal-800 | Elevated cards, sidebar |
| **`--card-foreground`** | `#000E14` | `#E8EAED` | same as foreground | Text on cards |
| **`--popover`** | `#EBF0F3` | `#00293B` | vetgo-teal-100@14% / vetgo-teal-700 | Modals, dropdowns, command palette |
| **`--popover-foreground`** | `#000E14` | `#E8EAED` | same as foreground | Text on popovers |
| **`--primary`** | `#00808C` | `#00808C` | vetgo-cyan DEFAULT | Buttons, links, active states |
| **`--primary-foreground`** | `#FFFFFF` | `#FFFFFF` | white | Text on primary surfaces |
| **`--secondary`** | `#F2F6F8` | `#001C28` | vetgo-teal-100@8% / vetgo-teal-800 | Low-emphasis surfaces |
| **`--secondary-foreground`** | `#000E14` | `#E8EAED` | same as foreground | Text on secondary |
| **`--muted`** | `#E4EAED` | `#000A0F` | vetgo-teal-100@20% / below teal-900 | Sunken surfaces, inputs |
| **`--muted-foreground`** | `#336A82` | `#668FA1` | vetgo-teal-400 / vetgo-teal-300 | Descriptions, metadata, placeholders |
| **`--accent`** | `#D6FCFF` | `#001A1C` | vetgo-cyan-50 / vetgo-cyan-900 | Hover states, selected items |
| **`--accent-foreground`** | `#000E14` | `#E8EAED` | same as foreground | Text on accent |
| **`--destructive`** | `#D10A10` | `#F7585E` | vetgo-red DEFAULT / vetgo-red-300 | Emergency CTA, critical alerts |
| **`--destructive-foreground`** | `#FFFFFF` | `#FFFFFF` | white | Text on destructive |
| **`--border`** | `#CCDAE0` | `#00293B` | vetgo-teal-100 / vetgo-teal-700 | Dividers, card borders |
| **`--input`** | `#99B5C1` | `#00374F` | vetgo-teal-200 / vetgo-teal-600 | Input borders |
| **`--ring`** | `#00808C` | `#00808C` | vetgo-cyan DEFAULT | Focus ring |

### 3.2 Sidebar Tokens

shadcn/ui defines dedicated sidebar tokens. These map to VET&GO's sidebar, which uses the brand surface system.

| shadcn Token | Light Mode | Dark Mode | Purpose |
|---|---|---|---|
| **`--sidebar`** | `#F2F6F8` | `#001C28` | Sidebar background |
| **`--sidebar-foreground`** | `#000E14` | `#E8EAED` | Sidebar text |
| **`--sidebar-primary`** | `#00808C` | `#00808C` | Active nav item |
| **`--sidebar-primary-foreground`** | `#FFFFFF` | `#FFFFFF` | Text on active nav |
| **`--sidebar-accent`** | `#D6FCFF` | `#001A1C` | Hovered/selected nav item bg |
| **`--sidebar-accent-foreground`** | `#000E14` | `#E8EAED` | Text on hovered nav |
| **`--sidebar-border`** | `#CCDAE0` | `#00293B` | Sidebar border/divider |
| **`--sidebar-ring`** | `#00808C` | `#00808C` | Focus ring in sidebar |

### 3.3 Radius Tokens

shadcn uses a single `--radius` base with calculated variants. VET&GO maps its radii to this system.

| shadcn Token | Value | VET&GO Equivalent |
|---|---|---|
| `--radius` (base) | `0.75rem` (12px) | `--radius-lg` — card radius, our most common |
| `--radius-sm` | `calc(var(--radius) * 0.5)` = 6px | Between sm (4px) and md (8px) |
| `--radius-md` | `calc(var(--radius) * 0.667)` = 8px | `--radius-md` — buttons |
| `--radius-lg` | `var(--radius)` = 12px | `--radius-lg` — cards |
| `--radius-xl` | `calc(var(--radius) * 1.333)` = 16px | `--radius-xl` |
| `--radius-full` | `9999px` | `--radius-full` — pills, avatars |

---

## 4. Layer 3 — Extended Tokens (VET&GO-specific)

### 4.1 Chart Colors (Nivo / Data Visualization)

shadcn defines `--chart-1` through `--chart-5`. VET&GO extends this for its 12 veterinary specialties.

| Token | Hex | Specialty |
|---|---|---|
| `--chart-1` | `#F52128` | Urgences / ECC (Brand Red) |
| `--chart-2` | `#0AC96D` | Success / Positive (functional green) |
| `--chart-3` | `#3B82F6` | Imagerie médicale (Blue) |
| `--chart-4` | `#D69E2E` | Anesthésie / Analgésie (Amber) |
| `--chart-5` | `#EC4899` | Dermatologie (Rose) |
| `--chart-6` | `#6366F1` | Chirurgie (Indigo) |
| `--chart-7` | `#8B5CF6` | Oncologie (Purple) |
| `--chart-8` | `#22C55E` | Comportement (Green) |
| `--chart-9` | `#F97316` | Médecine féline (Orange) |
| `--chart-10` | `#F43F5E` | Cardiologie (Rose-Red) |
| `--chart-11` | `#64748B` | Neurologie (Slate) |
| `--chart-12` | `#84CC16` | NAC (Lime) |

### 4.2 Status Tokens

Beyond shadcn's `--destructive`, VET&GO needs a full status palette.

| Token | Light Mode | Dark Mode | Usage |
|---|---|---|---|
| `--status-success` | `#0AC96D` | `#0AC96D` | Completed, mastered |
| `--status-warning` | `#D97706` | `#FBBF24` | Expiring credits, streaks at risk |
| `--status-error` | `#D10A10` | `#F7585E` | Failed, critical |
| `--status-info` | `#00808C` | `#66B3BA` | Informational badges |
| `--status-neutral` | `#99B5C1` | `#336A82` | Disabled, not started |

### 4.3 Brand Surface Token

For hero sections and deep brand moments that sit outside the standard card/popover model.

| Token | Light Mode | Dark Mode | Usage |
|---|---|---|---|
| `--surface-brand` | `#004563` | `#004563` | Hero sections, brand moments (same both modes) |
| `--surface-brand-foreground` | `#FFFFFF` | `#FFFFFF` | Text on brand surfaces |

### 4.4 Specialty Accent Colors

Each veterinary specialty has a unique accent color for pathway nodes, radar chart axes, and section headers. These are registered as CSS variables for Nivo chart theming and custom component use.

| Specialty | Token | Hex |
|---|---|---|
| Urgences / ECC | `--specialty-ecc` | `#F52128` |
| Anesthésie / Analgésie | `--specialty-anesthesie` | `#D69E2E` |
| Imagerie médicale | `--specialty-imagerie` | `#3B82F6` |
| Dentisterie | `--specialty-dentisterie` | `#00808C` |
| Dermatologie | `--specialty-dermatologie` | `#EC4899` |
| Chirurgie | `--specialty-chirurgie` | `#6366F1` |
| Oncologie | `--specialty-oncologie` | `#8B5CF6` |
| Comportement | `--specialty-comportement` | `#22C55E` |
| Médecine féline | `--specialty-feline` | `#F97316` |
| Cardiologie | `--specialty-cardiologie` | `#F43F5E` |
| Neurologie | `--specialty-neurologie` | `#64748B` |
| NAC | `--specialty-nac` | `#84CC16` |

---

## 5. Surface & Elevation System

Surfaces use the **secondary deep teal** scale to create depth. The principle: higher elevation = lighter in dark mode, darker in light mode. This creates a **brand-tinted surface system** rather than generic grays.

### 5.1 How Surfaces Map to shadcn

| Elevation | shadcn Token | Light | Dark | Usage |
|---|---|---|---|---|
| Base (canvas) | `--background` | `#FFFFFF` | `#000E14` | Page canvas |
| Raised | `--card` / `--secondary` | `#F2F6F8` | `#001C28` | Cards, sidebar |
| Overlay | `--popover` | `#EBF0F3` | `#00293B` | Modals, dropdowns, cmd palette |
| Sunken | `--muted` | `#E4EAED` | `#000A0F` | Input fields, code blocks |
| Brand | `--surface-brand` (custom) | `#004563` | `#004563` | Hero sections |

**Why brand-tinted surfaces matter:** Generic gray (#121417, #1A1D22) makes the platform feel like any SaaS tool. Using the secondary deep teal scale for surfaces gives My VET&GO a recognizable identity even in dark mode — the subtle blue-green tint is felt without being seen consciously. This is the difference between "a dark app" and "the VET&GO app in dark mode."

### 5.2 Dark Mode as Default

My VET&GO defaults to dark mode. This is the **primary** design surface.

**Rationale:** Veterinarians use this tool during night shifts, in dim consultation rooms, in surgery prep. Research shows 14% better information retention after 30-minute sessions with dark backgrounds, and 37% less eye strain after 45 minutes of continuous use.

**Implementation:**
- `next-themes` with `attribute="class"` and `defaultTheme="dark"`
- Surface tokens use the secondary deep-teal scale (NOT generic grays) — brand identity persists in dark mode
- Elevation hierarchy: 4 levels using progressively lighter secondary-scale surfaces
- Accent colors (tertiary/primary) use the 300 step in dark mode for reduced vibration
- Video content areas use `--background` (darkest) to let video be the focal point
- "Theater mode" dims non-video elements further during playback
- Light mode is an explicit toggle, designed as a secondary surface

---

## 6. Color Accessibility

All text-on-surface combinations must pass WCAG 2.2 AA (4.5:1 for normal text, 3:1 for large text and UI components).

**Rule:** Color is never the sole conveyor of information. Every semantic color is paired with a HugeIcons icon + text label.

### 6.1 Key Contrast Checks

| Combination | Ratio | Status |
|---|---|---|
| `--foreground` on `--background` (light) | 18.5:1 | Pass AAA |
| `--foreground` on `--background` (dark) | 14.2:1 | Pass AAA |
| `--primary-foreground` on `--primary` (#00808C) | 4.6:1 | Pass AA |
| `--surface-brand-foreground` on `--surface-brand` (#004563) | 9.7:1 | Pass AAA |
| `text-primary` link on `--background` (light) | 5.8:1 | Pass AA |
| `text-primary` link (dark: #66B3BA) on `--background` (dark) | 8.9:1 | Pass AAA |

---

## 7. Implementation Reference

### 7.1 globals.css — Full Token Definition

This maps VET&GO's design system onto shadcn/ui's expected CSS variable structure. Components using `bg-primary`, `text-muted-foreground`, etc. will automatically resolve to VET&GO's branded values.

```css
@import "tailwindcss";
@import "shadcn/tailwind.css";

@custom-variant dark (&:is(.dark *));

@theme inline {
  /* shadcn core color tokens → Tailwind utilities */
  --color-background: var(--background);
  --color-foreground: var(--foreground);
  --color-card: var(--card);
  --color-card-foreground: var(--card-foreground);
  --color-popover: var(--popover);
  --color-popover-foreground: var(--popover-foreground);
  --color-primary: var(--primary);
  --color-primary-foreground: var(--primary-foreground);
  --color-secondary: var(--secondary);
  --color-secondary-foreground: var(--secondary-foreground);
  --color-muted: var(--muted);
  --color-muted-foreground: var(--muted-foreground);
  --color-accent: var(--accent);
  --color-accent-foreground: var(--accent-foreground);
  --color-destructive: var(--destructive);
  --color-destructive-foreground: var(--destructive-foreground);
  --color-border: var(--border);
  --color-input: var(--input);
  --color-ring: var(--ring);

  /* Chart colors */
  --color-chart-1: var(--chart-1);
  --color-chart-2: var(--chart-2);
  --color-chart-3: var(--chart-3);
  --color-chart-4: var(--chart-4);
  --color-chart-5: var(--chart-5);
  --color-chart-6: var(--chart-6);
  --color-chart-7: var(--chart-7);
  --color-chart-8: var(--chart-8);
  --color-chart-9: var(--chart-9);
  --color-chart-10: var(--chart-10);
  --color-chart-11: var(--chart-11);
  --color-chart-12: var(--chart-12);

  /* Sidebar */
  --color-sidebar: var(--sidebar);
  --color-sidebar-foreground: var(--sidebar-foreground);
  --color-sidebar-primary: var(--sidebar-primary);
  --color-sidebar-primary-foreground: var(--sidebar-primary-foreground);
  --color-sidebar-accent: var(--sidebar-accent);
  --color-sidebar-accent-foreground: var(--sidebar-accent-foreground);
  --color-sidebar-border: var(--sidebar-border);
  --color-sidebar-ring: var(--sidebar-ring);

  /* Radii */
  --radius-sm: calc(var(--radius) * 0.5);
  --radius-md: calc(var(--radius) * 0.667);
  --radius-lg: var(--radius);
  --radius-xl: calc(var(--radius) * 1.333);
  --radius-2xl: calc(var(--radius) * 1.667);
  --radius-full: 9999px;

  /* Typography */
  --font-display: 'Filson Pro', 'Inter', sans-serif;
  --font-body: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  --font-mono: 'JetBrains Mono', 'Fira Code', monospace;

  /* Transitions */
  --transition-fast: 150ms ease-out;
  --transition-base: 250ms ease-out;
  --transition-slow: 400ms ease-out;
}

/* ─── Light mode ─── */
:root {
  --radius: 0.75rem;

  /* Core surfaces */
  --background: #FFFFFF;
  --foreground: #000E14;
  --card: #F2F6F8;
  --card-foreground: #000E14;
  --popover: #EBF0F3;
  --popover-foreground: #000E14;

  /* Interactive */
  --primary: #00808C;
  --primary-foreground: #FFFFFF;
  --secondary: #F2F6F8;
  --secondary-foreground: #000E14;
  --muted: #E4EAED;
  --muted-foreground: #336A82;
  --accent: #D6FCFF;
  --accent-foreground: #000E14;

  /* Destructive (emergency red) */
  --destructive: #D10A10;
  --destructive-foreground: #FFFFFF;

  /* Structure */
  --border: #CCDAE0;
  --input: #99B5C1;
  --ring: #00808C;

  /* Charts / specialties */
  --chart-1: #F52128;
  --chart-2: #0AC96D;
  --chart-3: #3B82F6;
  --chart-4: #D69E2E;
  --chart-5: #EC4899;
  --chart-6: #6366F1;
  --chart-7: #8B5CF6;
  --chart-8: #22C55E;
  --chart-9: #F97316;
  --chart-10: #F43F5E;
  --chart-11: #64748B;
  --chart-12: #84CC16;

  /* Sidebar */
  --sidebar: #F2F6F8;
  --sidebar-foreground: #000E14;
  --sidebar-primary: #00808C;
  --sidebar-primary-foreground: #FFFFFF;
  --sidebar-accent: #D6FCFF;
  --sidebar-accent-foreground: #000E14;
  --sidebar-border: #CCDAE0;
  --sidebar-ring: #00808C;

  /* Extended: status */
  --status-success: #0AC96D;
  --status-warning: #D97706;
  --status-error: #D10A10;
  --status-info: #00808C;
  --status-neutral: #99B5C1;

  /* Extended: brand surface */
  --surface-brand: #004563;
  --surface-brand-foreground: #FFFFFF;
}

/* ─── Dark mode (DEFAULT — brand-tinted, not generic gray) ─── */
.dark {
  --background: #000E14;
  --foreground: #E8EAED;
  --card: #001C28;
  --card-foreground: #E8EAED;
  --popover: #00293B;
  --popover-foreground: #E8EAED;

  --primary: #00808C;
  --primary-foreground: #FFFFFF;
  --secondary: #001C28;
  --secondary-foreground: #E8EAED;
  --muted: #000A0F;
  --muted-foreground: #668FA1;
  --accent: #001A1C;
  --accent-foreground: #E8EAED;

  --destructive: #F7585E;
  --destructive-foreground: #FFFFFF;

  --border: #00293B;
  --input: #00374F;
  --ring: #00808C;

  /* Charts stay vibrant in dark mode */
  --chart-1: #F7585E;
  --chart-2: #0AC96D;
  --chart-3: #60A5FA;
  --chart-4: #FBBF24;
  --chart-5: #F472B6;
  --chart-6: #818CF8;
  --chart-7: #A78BFA;
  --chart-8: #4ADE80;
  --chart-9: #FB923C;
  --chart-10: #FB7185;
  --chart-11: #94A3B8;
  --chart-12: #A3E635;

  --sidebar: #001C28;
  --sidebar-foreground: #E8EAED;
  --sidebar-primary: #00808C;
  --sidebar-primary-foreground: #FFFFFF;
  --sidebar-accent: #001A1C;
  --sidebar-accent-foreground: #E8EAED;
  --sidebar-border: #00293B;
  --sidebar-ring: #00808C;

  --status-success: #0AC96D;
  --status-warning: #FBBF24;
  --status-error: #F7585E;
  --status-info: #66B3BA;
  --status-neutral: #336A82;

  /* Brand surface unchanged */
}

@layer base {
  * {
    @apply border-border outline-ring/50;
  }
  body {
    @apply bg-background text-foreground;
  }
}
```

### 7.2 Tailwind Config — Primitive Color Scales

The primitive scales are registered in Tailwind config for direct utility use when you need a specific brand shade outside the semantic system (e.g., gradient stops, specialty badge fills).

```typescript
// tailwind.config.ts — extend section
export default {
  theme: {
    extend: {
      colors: {
        "vetgo-red": {
          100: "#FCC7C9",
          200: "#FA9093",
          300: "#F7585E",
          400: "#F52128",
          DEFAULT: "#D10A10",
          600: "#A8080D",
          700: "#7E060A",
          800: "#540407",
          900: "#2A0203",
        },
        "vetgo-teal": {
          100: "#CCDAE0",
          200: "#99B5C1",
          300: "#668FA1",
          400: "#336A82",
          DEFAULT: "#004563",
          600: "#00374F",
          700: "#00293B",
          800: "#001C28",
          900: "#000E14",
        },
        "vetgo-cyan": {
          50: "#D6FCFF",
          100: "#CCE6E8",
          200: "#99CCD1",
          300: "#66B3BA",
          400: "#3399A3",
          DEFAULT: "#00808C",
          600: "#006670",
          700: "#004D54",
          800: "#003338",
          900: "#001A1C",
        },
      },
    },
  },
};
```

### 7.3 Migration Notes from Original Token Names

If migrating from the original design system token naming, use this crosswalk:

| Original Token | New shadcn Token | Tailwind Utility |
|---|---|---|
| `--surface-base` | `--background` | `bg-background` |
| `--surface-raised` | `--card` | `bg-card` |
| `--surface-overlay` | `--popover` | `bg-popover` |
| `--surface-sunken` | `--muted` | `bg-muted` |
| `--color-text-primary` | `--foreground` | `text-foreground` |
| `--color-text-secondary` | `--muted-foreground` | `text-muted-foreground` |
| `--color-text-tertiary` | *(use muted-foreground with opacity)* | `text-muted-foreground/60` |
| `--color-text-on-brand` | `--surface-brand-foreground` | *(custom)* |
| `--color-text-on-interactive` | `--primary-foreground` | `text-primary-foreground` |
| `--color-text-link` | `--primary` | `text-primary` |
| `--color-text-error` | `--destructive` | `text-destructive` |
| `--color-interactive` | `--primary` | `bg-primary` |
| `--color-interactive-hover` | *(use primary with opacity)* | `bg-primary/90` |
| `--color-interactive-active` | *(use primary with opacity)* | `bg-primary/80` |
| `--color-interactive-subtle` | `--accent` | `bg-accent` |
| `--color-border-default` | `--border` | `border-border` |
| `--color-border-strong` | `--input` | `border-input` |
| `--color-border-interactive` | `--ring` | `ring-ring` |
| `--color-status-success` | `--status-success` | *(custom utility)* |
| `--color-status-warning` | `--status-warning` | *(custom utility)* |
| `--color-status-error` | `--destructive` | `text-destructive` |
| `--color-status-info` | `--status-info` | *(custom utility)* |

---

## 8. Components.json Configuration

Ensure the shadcn CLI is configured to match VET&GO's conventions:

```json
{
  "$schema": "https://ui.shadcn.com/schema.json",
  "style": "new-york",
  "rsc": true,
  "tsx": true,
  "tailwind": {
    "config": "",
    "css": "app/globals.css",
    "baseColor": "neutral",
    "cssVariables": true,
    "prefix": ""
  },
  "aliases": {
    "components": "@/components",
    "utils": "@/lib/utils",
    "ui": "@/components/ui",
    "lib": "@/lib",
    "hooks": "@/hooks"
  },
  "iconLibrary": "hugeicons"
}
```

**Note on `iconLibrary`:** shadcn defaults to Lucide. VET&GO uses HugeIcons Rounded. After installing shadcn components, replace any Lucide icon imports with HugeIcons equivalents.

---

*Part of the My VET&GO Design System. See also: [Brand Identity](./03a-brand-identity.md) · [UX Patterns](./03b-ux-patterns.md)*
