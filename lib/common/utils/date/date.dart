import 'package:flutter/material.dart';

String getDifferceTime(DateTime targetDate) {
  final today = getDateOnly(DateTime.now());
  final target = getDateOnly(targetDate);

  if (DateUtils.isSameDay(today, target)) return '오늘';

  final Duration duration = today.difference(target);
  return '${duration.inDays}일전';
}

DateTime getDateOnly(DateTime t) {
  return DateTime(t.year, t.month, t.day);
}
