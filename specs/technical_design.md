# Sketch Design Language (Sketchy) — Technical Design & Implementation Plan

This document translates the vision captured in `specs/requirements.md` into an
implementable plan for the Sketch Design Language (Sketchy). It covers scope,
architecture, component design, sequencing, and verification so we can move from
a blank Flutter package to a cohesive, hand-drawn design system powered by
`wired_elements`, `rough_flutter`, and `rough_notation`.

## 1. Purpose & Scope

- Deliver a **Flutter design language** that makes apps look like interactive
  wireframes while remaining production ready across mobile, web, and desktop.
- Provide a **theme/story** that is as turnkey as Material/Cupertino: global
  tokens, drop-in widgets, documentation, and examples.
- Package Sketchy as a reusable Flutter package plus a showcase app.

### Goals (derived from `specs/requirements.md`)

1. Unified sketch-style theme (colors, typography, spacing, elevations).
2. Core widget catalog (controls, form fields, containers, navigation).
3. Interaction states & animations that feel hand-drawn (hover, press, focus).
4. Typography + iconography that reinforce the rough aesthetic.
5. First-class Rough Notation integration for highlights/onboarding.
6. Multi-platform responsiveness & accessibility.
7. Performance knobs, diagnostics, and automated testing.

### Non-goals

- Recreating every Material widget 1:1 in V1 (focus on 80% usage widgets).
- Providing a full design-token distribution format (e.g., JSON, Figma plugin)
  in the first release; document theming via Flutter APIs instead.
- Building a WYSIWYG editor; we only ship a package + sample apps.

## 2. Guiding Principles

- **Composable layers:** isolate theming, widgets, and annotation utilities so
  downstream apps can swap or extend any layer independently.
- **Opt-in randomness:** consistent seeds by default for predictable renders,
  with escape hatches to increase roughness per widget.
- **Approachable defaults, configurable internals:** Everything “just works” out
  of the box, but advanced users can override colors, fonts, stroke jitter, etc.
- **Performance-aware:** prefer cached drawings, leverage `rough_flutter`
  primitives, minimize per-frame allocations.

## 3. System Overview

| Layer | Responsibilities | Key Artifacts | Dependencies |
| --- | --- | --- | --- |
| Tokens & Theme | Color palette, typography, spacing, stroke randomness, icon sets | `SketchyColorScheme`, `SketchyTypography`, `SketchyThemeData`/`ThemeExtension` | Flutter core (`dart:ui`, `widgets`) |
| Rendering Utilities | Rough canvas wrappers, painters, shape caches | `RoughStroke`, `RoughSeed`, `SketchyDecoration` | `rough_flutter` |
| Widget Library | Controls, inputs, containers, navigation built with wired/rough look | `SketchyButton`, `SketchyCheckbox`, `SketchyCard`, etc. | `wired_elements`, rendering utilities |
| Application Shell | Material/Cupertino-free app bootstrap, routing, scaffolding | `SketchyApp`, `SketchyRouter`, `SketchyScaffold`, `SketchyAppBar` | Flutter `WidgetsApp`, widget library |
| Interaction & Annotation | Hover/press/focus feedback, Rough Notation hooks | `SketchyInteractionController`, `SketchyHighlight`, `SketchyTutorial` | `rough_notation` |
| Tooling & Docs | Example app, storybook, guidance | `/example` showcase, markdown docs, screenshot tests | Flutter tooling |

## 4. Detailed Design

### 4.1 Theme & Tokens

1. **Theme Extension**
   - Create `SketchyThemeData extends ThemeExtension<SketchyThemeData>` holding:
     - `SketchyColorScheme` (base palette + semantic colors like emphasis,
       warning, success).
     - `SketchyTypography` (font families, weights, sizes, letter spacing).
     - `SketchySpacing` (scale for padding, border radius, stroke width).
     - `RoughConfig` (roughness, seed strategy, hachure density, animation
       durations).
   - Provide `SketchyTheme` InheritedWidget to read data independent of
     Material’s global theme while powering `SketchyApp`/`SketchyScaffold`.
     Optionally expose a thin `ThemeData` adapter for teams that must mix with
     legacy Material widgets, but Sketchy apps should function without any
     Material/Cupertino imports.
