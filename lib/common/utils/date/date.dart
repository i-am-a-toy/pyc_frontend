import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getDifferceTime(DateTime targetDate) {
  final today = getDateOnly(DateTime.now().toLocal());
  final target = getDateOnly(targetDate.toLocal());

  if (DateUtils.isSameDay(today, target)) return '오늘';

  final Duration duration = today.difference(target);
  return duration.inDays < 3 ? '${duration.inDays}일전' : DateFormat('yyyy-MM-dd').format(targetDate);
}

DateTime getDateOnly(DateTime t) {
  return DateTime(t.year, t.month, t.day);
}
