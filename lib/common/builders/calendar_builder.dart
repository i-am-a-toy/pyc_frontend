import 'dart:math';

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
          width: kDefaultValue,
          height: kDefaultValue,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
            shape: BoxShape.circle,
          ),
          child: Text(
            '${events.length}',
            style: const TextStyle(
              fontSize: 12.0,
              color: kTextWhiteColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      : null;
}