2. **Color Palette**
   - Start with a light/dark palette referencing wired default colors plus
     neutrals for surfaces.
   - Structure tokens by semantic role, not widget type, so downstream apps can
     map brand colors easily.
3. **Typography**
   - Package at least two open fonts (`Comic Shanns` and `Cabin Sketch`) in
     `/assets/fonts`.
   - Provide fallbacks and allow consumers to override via `SketchyTypography`.
4. **Iconography**
   - Convert Excalidraw Awesome Icons SVG set into icon font or Flutter vector
     assets (custom `SketchyIcons` class).
   - Provide `SketchyIconTheme`.
5. **SketchyApp Bootstrapping**
   - Implement `SketchyApp` built directly on `WidgetsApp`/`RouterConfig`,
     wiring localization, routing (via a wafer-thin `SketchyRouter` wrapper
     around `WidgetsApp` navigation primitives), theming, and text direction
     with no Material dependency.
   - Default docs and examples wrap apps with `SketchyApp`, ensuring the design
     language is end-to-end self-sufficient.

### 4.2 Rendering Utilities

- Build a thin abstraction over `rough_flutter` to centralize seeds, caching,
  and stroke generation:
  - `SketchyRoughPainter` that wraps `RoughCanvas` drawing commands and caches
    `Drawable`s when geometry + config match.
  - `SketchyDecoration extends Decoration` using `RoughBoxDecoration` but with
    theme-aware colors and randomness.
  - Utility for generating irregular outlines that follow layout constraints
    (respecting device pixel ratios).
- Provide diagnostics (debug paints) via assert-enabled `debugSketchyPaint`.

### 4.3 Widget Library

**Foundations (Phase 1)**

- Build wrappers around `wired_elements` controls to ensure theming + state
  integration:
  - `SketchyButton` (primary/secondary/ghost variants) using `WiredButton`.
  - `SketchyCheckbox`, `Switch`, `Radio`, `Slider`, `TextField`.
  - `SketchyBadge`, `Chip` built via `WiredToast`, `WiredIconButton`, etc.
- Normalize APIs to match Flutter conventions (`onPressed`, `style`,
  `FocusNode`, `autofocus`).
- Provide `SketchyFormField` mixin to reuse validation, error helpers, and to
  inject Rough Notation highlights for invalid states.

**Containers & Layout (Phase 2)**

- `SketchyCard`, `SketchyPanel`, `SketchyListTile`, `SketchyDivider` drawn using
  `SketchyDecoration`.
- `SketchyScaffold` + `SketchyAppBar` implemented directly with core Flutter
  widgets (`LayoutBuilder`, `Navigator`, `CustomMultiChildLayout`) so the app
  shell never depends on Material/Cupertino while still supporting drawers,
  snackbars, and floating panels.
- `SketchyRouter` provides a thin declarative routing API wrapping
  `RouterConfig`/`Navigator` to keep integration simple while matching Flutter
  idioms (e.g., `RouteInformationParser` hooks, back button handling).
- Responsive spacing helpers (`SketchyPadding`, `SketchyGridGap`).

**Navigation & Utility (Phase 3)**

- `SketchyTabBar`, `SketchyBottomBar`, `SketchyDrawer`.
- Support for rough-styled dialogs/toasts (`SketchyDialog`, `SketchySnackbar`)
  delivering their own shape, motion, and overlay systems independent of
  Material.

### 4.4 Interaction Model & Rough Notation Integration

- Implement `SketchyInteractionController` to coordinate hover/press/focus
  states:
  - Uses `Listener`/`MouseRegion` to trigger secondary outlines, fill tweaks, or
    scale animations.
  - Provide Sketchy-native press feedback (scribbled ripples, blot animations)
    so no Material `InkFeature` implementations are required.
- Focus management:
  - Provide `SketchyFocusHighlight` (CustomPainter) that draws a Rough Notation
    style highlight when focus gained (keyboard nav).
  - Expose `SketchyFocusBehavior` property on widgets.
