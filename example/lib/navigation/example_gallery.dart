import 'package:flutter/widgets.dart';
import 'package:sketchy_design_lang/sketchy_design_lang.dart';

import '../examples/examples.dart';

/// Landing page that lists all example scenes.
class ExampleGallery extends StatelessWidget {
  const ExampleGallery({super.key});

  @override
  Widget build(BuildContext context) => SketchyScaffold(
    appBar: const SketchyAppBar(title: Text('Sketchy Examples')),
    body: ListView.separated(
      padding: const EdgeInsets.all(24),
      itemBuilder: (context, index) {
        final entry = sketchyExamples[index];
        return SketchyCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.title, style: SketchyTypography.of(context).title),
              const SizedBox(height: 8),
              Text(
                entry.description,
                style: SketchyTypography.of(context).body,
              ),
              const SizedBox(height: 16),
              SketchyButton.primary(
                label: 'Open',
                onPressed: () async {
                  await Navigator.of(
                    context,
                  ).push(SketchyPageRoute(builder: entry.builder));
                },
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, _) => const SizedBox(height: 16),
      itemCount: sketchyExamples.length,
    ),
  );
}
