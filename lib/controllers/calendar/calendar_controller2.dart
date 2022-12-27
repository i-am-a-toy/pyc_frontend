import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/utils/date/date.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController2 extends GetxController {
  /// For Calendar
  bool _isLoading = true;
  DateTime _focusDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  /// For Bottom Modal
  bool _isAllDay = false;

  @override
  @mustCallSuper
  void onInit() {
    super.onInit();
    _isLoading = false;
    update();
  }

  /// select
  ///
  /// 날짜가 선택될 때 해당 날짜에 Focusing을 해주기 위함
  selectDay(DateTime selectDay, DateTime focusDay) {
    if (isSameDay(selectedDay, focusDay)) return;
    log('Change ${DateFormat('yyyy-MM-dd').format(_selectedDay)} to ${DateFormat('yyyy-MM-dd').format(selectDay)}');
    _focusDay = selectDay;
    _selectedDay = selectDay;
    update();
  }

  /// addCalendar
  ///
  /// 일정의 제목과 본문을 받아 일정을 등록
  addCalendar(String title, String content) {
    log('Hit Add Calendar with title: $title, content: $content');
  }

  /// For Bottom Sheet
  void toggleIsAllDay(bool? val) {
    _isAllDay = val!;
    update();
  }

  void resetBottomSheet() {
    final currentFocusing = getDateOnly(_focusDay).toLocal();
    // _start = currentFocusing;
    // _end = currentFocusing;
    _isAllDay = false;
    log('Reset Calendar Bottom Sheet State start, end with $currentFocusing');
    update();
  }

  DateTime get focusDay => _focusDay;
  DateTime get selectedDay => _selectedDay;
  bool get isLoading => _isLoading;

  bool get isAllDay => _isAllDay;
}
