# Building a Hand-Drawn Flutter Design Language with Wired UI & Rough Notation

**Overview:** We want to combine **wired_ui**, **rough_flutter**, and
**rough_notation** into a cohesive Flutter design language – essentially a
“hand-drawn” UI toolkit analogous to Material or Cupertino design systems. This
means creating a unified set of themes, widgets, and guidelines so any Flutter
app (mobile, web, desktop) can adopt the sketchy, wireframe-like aesthetic
consistently.

## Understanding Flutter Design Languages

In Flutter, a **design language** (or design system) is a complete style and
widget framework that defines an app’s look and feel. For example, **Material
3** is the default design language of
Flutter[docs.flutter.dev](https://docs.flutter.dev/ui/widgets/material#:~:text=Flutter
provides a variety of,can adapt to any platform), and Flutter also provides
**Cupertino** widgets for iOS’s design. Community design systems like
Canonical’s **Yaru** (Ubuntu style) and the **Chicago** widget set show how
alternate Flutter design languages bundle custom widgets and themes:

- **Yaru** offers Ubuntu-styled widgets, a Material theme override, and even a
  custom icon set following Ubuntu’s design
  language[github.com](https://github.com/ubuntu/yaru.dart#:~:text=,following
  the yaru design language).
- **Chicago** provides an alternate design language optimized for desktop apps
  (keyboard/mouse usage), inspired by Apache
  Pivot[fluttergems.dev](https://fluttergems.dev/packages/chicago/#:~:text=The
  Chicago widget set is,is based on Apache Pivot).

A Flutter design language typically includes a unified theme (colors,
typography, spacing), a library of UI components implementing the style, and
guidelines for interaction and motion. Our goal is to create a similar
**hand-drawn design system** – where all components from buttons to dialogs
share the “sketchy” look – by leveraging Wired UI and Rough libraries.

## The “Hand-Drawn” Aesthetic: Wired UI & Rough Libraries

The three packages in question each contribute to the sketch-style aesthetic:

- **Wired UI (wired_elements)** – A Flutter implementation of the web
  “wired-elements” library, providing basic UI components (buttons, sliders,
  checkboxes, etc.) with a hand-drawn, sketch-like
  look[flutterawesome.com](https://flutterawesome.com/a-series-of-basic-ui-elements-that-have-a-hand-drawn-look-with-flutter/#:~:text=Wired
  Elements is a series,on the library of flutter_rough). Under the hood, it’s
  built on the `flutter_rough` library for rendering these irregular
  outlines[flutterawesome.com](https://flutterawesome.com/a-series-of-basic-ui-elements-that-have-a-hand-drawn-look-with-flutter/#:~:text=Wired
  Elements is a series,on the library of flutter_rough). This gives us
  ready-made widgets (e.g. a scribbly button, checkbox, text field, etc.) as a
  starting point for the design language.
- **Rough Flutter (flutter_rough)** – A low-level drawing library that recreates
  the Rough.js API in
  Flutter[pub.dev](https://pub.dev/documentation/rough_flutter/latest/rough_flutter/#:~:text=A
  Flutter implementation of the,like graphics). It allows us to draw shapes with
  sketchy lines, “rough” edges, and hachure fills. We can use this for custom
  graphics or styling – e.g. drawing a rough border around a card or creating a
  hand-drawn shape icon. It provides primitives like `RoughCanvas` and even a
  **RoughBoxDecoration** for sketch-style container
  backgrounds[pub.dev](https://pub.dev/documentation/rough_flutter/latest/rough_flutter/#:~:text=,styled
  containers). This library ensures all our custom-drawn elements (borders,
  shadows, shapes) have the authentic hand-drawn feel.
