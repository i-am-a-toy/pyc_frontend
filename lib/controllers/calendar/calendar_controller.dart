import 'dart:collection';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/data/model/calendar/request/create_calendar_request.dart';
import 'package:pyc/data/model/calendar/request/update_calendar_request.dart';
import 'package:pyc/data/model/calendar/response/calendar_response.dart';
import 'package:pyc/data/repository/calendar_repository.dart';
import 'package:pyc/extension/date_time.dart';
import 'package:table_calendar/table_calendar.dart';

/// CalendarController
///
/// @description: CalendarScreen에서 사용하는 로직 및 상태를 관리하는 Controller
class CalendarController extends GetxController {
  final CalendarRepository repository;
  CalendarController({required this.repository});

  /// For Calendar
  bool _isLoading = true;
  DateTime _focusDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  LinkedHashMap<DateTime, List<CalendarResponse>> _event = LinkedHashMap<DateTime, List<CalendarResponse>>(equals: isSameDay);
  int _count = 0;

  /// For Bottom Modal
  bool _isAllDay = false;
  DateTime _start = DateTime.now().getUtcDateOnly();
  DateTime _end = DateTime.now().getUtcDateOnly();

  @override
  @mustCallSuper
  void onInit() async {
    super.onInit();
    try {
      final result = await repository.getMonthEvent(_selectedDay.year, _selectedDay.month);
      _event = result.toLinkedMap(DateTime.now());
      _count = result.count;
      _isLoading = false;
      update();
    } catch (e) {
      _handingError(e);
    }
  }

  /// selectDay
  ///
  /// @description: Calendar에서 날짜가 선택될 때 마다 호출되는 method
  /// 이로 인해 변경되는 값은 focus, selected, start, end 이다.
  /// start, end를 변경하는 이유는 BottomSheetModal에서 Init 값으로 사용하고 있기 때문이다.
  selectDay(DateTime selectDay, DateTime focusDay) {
    // if (isSameDay(selectedDay, focusDay)) return;
    log('Change select & focus: ${DateFormat('yyyy-MM-dd').format(_selectedDay)} to ${DateFormat('yyyy-MM-dd').format(selectDay)}');
    _selectedDay = selectDay;
    _focusDay = selectDay;
    log('Change start & end: ${DateFormat('yyyy-MM-dd').format(_selectedDay)} to ${DateFormat('yyyy-MM-dd').format(selectDay)}');
    _start = selectDay;
    _end = selectDay;
    update();
  }

  /// updatePage
  ///
  /// @description: 월이 변경될 때 마다 호출되는 method이다.
  /// 인자로 들어오는 값과 달이 동일하다면 toDay를 focus 해주고 그렇지 않다면 인자로 들어온 값으로 상태 변경 (인자는 매월 1일의 값이 들어온다.)
  Future<void> updatePage(DateTime day) async {
    log('Change page ${DateFormat('yyyy-MM').format(_selectedDay)} to ${DateFormat('yyyy-MM').format(day)} ');
    try {
      final result = await repository.getMonthEvent(day.year, day.month);
      _event = result.toLinkedMap(day);
      _count = result.count;

      final utcNow = DateTime.now().getUtcDateOnly();
      _selectedDay = utcNow.month == day.month ? DateTime.now().getUtcDateOnly() : day;
      _focusDay = utcNow.month == day.month ? DateTime.now().getUtcDateOnly() : day;
      update();
    } catch (e) {
      _handingError(e);
    }
  }

  /// getEventsForDay
  ///
  /// @description: 인자로 받는 날짜를 가지고 EventMap인 LinkedHashedMap에 Key값과 비교한다.
  /// 인자로 들어오는 DateTime의 TimeZone은 UTC Date가 들어온다.
  List<CalendarResponse> getEventsForDay(DateTime day) {
    return _event[day] ?? [];
  }

  /// For Bottom Sheet

  /// addCalendar
  ///
  /// @description: 일정의 제목, 본문을 받아 controller의 start, end, isAllDay의 값과 함께 Create
  Future<void> addCalendar(BuildContext context, String title, String content) async {
    log('Hit Add Calendar with title: $title, content: $content, start:${DateFormat('yyyy-MM-dd').format(_start)}, end:${DateFormat('yyyy-MM-dd').format(_end)}, isAllDay: $_isAllDay');

    try {
      /// Data를 Server로 넘겨주면 DB에서 자동으로 UTC 변환을 하며 -9를 하게 된다.
      await repository.save(CreateCalendarRequest(title, content, _start, _end, _isAllDay));
      await repository.getMonthEvent(_focusDay.year, _focusDay.month).then((result) {
        _event = result.toLinkedMap(_focusDay);
        _count = result.count;
        update();
        Navigator.pop(context);
      });
    } catch (e) {
      _handingError(e);
    }
  }

