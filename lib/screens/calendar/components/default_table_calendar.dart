import 'package:flutter/material.dart';
import 'package:pyc/common/builders/calendar_builder.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/theme/calendar_theme.dart';
import 'package:table_calendar/table_calendar.dart';

class DefaultTableCalendar extends StatelessWidget {
  const DefaultTableCalendar({
    Key? key,
    required this.locale,
    required this.firstDay,
    required this.lastDay,
    required this.focusDay,
    required this.selectedDay,
    required this.onSelect,
    required this.onPageChanged,
    required this.eventLoader,
  }) : super(key: key);

  final String locale;
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusDay;
  final DateTime selectedDay;
  final void Function(DateTime, DateTime) onSelect;
  final void Function(DateTime) onPageChanged;
  final List<Object> Function(DateTime) eventLoader;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      /// for Scroll
      availableGestures: AvailableGestures.none,

      /// initial Setting
      locale: locale,
      firstDay: firstDay,
      lastDay: lastDay,
      focusedDay: focusDay,
      daysOfWeekHeight: kDefaultValue,

      /// style
      headerStyle: getHeaderStyle(),
      calendarStyle: getCalendarStyle(),
      calendarBuilders: const CalendarBuilders(
        dowBuilder: getDowBuilder,
        markerBuilder: getMarkerBuilder,
        selectedBuilder: getSelectedBuilder,
        todayBuilder: getTodayBuilder,
      ),

      /// select Event
      onDaySelected: onSelect,
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
      onPageChanged: onPageChanged,

      /// show Event
      eventLoader: eventLoader,
    );
  }
}