- **Rough Notation** – A lightweight package for animated hand-drawn annotations
  on
  widgets[github.com](https://github.com/0xharkirat/rough_notation#:~:text=RoughNotation
  Flutter). Inspired by Rough Notation JS, it lets you highlight or call out UI
  elements with animated scribbles (e.g. underlining text, boxing something with
  a rough rectangle, circling content, etc.). It includes built-in annotation
  styles like underline, box, circle, highlight, strikethrough and
  more[github.com](https://github.com/0xharkirat/rough_notation#:~:text=*
  Hand,off * Bracket), all drawn in that sketchy style. This will allow our
  design language to not only style widgets statically, but also emphasize them
  dynamically (for tutorials, focus highlights, error indications, etc.) in a
  matching hand-drawn manner.

By bundling these together, we can create a unified **hand-drawn UI kit**. Wired
Elements gives us the core widgets drawn with rough strokes, Rough Flutter lets
us customize and extend those drawings (or create new ones), and Rough Notation
adds an extra layer of playful interaction (animated highlights and emphasis) –
all in a consistent sketched aesthetic.

## Requirements for a Hand-Drawn Flutter Design System

To build this “wired/rough” design language (the **Sketch Design Language** –
**Sketchy** for short), we need to plan out several components and development
steps. Below is a comprehensive list of requirements and considerations for
creating such a design system:

1. **Design Principles & Visual Style Guide:** First, define the overall visual
   identity. This includes choosing the default color scheme, text styles, and
   general aesthetics that complement the hand-drawn look. For example, many
   “sketch” UIs use a simple palette (maybe white background, black or dark-gray
   stroke lines for outlines, and minimal use of solid fills) to mimic pen on
   paper. Decide on default typography (perhaps a casual-looking font or the
   platform default?) and sizes for text that pair well with the informal style.
   Document guidelines for spacing, layout, and when to use rough highlights.
   Essentially, establish how the rough/wired look should be applied so that all
   components feel cohesive.

2. **Theming and Global Settings:** Provide a way to apply this style
   consistently across an app – similar to how Material has `ThemeData`. We
   might create a **SketchyTheme** that holds global configurations: e.g.
   stroke color and width, roughness level (how “wiggly” the lines are), corner
   style (perhaps all rectangles have slightly jittered corners), and maybe a
   set of sketchy **icons** (if available). This theme can also incorporate
   light vs. dark mode variants (for instance, white strokes on dark background
   for dark theme). By offering a Theme, developers could wrap their app with
   `SketchyTheme(data: ..., child: MyApp)` or use a `ThemeData` extension so
   that our widgets pick up the settings. This ensures **Flutter apps of all
   kinds** can easily switch to the hand-drawn look by toggling the theme or
   importing our design language package.

3. **Core Widget Library (Sketchy Components):** Implement the essential Flutter
   widgets in the new style. This is the bulk of the work – we need to either
   adapt **wired_elements** components or create our own, to cover common UI
   elements:

   - **Buttons** – e.g. a rough-outlined rectangular button (and possibly
     variants like outline, filled with hachure patterns, icon buttons, toggle
     buttons).
   - **Text Inputs** – text fields with hand-drawn rectangle outlines (and
     blinking cursor styled appropriately).
   - **Selection Controls** – checkboxes and radio buttons drawn as rough shapes
     (a scribbled square with a checkmark, a hand-drawn circle radio). These
     need custom painters for the checkmark and fill states.
   - **Toggles/Switches** – a rough-drawn toggle switch or maybe repurpose the
     checkbox for simplicity.
   - **Sliders** – a line with a draggable knob, all drawn in sketch style
     (could use Rough shapes for the line and circle).
   - **Progress Indicators** – for example, a progress bar with a rough
     rectangle outline and hatch fill, or an indeterminate spinner drawn as a
     rough circle.
   - **Containers & Panels** – e.g. cards or dialogs with rough borders. We
     might create a **RoughCard** (like Material Card) with a scribbly outline,
     or a dialog box with a rough-edged rectangle background.
   - **Navigation Widgets** – if targeting mobile, maybe a rough-styled AppBar
     (perhaps a normal AppBar but with a rough underline, or a completely drawn
     title bar). On desktop, things like menu bars or sidebar could also follow
     the style (though these might be lower priority).
   - **Lists/Scroll items** – possibly styling ListTiles or list dividers in a
     rough way (a hand-drawn divider line).

   We should prioritize widgets that will be commonly used. *Wired Elements*
   already provides many of these (buttons, sliders, checkbox, etc.) which we
   can use directly or modify. Part of this requirement is ensuring each widget
   has all the necessary states (see next point) and works inside Flutter’s
   layout system. Each component should feel like part of the same family
   visually. We also ensure these widgets are **accessible** as drop-in
   replacements – for instance, our RoughButton should be usable wherever a
   normal `ElevatedButton` might be used, just by switching to our widget and
   supplying onPressed.

