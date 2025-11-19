import 'package:flutter/widgets.dart';
import 'package:sketchy_design_lang/sketchy_design_lang.dart';

/// Form screen covering text fields, dropdowns, switches, and validation.
class ExpenseTrackerExample extends StatefulWidget {
  const ExpenseTrackerExample({super.key});

  static Widget builder(BuildContext context) => const ExpenseTrackerExample();

  @override
  State<ExpenseTrackerExample> createState() => _ExpenseTrackerExampleState();
}

class _ExpenseTrackerExampleState extends State<ExpenseTrackerExample> {
  final _amountController = TextEditingController(text: '128.00');
  final _noteController = TextEditingController(text: 'Client kickoff snacks');
  bool _recurring = false;
  String _category = 'Meals';

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) {
      final typography = theme.typography;

      return Column(
        children: [
          // Header replacement for AppBar
          Container(
            height: 56,
            color: theme.colors.primary,
            alignment: Alignment.center,
            child: Text(
              'Expense Tracker',
              style: typography.title.copyWith(
                color: theme.colors.secondary,
                fontSize: 24,
              ),
            ),
          ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: SketchyCard(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('New expense', style: typography.headline),
                    const SizedBox(height: 16),
                    SketchyTextInput(
                      labelText: r'Amount ($)',
                      controller: _amountController,
                      onChanged: (value) => setState(() {}),
                    ),
                    if (_amountController.text.isEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Amount required',
                        style: typography.caption.copyWith(
                          color: const Color(0xFFB00020), // Error color
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    SketchyTextInput(
                      labelText: 'Notes',
                      controller: _noteController,
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 16),
                    SketchyCombo<String>(
                      value: _category,
                      items: const ['Meals', 'Travel', 'Supplies']
                          .map(
                            (value) => SketchyComboItem<String>(
                              value: value,
                              child: Text(value, style: typography.body),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _category = value);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Mark as recurring',
                            style: typography.body,
                          ),
                        ),
                        SketchyToggle(
                          value: _recurring,
                          onChanged: (value) =>
                              setState(() => _recurring = value),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: SketchyButton(
                            onPressed: _amountController.text.isEmpty
                                ? null
                                : () {},
                            child: Text(
                              'Submit expense',
                              style: typography.label,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SketchyButton(
                            onPressed: () {},
                            child: Text('Save draft', style: typography.label),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
      );
    },
  );
}
