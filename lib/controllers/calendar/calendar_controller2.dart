import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController2 extends GetxController {
  bool _isLoading = true;
  DateTime _focusDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  @mustCallSuper
  void onInit() {
    super.onInit();
    _isLoading = false;
    update();
  }

  // select
  ///
  /// 날짜가 선택될 때 해당 날짜에 Focusing을 해주기 위함
  selectDay(DateTime selectDay, DateTime focusDay) {
    if (isSameDay(selectedDay, focusDay)) return;
    log('Change ${DateFormat('yyyy-MM-dd').format(_selectedDay)} to ${DateFormat('yyyy-MM-dd').format(selectDay)}');
    _focusDay = selectDay;
    _selectedDay = selectDay;
    update();
  }

  DateTime get focusDay => _focusDay;
  DateTime get selectedDay => _selectedDay;
}