4. **Interactive States & Animations:** Define how the sketchy widgets behave on
   user interaction, and implement those effects. In standard design systems,
   buttons have hover highlights, press splash effects, focused states, etc. We
   need **hand-drawn analogs** for these:

   - For **hover** (on web/desktop): perhaps the outline color darkens or a
     second scribble line appears to emphasize the button.
   - For **pressed**: we could avoid Flutter’s default ink ripple (which
     wouldn’t match our style) and instead do something like a quick “ink blot”
     or slight scale-down. Even a rough-notation style highlight on press could
     be interesting (though it might be too slow for a quick tap effect). At
     minimum, provide visual feedback like changing fill or sketching a filled
     shadow.
   - For **focus** (keyboard navigation): maybe use Rough Notation to draw a
     sketchy highlight (like a rough glowing outline) around the focused
     element. This could replace the default focus border with something
     on-brand.
   - **Transitions** and **animations**: If the design language includes any
     animated appearance (e.g., a route transition could fade in with a
     hand-drawn reveal effect, etc.), define those. Rough Notation gives us some
     animation tools; for instance, we might animate drawing the outline of a
     dialog when it opens. Keep animations playful but not distracting – they
     should feel like a natural sketching motion.

   We will likely write custom `InkFeature` or focus highlight painters to
   override Material’s effects, ensuring that when using our components, the
   default Material ripples or highlight glows are suppressed in favor of our
   custom ones. This is important for consistency.

