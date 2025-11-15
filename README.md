<div align="center">

# Sketchy Design Language

Hand-drawn Flutter widgets powered by `wired_elements`, `rough_flutter`, and
`rough_notation`.

</div>

Sketchy is a full design language: a theming system, widget catalog, and example
storyboard that makes your app look like a living wireframe. It is
material/Cupertino free, defaults to the Comic Shanns typeface, and includes
color modes inspired by the Sketchy Mode palette from the design brief.

## Features

- 🖋️ **Sketch primitives** – rectangles, circles, badges, etc. with cached
  seeds so you can draw custom shapes without flicker.
- 🎨 **Color modes** – Light → Dark (with Red, Orange, Yellow, Green, Cyan,
  Blue, Indigo, Violet, Magenta in between). Widgets react instantly when
  the mode changes.
- 📐 **Roughness dial** – global knob that trades “wobble” for performance (0 =
  straight lines, 1 = max sketch).
- 🧰 **Widget catalog** – buttons, inputs, dialogs, checkboxes, toggles, tabs,
  tooltips, etc. suitable for production apps.
- 📚 **Example gallery** – responsive master/detail demo with built-in mode
  picker, roughness slider, and mascot (meh.) that showcases every component
  (including the scenarios from wired_elements).

## Getting started

1. Add Sketchy to your `pubspec.yaml`:

   ```yaml
   dependencies:
     sketchy_design_lang:
       git:
         url: https://github.com/<your-org>/sketchy_design_lang.git
   ```

2. Import the package and wrap your app with `SketchyApp`:

   ```dart
   import 'package:sketchy_design_lang/sketchy_design_lang.dart';

   void main() {
     runApp(
       SketchyApp(
         title: 'Sketchy Demo',
         theme: SketchyThemeData.modes.blue(),
         home: const MySketchyScreen(),
       ),
     );
   }
   ```

3. Use Sketchy widgets just like Material widgets (`SketchyButton`,
   `SketchyTextField`, `SketchyCard`, etc.). Swap color modes or roughness at
   runtime via the theme extensions.

## Example gallery

The `/example` app doubles as our storybook. Run it with:

```bash
cd example
flutter run
```

The gallery demonstrates:

- Responsive list / master-detail layouts.
- Live color-mode switches (cycle via the sketchy color circle).
- Roughness slider in the action bar.
- The Sketchy mascot floating bottom-left (tooltip “meh.”).
- All ported wired_elements demos.

## Contributing & support

- Issues/ideas: open a GitHub issue.
- Want to add new widgets or modes? Submit a PR—please include docs + example
  updates.
- All lint/test checks (`flutter analyze` & `flutter test`) must pass before
  merge.

Let’s make wireframes feel alive! 💥
