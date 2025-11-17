import 'package:flutter/material.dart';

import 'canvas/wired_canvas.dart';
import 'wired_base.dart';
import 'wired_theme.dart';

/// Wired calendar.
///
/// Usage:
/// ```dart
/// Container(
/// 	color: Colors.grey.shade200,
/// 	padding: EdgeInsets.all(15.0),
/// 	height: 460.0,
/// 	child: WiredCalendar(
/// 	selected: '20210722',
/// 	onSelected: (value) {
/// 		print('Selected date: $value');
/// 		},
/// 	),
/// )
/// ```
class WiredCalendar extends StatefulWidget {
  const WiredCalendar({Key? key, this.selected, this.onSelected})
    : super(key: key);

  /// The date to be selected.
  /// Format: "YYYYMMDD"
  final String? selected;

  /// Called when the selected date changed.
  final void Function(String selected)? onSelected;

  @override
  State<WiredCalendar> createState() => _WiredCalendarState();
}

class _WiredCalendarState extends State<WiredCalendar> {
  final _weekdaysShort = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  DateTime _firstOfMonthDate = DateTime.now();
  final List<CalendarCell> _weeks = [];
  String _monthYear = '';

  String? _selected;
  late WiredThemeData _theme;
  bool _didInitTheme = false;

  @override
  void initState() {
    super.initState();

    _initParams();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = WiredTheme.of(context);
    if (!_didInitTheme) {
      _refresh();
      _didInitTheme = true;
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(10),
    child: Column(
      children: [
        _buildWeekdaysNav(),
        const SizedBox(height: 20),
        _buildWeeksHeaderUI(),
        Expanded(child: _buildWeekdaysUI()),
      ],
    ),
  );

  void _refresh() {
    _setInitialConditions();
    _computeCalendar();
  }

  Padding _buildWeekdaysNav() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: _onPre,
          child: _wiredText('<<', fontWeight: FontWeight.bold, fontSize: 24),
        ),
        _wiredText(_monthYear, fontWeight: FontWeight.bold, fontSize: 22),
        InkWell(
          onTap: _onNext,
          child: _wiredText('>>', fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ],
    ),
  );

  void _onPre() {
    _firstOfMonthDate = DateTime(
      _firstOfMonthDate.year,
      _firstOfMonthDate.month - 1,
      1,
    );
    _computeCalendar();
    setState(() {});
  }

  void _onNext() {
    _firstOfMonthDate = DateTime(
      _firstOfMonthDate.year,
      _firstOfMonthDate.month + 1,
      1,
    );
    _computeCalendar();
    setState(() {});
  }

  Row _buildWeeksHeaderUI() {
    final headers = <Widget>[];
    for (final weekday in _weekdaysShort) {
      headers.add(
        _buildCell(weekday, fontWeight: FontWeight.bold, fontSize: 18.0),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: headers,
    );
  }

  GridView _buildWeekdaysUI() {
    final weekdays = <Widget>[];
    for (final week in _weeks) {
      weekdays.add(
        InkWell(
          onTap: () {
            if (_selected == week.value) return;
            _selected = week.value;
            _refresh();
            setState(() {});

            if (widget.onSelected != null) {
              widget.onSelected!(week.value);
            }
          },
          child: _buildCell(
            week.text,
            selected: week.selected,
            color: week.color,
          ),
        ),
      );
    }

    return GridView.count(crossAxisCount: 7, children: [...weekdays]);
  }

  void _initParams() {
    _selected = widget.selected;
  }

  void _setInitialConditions() {
    DateTime d;
    if (_selected != null) {
      try {
        d = DateTime.parse(_selected!);
      } catch (e) {
        d = DateTime.now();
      }
    } else {
      d = DateTime.now();
    }

    _firstOfMonthDate = DateTime(d.year, d.month, 1);
  }

  void _computeCalendar() {
    _monthYear =
        '${_months[_firstOfMonthDate.month - 1]} ${_firstOfMonthDate.year}';

    final firstDayInMonth = DateTime(
      _firstOfMonthDate.year,
      _firstOfMonthDate.month,
      1,
    );
    var dayInMonthOffset = 0 - (firstDayInMonth.weekday % 7);
    final amountOfWeeks =
        (DateTime(_firstOfMonthDate.year, _firstOfMonthDate.month + 1, 0).day -
            dayInMonthOffset) /
        7;

    _weeks.clear();
    for (var weekIndex = 0; weekIndex < amountOfWeeks; weekIndex++) {
      for (var dayOfWeekIndex = 0; dayOfWeekIndex < 7; dayOfWeekIndex++) {
        final day = DateTime.fromMillisecondsSinceEpoch(
          firstDayInMonth.millisecondsSinceEpoch + DAY * dayInMonthOffset,
        );
        final formatedDate = _format(day);

        _weeks.add(
          CalendarCell(
            value: formatedDate,
            text: day.day.toString(),
            selected: _selected != null && day == DateTime.parse(_selected!),
            dimmed: day.month != firstDayInMonth.month,
            color: day.month == firstDayInMonth.month
                ? _theme.textColor
                : _theme.disabledTextColor,
            disabled: false,
          ),
        );

        dayInMonthOffset++;
      }
    }
  }

  RenderObjectWidget _buildCell(
    String text, {
    selected = false,
    width = 45.0,
    height = 50.0,
    fontWeight = FontWeight.w500,
    fontSize = 20.0,
    Color? color,
  }) => selected
      ? Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 0,
              top: 0,
              width: width,
              height: height,
              child: WiredCanvas(
                painter: WiredCircleBase(
                  diameterRatio: .8,
                  strokeColor: _theme.borderColor,
                ),
                fillerType: RoughFilter.NoFiller,
              ),
            ),
            SizedBox(
              width: width,
              height: height,
              child: Center(
                child: _wiredText(
                  text,
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                  color: color,
                ),
              ),
            ),
          ],
        )
      : SizedBox(
          width: width,
          height: height,
          child: Center(
            child: _wiredText(
              text,
              fontWeight: fontWeight,
              fontSize: fontSize,
              color: color,
            ),
          ),
        );

  Text _wiredText(
    String text, {
    FontWeight fontWeight = FontWeight.w500,
    double fontSize = 18.0,
    Color? color,
  }) => Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontFamily: _theme.fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color ?? _theme.textColor,
    ),
  );

  String _format(DateTime d) =>
      '${d.year}${d.month.toString().padLeft(2, '0')}${d.day.toString().padLeft(2, '0')}';
}

// GLOBAL CONSTANTS
const SECOND = 1000;
const MINUTE = SECOND * 60;
const HOUR = MINUTE * 60;
const DAY = HOUR * 24;

class CalendarCell {
  CalendarCell({
    required this.value,
    required this.text,
    required this.selected,
    required this.dimmed,
    required this.color,
    this.disabled = false,
  });
  final String value;
  final String text;
  final bool selected;
  final bool dimmed;
  final bool disabled;
  final Color color;
}