5. **Typography**: integrate an existing hand-drawn font by default use in the
   theme, although allow the user to override as they choose. I'm thinking
   [Comic Shanns](https://github.com/shannpersand/comic-shanns) right now (it's
   so mono-spaced and cool!) or
   [Excalifont](https://plus.excalidraw.com/excalifont). But [Cabin
   Sketch](https://www.1001fonts.com/cabin-sketch-font.html) is cool, too, and
   it's been optimized for size!

6. **Iconography**: integrate a comprehensive set of hand-drawn icons, like
   [this Awesome Icons Excalidraw icon
   set](https://libraries.excalidraw.com/?theme=light&sort=default#ferminrp-awesome-icons),
   for use in building icon buttons, toolbars, menubars, etc. They should be
   scalable, monochrome (so the user can choose the color and they can be
   recolored based on the theme) and ideally font-based for performance.

7. **Rough Notation Integration:** Integrate **rough_notation** features into
   the design language for enhanced feedback and tutorials. This could be an
   optional but powerful part of the “bundle.” Some ideas:

   - Provide utility widgets or methods to easily add annotations. For example,
     a `RoughHighlight` widget that wraps any child and draws an animated
     highlight (maybe using `RoughHighlightAnnotation` under the hood).
   - Use annotations for **error states or tips**: e.g. if a form field is
     invalid, automatically show a rough red underline squiggle or box around it
     (leveraging rough_notation’s box style). This would require connecting our
     form widgets to annotation widgets on demand.
   - Grouped animations to create on-boarding sequences: rough_notation supports
     grouping multiple annotations to play in
     order[github.com](https://github.com/0xharkirat/rough_notation#:~:text=Grouped
     Annotations)[github.com](https://github.com/0xharkirat/rough_notation#:~:text=).
     We could incorporate this concept for showing a walkthrough of the UI – the
     design system’s documentation or examples could demonstrate how to
     sequentially highlight features of the UI in a hand-drawn animated fashion.

   Essentially, we make sure that rough_notation (annotations like underline,
   box, circle, etc.) can be easily used alongside our widgets. It might just
   mean documenting how to use them (e.g. wrap a RoughNotation widget around a
   RoughButton to draw attention to it) or even providing pre-integrated
   variants (for instance, a RoughButton could have a property
   `showFocusHighlight` that internally triggers a Rough Notation underline when
   focused). By doing this, the **animated hand-drawn effects** feel like a
   natural extension of the design language.

8. **Multi-Platform Adaptivity:** Ensure the design language works across
   devices and input methods. Since the target is “Flutter apps of all kinds,”
   our Sketchy UI should be responsive and adaptive:

   - On **mobile/touch**: widgets should be appropriately sized for touch
     targets (probably the same 48px min as Material), and perhaps have slightly
     thicker strokes to remain visible on small screens. Touch-specific
     considerations like the absence of hover, and the need for clear pressed
     states, should be handled (e.g., maybe make the outline bolder when pressed
     on mobile).
   - On **web/desktop**: incorporate hover effects (as noted) and focus handling
     for keyboard users. Also consider **desktop style** scrollbars or context
     menus if any – these might remain native or Material, or we create
     rough-styled scrollbar thumbs (optional).
   - **Responsive layout**: The design language should not break on larger
     screens. Possibly provide guidance or widgets for responsive design
     (similar to how Material has responsive breakpoints). The sketchy style
     likely scales well, but we might adjust things like the randomness seed for
     large surfaces so that patterns don’t repeat obviously.
   - **Platform theming**: If needed, allow subtle tweaks per platform. For
     example, on Android we might use the default Roboto font, on iOS the San
     Francisco, to match platform norms (while still using rough styling for
     visuals). Our design system can mostly be platform-agnostic visually (since
     it’s a very custom style), but we should verify it doesn’t conflict with
     platform conventions (like safe area handling for notches, etc., which we’d
     still honor in layouts).

9. **Performance Optimization:** Drawing a lot of “rough” shapes can be CPU/GPU
   intensive, so we must optimize the implementation. Requirements here include:

   - Reuse drawing objects where possible. For example, if many buttons use the
     same rough border shape (just scaled), we could generate it once via
     `RoughCanvas` and reuse the path or use `PictureCache`. The
     **rough_flutter** library provides a `Generator` that can produce shapes;
     we might share one generator with a fixed seed so that multiple widgets
     don’t all repaint unpredictably.
   - Provide knobs to adjust complexity: e.g. a global “roughness” setting that,
     if turned down, draws fewer jitter lines (for better performance on low-end
     devices). Or allow opting out of hatch fills in favor of solid fills if
     needed.
   - Leverage `RoughBoxDecoration` and similar classes to integrate with
     Flutter’s painting optimizations. For instance, using `RoughBoxDecoration`
     on a Container means we can cache the drawn shape as part of the widget’s
     decoration caching, rather than repainting from scratch every frame.
   - Ensure that animations (like Rough Notation highlights) are efficient.
     Rough Notation uses CustomPainter animations; we should test them with many
     annotations at once to ensure the app stays smooth, tweaking durations or
     stroke sizes as needed.

   Overall, we need to test the design language in a realistic app scenario to
   catch performance issues (for example, a list of 100 rough-outlined list
   items – does it scroll smoothly?). Part of building the system is profiling
   and possibly simplifying the drawing approach if needed (e.g., maybe use a
   PNG/image for extremely complex doodles if it’s static, though that reduces
   the dynamic charm).

10. **Documentation & Example App:** Like any good design system, we must
    provide thorough documentation and demos. Requirements for this include:

    - Writing a **README** and website/documentation explaining how to use the
      Sketchy widgets and theme. Include comparisons of normal vs. sketchy
      widget usage (so developers can quickly map their knowledge, e.g. “use
      RoughCheckbox instead of Checkbox”).
    - Document the properties and customization options (e.g. how to change the
      stroke color globally or per widget, how to adjust roughness).
    - Provide guidance on when to use rough annotations for emphasis, with code
      examples.
    - Create an **example app or gallery** showcasing all the components in the
      design language. For instance, a screen with all the buttons, another with
      form elements, a todo-list app UI built with the sketch widgets, etc., to
      demonstrate a consistent look. This is similar to Flutter’s official
      widget catalog or the Material 3 demo app.
    - Possibly include usage tips – because this style is unconventional, devs
      might wonder how it mixes with regular Material widgets. We should clarify
      if mixing is okay (it might look odd). Ideally, an app would use the
      Sketchy design entirely for coherence. So the docs could encourage using
      our Scaffold or theme to wrap Material widgets to look blank if needed,
      etc.

11. **Testing & Accessibility:** Finally, treat this like a production-quality
    design system by ensuring it’s robust and accessible:

    - **Unit and integration tests** for the widgets (do they render correctly?
      Do interactive states change as expected?).
    - **Accessibility**: Make sure all custom widgets expose proper semantics.
      For example, our rough checkbox should still announce as a checkbox and
      its state to screen readers. Flutter’s `Semantics` widgets can be used in
      our implementations to achieve this.
    - Ensure sufficient contrast by default. The sketchy lines (typically black
      on white) generally have good contrast. If we allow colored strokes, we
      might want to pick defaults that meet contrast guidelines for text on
      backgrounds, etc. For instance, if a button is filled with a hatch
      pattern, ensure the text on it is still legible (maybe use solid
      semi-transparent fill behind text if needed).
    - Keyboard navigation: verify that users can navigate between our controls
      using TAB/arrow keys where appropriate, and that focus indicators (as
      implemented in point 4) are visible.
    - **Theme fallback**: if someone doesn’t use our SketchyTheme, our widgets
      should still have sensible defaults (perhaps just using black strokes).
      But they should also respond to theme if set. Testing this ensures
      flexibility.
    - Cross-platform testing: Render the widgets on different platforms
      (Android, iOS, web, Windows/Linux/macOS) to catch any platform-specific
      issues (like canvas differences, or text alignment quirks).

12. **Standalone Application Shell:** Ship Sketchy as a complete UI stack so
    developers never have to import `material.dart` or `cupertino.dart` when
    they opt into the sketchy look.

    - Provide a first-class `SketchyApp` (built on top of Flutter’s lower-level
      `WidgetsApp` primitives) that wires up routing, localization, text
      direction, and the Sketchy theme without touching Material/Cupertino.
    - Include a thin `SketchyRouter` wrapper over `WidgetsApp`’s routing APIs,
      `SketchyScaffold`, and navigation primitives so
      every structural piece—from app bars to drawers—comes from this design
      language.
    - Any interoperability with Material/Cupertino should live behind optional
      adapter layers; the default documentation and examples use only
      Sketchy-specific imports.

## Sketch Design Language Example Experiences

Each example is a single self-contained file/screen that demonstrates a distinct
facet of Sketchy—no multi-step tutorials.

1. **Sketchy Spotlight Panel:** One card with grouped `rough_notation`
   highlights drawing attention to primary/secondary `SketchyButton` controls,
   showcasing annotations, interaction states, and responsive padding in a
   single build function.
2. **Wireframe Productivity Dashboard:** Desktop-first scene with a
   `SketchyAppBar`, sidebar, draggable `SketchyCard` widgets, and rough dividers,
   illustrating multi-column layout, chart styling via `rough_flutter`, and list
   performance within one file.
3. **Collaborative Design Critique Board:** A gallery screen framed by
   `SketchyDecoration`, inline `SketchyBadge` comments, and hover-triggered
   `SketchyAnnotate.circle` callouts, emphasizing typography overrides,
   iconography, and overlay layering.
4. **Mobile Expense Tracker Form:** Single-screen stack of `SketchyTextField`,
   dropdown, and toggle controls with validation-driven Rough Notation error
   indicators demonstrating form widgets, focus handling, and touch feedback.
5. **Education Quiz Card:** One question card featuring multi-select chips,
   rough progress indicators, and celebratory `SketchyHighlight` animations to
   cover animated feedback, badges, and icon usage.
6. **Developer Documentation Viewer:** Tablet-friendly file using `SketchyTabs`,
   scrollable content with `SketchyDivider`, inline `SketchyTooltip` hints, and
   hover animations for copy buttons—showcasing hover/focus behavior and
   responsive helpers.
7. **Hackathon Whiteboard Palette:** Single canvas built with raw
   `rough_flutter` primitives plus a floating palette of `SketchyIconButton`,
   slider, and switch controls to demonstrate low-level drawing integration and
   continuous input performance.
8. **Customer Support Live Chat:** A standalone chat transcript with
   `SketchyListTile` message bubbles, typing indicators, suggestion chips
   highlighted via Rough Notation, and accessibility toggles to validate
   semantics, reduced-motion support, and long-session performance.

By meeting all the above requirements, we will have essentially created a new
Flutter design language: a **Hand-Drawn UI Toolkit**. This **Sketch Design
Language (“Sketchy”)** would let developers style entire apps in a playful,
sketch-like manner, much like Material and Cupertino provide polished native
styles. It involves defining a clear style guide, building out the widget
library (likely starting
from the existing
wired_elements[flutterawesome.com](https://flutterawesome.com/a-series-of-basic-ui-elements-that-have-a-hand-drawn-look-with-flutter/#:~:text=Wired
Elements is a series,on the library of flutter_rough) and
rough_notation[github.com](https://github.com/0xharkirat/rough_notation#:~:text=RoughNotation
Flutter) implementations), integrating them under a unified theming API, and
ensuring the result is easy to use, performant, and well-documented. The end
result is a Flutter UI framework that feels like an interactive wireframe –
useful for creative projects, prototyping with a hand-drawn touch, or just
giving apps a unique personality. With the requirements above as a roadmap, one
could proceed to design and implement this **sketched design language** and join
the ranks of Material, Cupertino, Yaru, and Chicago as a new Flutter design
paradigm.

**Sources:**

- Flutter Material 3 design language (Flutter
  docs)[docs.flutter.dev](https://docs.flutter.dev/ui/widgets/material#:~:text=Flutter
  provides a variety of,can adapt to any platform)
- Ubuntu Yaru design widgets for Flutter (example of a Flutter design
  language)[github.com](https://github.com/ubuntu/yaru.dart#:~:text=,following
  the yaru design language)
- Chicago widget set (alternate Flutter design language for
  desktop)[fluttergems.dev](https://fluttergems.dev/packages/chicago/#:~:text=The
  Chicago widget set is,is based on Apache Pivot)
- *wired_elements* Flutter package (hand-drawn UI elements built on
  flutter_rough)[flutterawesome.com](https://flutterawesome.com/a-series-of-basic-ui-elements-that-have-a-hand-drawn-look-with-flutter/#:~:text=Wired
  Elements is a series,on the library of flutter_rough)
- *rough_flutter* library (Flutter impl. of Rough.js for sketchy
  graphics)[pub.dev](https://pub.dev/documentation/rough_flutter/latest/rough_flutter/#:~:text=A
  Flutter implementation of the,like graphics)
- *rough_notation* Flutter package (animated hand-drawn annotations for
  widgets)[github.com](https://github.com/0xharkirat/rough_notation#:~:text=RoughNotation
  Flutter)[github.com](https://github.com/0xharkirat/rough_notation#:~:text=*
  Hand,off * Bracket)
