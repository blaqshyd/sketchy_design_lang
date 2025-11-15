import 'package:flutter/widgets.dart';

import 'critique_board.dart';
import 'dashboard.dart';
import 'docs_viewer.dart';
import 'expense_tracker.dart';
import 'live_chat.dart';
import 'quiz_card.dart';
import 'spotlight_panel.dart';
import 'whiteboard_palette.dart';

/// Metadata for a single Sketchy example scene.
class SketchyExampleEntry {
  /// Creates an entry describing one example.
  const SketchyExampleEntry({
    required this.id,
    required this.title,
    required this.description,
    required this.builder,
  });

  /// Stable identifier used for routing.
  final String id;

  /// User-facing title displayed in the gallery.
  final String title;

  /// Short description of what the example demonstrates.
  final String description;

  /// Builder that returns the example widget.
  final WidgetBuilder builder;
}

final List<SketchyExampleEntry> sketchyExamples = [
  SketchyExampleEntry(
    id: 'spotlight-panel',
    title: 'Spotlight Panel',
    description: _para([
      'Hero card with annotations calling out the key primary/secondary',
      'actions.'
    ]),
    builder: SketchySpotlightPanelExample.builder,
  ),
  SketchyExampleEntry(
    id: 'wireframe-dashboard',
    title: 'Wireframe Productivity Dashboard',
    description: _para([
      'Desktop layout with sidebar navigation, draggable cards, and',
      'sketchy charts.'
    ]),
    builder: WireframeDashboardExample.builder,
  ),
  SketchyExampleEntry(
    id: 'critique-board',
    title: 'Collaborative Design Critique Board',
    description: _para([
      'Gallery grid that overlays badges and hover annotations on uploaded',
      'work.'
    ]),
    builder: CollaborativeCritiqueBoardExample.builder,
  ),
  SketchyExampleEntry(
    id: 'expense-tracker',
    title: 'Mobile Expense Tracker Form',
    description: _para([
      'Form controls with validation-driven annotations and sketchy',
      'toggles.'
    ]),
    builder: ExpenseTrackerExample.builder,
  ),
  SketchyExampleEntry(
    id: 'quiz-card',
    title: 'Education Quiz Card',
    description: _para([
      'Single quiz card showing chips, progress, and celebratory',
      'highlights.'
    ]),
    builder: QuizCardExample.builder,
  ),
  SketchyExampleEntry(
    id: 'docs-viewer',
    title: 'Developer Documentation Viewer',
    description: _para([
      'Tab-based viewer with inline tooltips, dividers, and hover',
      'effects.'
    ]),
    builder: DocsViewerExample.builder,
  ),
  SketchyExampleEntry(
    id: 'whiteboard-palette',
    title: 'Hackathon Whiteboard Palette',
    description: _para([
      'Canvas built with rough primitives plus floating sliders and',
      'switches.'
    ]),
    builder: WhiteboardPaletteExample.builder,
  ),
  SketchyExampleEntry(
    id: 'live-chat',
    title: 'Customer Support Live Chat',
    description: _para([
      'Chat transcript with rough list tiles, typing indicators, and',
      'suggestion chips.'
    ]),
    builder: LiveChatExample.builder,
  ),
];

String _para(List<String> lines) => lines.join(' ');