- Rough Notation utilities:
  - Wrap `rough_notation` primitives into easy widgets like
    `SketchyAnnotate.box`, `.underline`, `.circle`.
  - `SketchyTutorialController` orchestrates grouped annotations for onboarding.
  - Integration hooks on widgets (e.g., `SketchyButton` `annotation` parameter
    or `showErrorHighlight`).

### 4.5 Multi-Platform Adaptivity

- Provide responsive defaults:
  - `SketchyBreakpoints` (small/medium/large) + `SketchyResponsiveBuilder`.
  - Stroke widths adapt to DPI; define scaled jitter for large screens.
  - Touch vs mouse detection controls whether hover effects show.
- Accessibility:
  - Ensure all controls expose semantics, labels, focus order.
  - Provide high-contrast theme option (reduced randomness, stronger outlines).

### 4.6 Performance Strategy

- Use a shared `RoughGenerator` per theme to avoid re-instantiating.
- Memoize shape paths by `(Size, RoughConfig, Seed)` tuples.
- Offer theme-level knobs: `roughness`, `fillWeight`, `animationComplexity`.
- Provide a `SketchyPerformanceOverlay` debug widget to visualize paint costs.

## 5. Implementation Plan

### Phase Breakdown

| Phase | Duration | Milestones | Dependencies |
| --- | --- | --- | --- |
| 0. Project Setup | 1 sprint | Add package dependencies, fonts, icons, linting, CI skeleton, sample example app shell | None |
| 1. Foundations | 2 sprints | Theme/tokens, SketchyTheme shim, rendering utilities, typography + icon plumbing | Phase 0 |
| 2. Core Controls | 3 sprints | Buttons, toggles, sliders, text fields w/ states and validation | Phase 1 |
| 3. Surfaces & Layout | 2 sprints | Cards, lists, navigation shell, responsive helpers | Phase 2 |
| 4. Interaction & Notation | 2 sprints | Interaction controller, focus highlights, Rough Notation wrappers + tutorials | Phases 1–3 |
| 5. Performance + QA | 1 sprint | Profiling, caching, docs, golden tests, release candidate | Prior phases |

### Backlog Details

1. **Project Setup**
   - Update `pubspec.yaml` with dependencies (`wired_elements`, `rough_flutter`,
     `rough_notation`, font assets, icon font).
   - Configure analysis options, CI (format, analyze, test).
   - Create `/example` showcasing placeholder screen powered solely by the
     Sketchy widget set inside `SketchyApp` (no Material/Cupertino imports).
2. **Theme/Tokens**
   - Implement `SketchyThemeData` and `SketchyTheme`.
   - Provide default light/dark theme factories.
   - Add font assets + `SketchyTypography`.
   - Build `SketchyIcons` class.
   - Deliver `SketchyApp` (WidgetsApp-based bootstrap) plus `SketchyRouter`
     helpers so demos never import Material/Cupertino.
3. **Rendering Utilities**
   - Implement `SketchyRoughPainter`, caching infrastructure, debug overlays.
   - Create `SketchyDecoration`, `SketchyBorder`, `SketchyShadow`.
4. **Core Widgets**
   - Buttons: primary, secondary, ghost.
   - Inputs: text field, checkbox, switch, radio, slider, progress indicator.
   - Feedback: badge, chip, tooltip.
   - Provide documentation + storybook entries per widget.
5. **Containers & Navigation**
   - Scaffold/AppBar, Drawer/Sidebar, Tabs, Card, Dialog, ListTile, Divider.
   - Responsive helpers.
   - `SketchyRouter` (thin `WidgetsApp` wrapper) + navigation patterns built
     without Material shell.
6. **Interaction & Rough Notation**
   - Interaction controller + themable state transitions.
   - Rough Notation wrappers and sample onboarding flow.
   - Form field error/highlight integration.
7. **Performance & QA**
   - Golden tests (multiple themes, states).
   - Widget tests for focus/interaction states.
   - Benchmark sample list views using `flutter drive`.
   - Publish API docs + cookbook in `/specs` or `/docs`.

### Deliverables per Phase

- Code (library + tests), documentation updates, demo screens/gifs, and release
  notes.
- Definition of done: all lint/tests pass, storybook entry for new components,
  documentation updated, golden tests regenerated.