  /// addCalendar
  ///
  /// @description: 일정의 제목, 본문을 받아 controller의 start, end, isAllDay의 값과 함께 Update
  Future<void> updateCalendar(BuildContext context, int id, String title, String content) async {
    log('Hit Update Calendar with id: $id title: $title, content: $content, start:${DateFormat('yyyy-MM-dd').format(_start)}, end:${DateFormat('yyyy-MM-dd').format(_end)}, isAllDay: $_isAllDay');
    try {
      await repository.update(id, UpdateCalendarRequest(title, content, _start, _end, _isAllDay));
      await repository.getMonthEvent(_focusDay.year, _focusDay.month).then((result) {
        _event = result.toLinkedMap(_focusDay);
        _count = result.count;
        update();
        Navigator.pop(context);
      });
    } catch (e) {
      _handingError(e);
    }
  }

  /// deleteCalendar
  ///
  /// @description: calendar의 일정 삭제 하였을 때 호출되는 method
  Future<void> deleteCalendar(BuildContext context, int id) async {
    log('Hit Delete Calendar with $id');
    try {
      await repository.delete(id);
      await repository.getMonthEvent(_focusDay.year, _focusDay.month).then((result) {
        _event = result.toLinkedMap(_focusDay);
        _count = result.count;
        update();
        Navigator.pop(context);
      });
    } catch (e) {
      _handingError(e);
    }
  }

  /// resetBottomSheet
  ///
  /// @description: Calendar의 BottomSheetModal이 닫힐 때 마다 호출되며
  /// start, end, isAllDay의 상태를 초기화 시키는 역할을 한다.
  void resetBottomSheet() {
    _start = _focusDay.getUtcDateOnly();
    _end = _focusDay.getUtcDateOnly();
    _isAllDay = false;
    log('Reset Calendar Bottom Sheet State start, end with ${_focusDay.getUtcDateOnly()}');
    update();
  }

  /// toggleIsAllDay
  ///
  /// @description: BottomSheetModal에서 isAllDay가 클릭 될 때 마다  isAllDay의 상태를 변경
  void toggleIsAllDay(bool? val) {
    _isAllDay = val!;
    update();
  }

  /// updateStart
  ///
  /// @description: BottomSheetModal에서 start의 onConfirm이다.
  /// confirm된 값으로 start를 변경하며 이 떄 end가 start 보다 before이라면 end 또한 start로 상태 변경
  void updateStart(DateTime? val) {
    log('Update Start ${DateFormat('yyyy-MM-dd').format(_start)} to ${DateFormat('yyyy-MM-dd').format(val!)}');
    if (_end.isBefore(val)) {
      log('Update End with Start ${DateFormat('yyyy-MM-dd').format(_end)} to ${DateFormat('yyyy-MM-dd').format(val)}');
      _end = val;
    }
    _start = val;
    update();
  }

  /// updateEnd
  ///
  /// @description BottomSheetModal에서 end의 onConfirm이다.
  void updateEnd(DateTime? val) {
    log('Update End ${DateFormat('yyyy-MM-dd').format(_end)} to ${DateFormat('yyyy-MM-dd').format(val!)}');
    _end = val;
    update();
  }

  /// for Calendar
  DateTime get focusDay => _focusDay;
  DateTime get selectedDay => _selectedDay;
  bool get isLoading => _isLoading;
  int get count => _count;

  /// for BottomSheetModal
  bool get isAllDay => _isAllDay;
  DateTime get start => _start;
  DateTime get end => _end;

  void _handingError(Object e) {
    if (e is DioError && e.response!.statusCode != HttpStatus.internalServerError) {
      _isLoading = false;
      update();

      // sever exception Message
      showSnackbar('요청 실패', e.message);
      return;
    }

    // Internal Service Error or Flutter Error
    showSnackbar('요청 실패', '서버에 문제가 있습니다.\n관리자에게 문의해주세요.');
  }
}
