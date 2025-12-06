## 0.2.0

### New Widgets

* `SketchyAvatar` - Circular avatar with initials, online indicator, and
  sketchy styling

* `SketchyDrawer` - Slide-out drawer with controller for programmatic open/close

* `SketchyControlAffinity` - Enum to control leading/trailing placement

* `SketchyFabLocation` - Enum for FAB positioning in scaffold

### New Symbols
* Added `menu`, `hash` symbols to `SketchySymbols`

### New Example Apps
* **Chat** - A virtual therapist chat app powered by the classic ELIZA
  algorithm (eliza_chat package). Features therapy-themed channels, real-time
  responses, and a responsive two-panel layout with full-width dividers.

* **Counter** - A minimal counter app demonstrating basic Sketchy widgets

* **Example** - A simple hello, world.

### Fixes & Improvements
* Reorganized exports with barrel files (`app.dart`, `primitives.dart`,
  `theme.dart`) for cleaner imports

* Various widget refinements and Material isolation improvements

* Fixed font asset path case sensitivity issue that caused build failures on
  Linux (thanks @blaqshyd)

* Fixed sketchy styles in apps not pulling in the font by default.

## 0.1.2

* README update

## 0.1.1

* README update

## 0.1.0

* initial release.