## 6. Testing & Quality Strategy

- **Unit Tests:** Theme extension merging, rough painter caching, interaction
  controller state machine.
- **Widget/Golden Tests:** Buttons (states, colors), cards, dialog transitions,
  Rough Notation overlays; run on multiple device pixel ratios.
- **Integration Tests:** Example app flows covering form validation, tutorials,
  navigation.
- **Performance Profiling:** Flutter DevTools tracing on list-heavy screens,
  verifying <16ms frame budget on reference devices.
- **Accessibility Audits:** Semantics tester for focus order, contrast checks
  via golden diffing.

## 7. Tooling & Documentation

- `/example` app doubling as playground + screenshot generator.
- Storybook-like showcase (e.g., `dashbook` or custom gallery) for manual QA.
- Markdown guides:
  - Getting started (import theme, wrap your root with `SketchyApp`).
  - Theming cookbook (overriding colors/fonts/roughness).
  - Rough Notation recipes (error states, tutorials).
  - Accessibility/performance best practices.

## 8. Risks & Mitigations

| Risk | Impact | Mitigation |
| --- | --- | --- |
| Performance regressions on large lists | Janky UX | Early profiling, caching, expose knobs, document limits |
| Dependency drift in `wired_elements` | API breakage | Pin versions, add wrapper layer, contribute fixes upstream if needed |
| Font/icon licensing or size | App bundle bloat | Use permissive fonts, subset icon font per platform, allow opt-out |
| Animations feeling slow on touch devices | UX mismatch | Provide reduced-motion mode and tune durations per platform |
| Accessibility gaps | Users unable to navigate | Adopt Flutter semantics testing, include keyboard navigation support from day one |

## 9. Example Experiences (Implementation Targets)

All examples are single-file demo screens so adopters can drop each into the
storybook or `/example` app without multi-step flows.

1. **Sketchy Spotlight Panel** – One view with `RoughCard` layout, primary/
   secondary `SketchyButton`s, and grouped `SketchyAnnotate` highlights to
   validate annotations, spacing, and interaction states.
2. **Wireframe Productivity Dashboard** – Desktop scene containing
   `SketchyAppBar`, sidebar navigation, draggable `SketchyCard`s, and rough list
   dividers to stress multi-column layout and data density.
3. **Collaborative Design Critique Board** – Gallery file framed by
   `SketchyDecoration`, inline `SketchyBadge` comments, and hover-triggered
   circle annotations demonstrating typography overrides and overlay layering.
4. **Mobile Expense Tracker Form** – Stack of `SketchyTextField`, dropdown, and
   toggle controls with validation-driven Rough Notation error indicators,
   testing form widgets, focus handling, and touch feedback.
5. **Education Quiz Card** – Question card with multi-select chips, rough
   progress indicators, and celebratory highlight animations covering feedback
   patterns, motion timing, and icon usage.
6. **Developer Documentation Viewer** – Tablet-friendly tabbed document with
   `SketchyTabs`, scrollable sections, inline tooltips, and hover animations for
   copy buttons to exercise hover/focus and responsive helpers.
7. **Hackathon Whiteboard Palette** – Free-form canvas using raw
   `rough_flutter` primitives plus floating `SketchyIconButton`, slider, and
   switch controls to test low-level drawing integration and continuous input.
8. **Customer Support Live Chat** – `SketchyListTile` chat transcript with
   typing indicators, suggestion chips highlighted via Rough Notation, and
   accessibility toggles validating semantics and reduced-motion support.

These scenarios match the SDL examples in `specs/requirements.md` and define the
acceptance targets for the `/example` playground and storybook.

## 10. Open Questions

1. Do we ship an optional Material adapter (`SketchyThemeData.asMaterial()`) for
   incremental adoption, or keep Sketchy entirely separate from Material and
   provide adapters later?
2. What is the minimum widget set required for the first public release?
3. Do we need built-in design tokens export (JSON) for designers, or can we
   defer until after developer preview?
4. Should Rough Notation be always enabled for focus/error states or only when
   the consumer opts in?

Answering these during Phase 0 will clarify scope and ensure alignment with the
product vision in `specs/requirements.md`.
