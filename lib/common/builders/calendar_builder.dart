import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

Widget? getDowBuilder(BuildContext context, DateTime day) {
  switch (day.weekday) {
    case DateTime.monday:
      return const Center(
        child: Text('월'),
      );
    case DateTime.tuesday:
      return const Center(
        child: Text('화'),
      );
    case DateTime.wednesday:
      return const Center(
        child: Text('수'),
      );
    case DateTime.thursday:
      return const Center(
        child: Text('목'),
      );
    case DateTime.friday:
      return const Center(
        child: Text('금'),
      );
    case DateTime.saturday:
      return const Center(
        child: Text(
          '토',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    default:
      return const Center(
        child: Text(
          '일',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
  }
}

Widget? getMarkerBuilder(
  BuildContext context,
  DateTime day,
  List<Object?> events,
) {
  return events.isNotEmpty
      ? Container(
          width: kDefaultValue / 4,
          height: kDefaultValue / 2,
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.circle,
          ),
        )
      : null;
}

Widget? getSelectedBuilder(
  BuildContext context,
  DateTime day,
  DateTime focusedDay,
) {
  return Container(
    width: kDefaultValue * 1.5,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      color: kPrimaryColor,
      shape: BoxShape.circle,
    ),
    child: Text(
      day.day.toString(),
      style: const TextStyle(
        color: kTextWhiteColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget? getTodayBuilder(
  BuildContext context,
  DateTime day,
  DateTime focusedDay,
) {
  return Container(
    width: kDefaultValue * 1.5,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      color: kPointColor,
      shape: BoxShape.circle,
    ),
    child: Text(
      day.day.toString(),
      style: const TextStyle(
        color: kTextWhiteColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
