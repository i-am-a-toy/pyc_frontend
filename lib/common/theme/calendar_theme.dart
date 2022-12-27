import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:table_calendar/table_calendar.dart';

HeaderStyle getHeaderStyle() {
  return const HeaderStyle(
    formatButtonVisible: false,
    titleCentered: true,
    titleTextStyle: TextStyle(
      color: kPrimaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
    ),
    leftChevronIcon: Icon(
      Icons.chevron_left_outlined,
      color: kPrimaryColor,
      size: 36.0,
    ),
    rightChevronIcon: Icon(
      Icons.chevron_right_outlined,
      color: kPrimaryColor,
      size: 36.0,
    ),
  );
}

CalendarStyle getCalendarStyle() {
  return const CalendarStyle(
    selectedDecoration: BoxDecoration(
      color: kPrimaryColor,
      shape: BoxShape.circle,
    ),
    isTodayHighlighted: false,
    defaultTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    markersAlignment: Alignment.bottomCenter,
    canMarkersOverflow: false,
  );
}
