# My VET&GO — Design System

**Version:** 1.1 — April 2026
**Author:** Arnaud (OSTRO Brothers SRL)
**Status:** Foundation — ready for UI design
**Scope:** My VET&GO Galaxy learning platform (web, responsive, future native)
**Stack:** Next.js · Tailwind CSS v4 · shadcn/ui · Nivo charts

> **v1.1 changelog:** Replaced Dax Condensed with Filson Pro as display font. Adopted HugeIcons Rounded as primary icon set. Rebuilt color system with shadcn/ui token mapping. Split into three focused documents.

---

## Document Structure

The design system is organized into three focused documents:

### [03a — Brand Identity, Styleguide & Motion](./03a-brand-identity.md)

Brand DNA, emotional territory, personality traits, voice & tone, vocabulary guidelines, bilingual terminology reference, typography (Filson Pro + Inter), imagery & photography direction, brand signature elements (wave pattern, ECG pulse line), motion & animation principles, and the platform personality summary.

### [03b — UX/UI Design Patterns & Considerations](./03b-ux-patterns.md)

Spacing scale & grid system, application layout structure (sidebar + content, video learning), iconography (HugeIcons Rounded), component patterns (buttons, cards, navigation, progress indicators, assessment/quiz, command palette), responsive behavior & breakpoints, mobile-specific patterns, and accessibility compliance (WCAG 2.2 AA, EAA).

### [03c — Design Tokens & Component Theming](./03c-design-tokens.md)

Three-layer token architecture (primitives → shadcn semantic → VET&GO extended), color system (red, deep teal, cyan scales), shadcn/ui CSS variable mapping, surface & elevation system, specialty accent colors, chart palette, status tokens, `globals.css` implementation reference, Tailwind config, and migration crosswalk from original token names.

---

## Quick Reference

| Need to know... | Go to |
|---|---|
| Brand personality, tone, terminology | [03a](./03a-brand-identity.md) |
| What font/weight/size to use | [03a §3](./03a-brand-identity.md#3-typography) |
| FR/NL terminology table | [03a §2.3](./03a-brand-identity.md#23-terminology-reference-ux-copy) |
| Animation timing & easing | [03a §6](./03a-brand-identity.md#6-motion--animation) |
| Layout structure & spacing | [03b §1](./03b-ux-patterns.md#1-spacing--layout) |
| Which icon to use | [03b §2](./03b-ux-patterns.md#2-iconography) |
| Button/card/nav specs | [03b §3](./03b-ux-patterns.md#3-component-patterns) |
| Responsive breakpoints | [03b §4](./03b-ux-patterns.md#4-responsive-behavior) |
| Accessibility checklist | [03b §5](./03b-ux-patterns.md#5-accessibility) |
| Color hex values | [03c §2](./03c-design-tokens.md#2-layer-1--primitive-color-scales) |
| shadcn token mapping | [03c §3](./03c-design-tokens.md#3-layer-2--shadcn-semantic-token-mapping) |
| CSS variable definition | [03c §7](./03c-design-tokens.md#7-implementation-reference) |
| Tailwind config | [03c §7.2](./03c-design-tokens.md#72-tailwind-config--primitive-color-scales) |
| Dark mode rationale | [03c §5.2](./03c-design-tokens.md#52-dark-mode-as-default) |

---

*Source references: VET&GO brand charter (2019), Figma Hi-Fi Homepage 3 design, PRD Galaxy v1, market research v2 (5-country analysis), learning experience landscape research (50+ product benchmarks).*
