import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// isAfterOrEqualTo
  ///
  /// 시간이 인자로 받은 시간과 동일하거나 이후인지 비교해주는 method
  bool isAfterOrEqualTo(DateTime dateTime) {
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(this);
    return isAtSameMomentAs | isAfter(dateTime);
  }

  /// isBeforeOrEqualTo
  ///
  /// 시간이 인자로 받은 시간과 동일하거나 이전인지 비교해주는 method
  bool isBeforeOrEqualTo(DateTime dateTime) {
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(this);
    return isAtSameMomentAs | isBefore(dateTime);
  }

  /// isBetween
  ///
  /// 시간이 from과 to 사이에 있는지 비교해주는 method
  bool isBetween(
    DateTime fromDateTime,
    DateTime toDateTime,
  ) {
    final isAfter = isAfterOrEqualTo(fromDateTime);
    final isBefore = isBeforeOrEqualTo(toDateTime);
    return isAfter && isBefore;
  }

  /// getDifferenceNow
  ///
  /// 날짜와 현재 시간의 차이를 return하는 method
  String getDifferenceNow() {
    final today = DateTime.now().dateOnly();
    final target = dateOnly();

    if (DateUtils.isSameDay(today, target)) return '오늘';

    final Duration duration = today.difference(target);
    return duration.inDays < 3 ? '${duration.inDays}일전' : DateFormat('yyyy-MM-dd').format(this);
  }

  /// dateOnly
  ///
  /// 시간을 제외한 날짜를 만들어 주는 method
  DateTime dateOnly() {
    return DateTime(year, month, day);
  }

  /// getLastDayOfMonth
  ///
  /// 날짜의 마지막 날을 얻어오는 method
  /// 12월인 경우에만 년도에 1을 더해 얻어온다.
  DateTime getLastDayOfMonth() {
    return month < 12 ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);
  }

  /// getUtcDateOnly
  ///
  /// DateTime.now()를 UTC로 변환
  DateTime getUtcDateOnly() {
    return DateTime.utc(year, month, day);
  }

  String toYYYYMMDD() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String toYYMMDD() {
    return DateFormat('yy-MM-dd').format(this);
  }
}
