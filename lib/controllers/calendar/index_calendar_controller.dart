import 'dart:developer';

import 'package:get/get.dart';
import 'package:pyc/data/model/calendar/response/calendar_list_response.dart';
import 'package:pyc/data/model/calendar/response/calendar_response.dart';
import 'package:pyc/data/repository/calendar_repository.dart';
import 'package:pyc/extension/date_time.dart';

/// IndexCalendarController
///
/// @description: IndexPage에서 일정안내 Card를 제공하기 위한 Controller
class IndexCalendarController extends GetxController {
  final CalendarRepository repository;
  IndexCalendarController({required this.repository});

  /// default Offset & limit
  final int offset = 0;
  final int limit = 0;

  /// State
  bool _isLoading = true;
  List<CalendarResponse> _rows = [];
  int _count = 0;

  @override
  void onInit() async {
    super.onInit();
    log('Init IndexCalendarController & Try Fetch Data');
    final result = await _fetch();
    _rows = result.rows;
    _count = result.count;
    _isLoading = false;
    update();
  }

  void reFetch() async {
    log('Try Refetch Index Calendar List');
    _isLoading = true;
    update();

    final result = await _fetch();
    _rows = result.rows;
    _count = result.count;
    _isLoading = false;
    update();
  }

  Future<CalendarListResponse> _fetch() async {
    final DateTime now = DateTime.now().getUtcDateOnly();
    return repository.getMonthEvent(now.year, now.month, offset: offset, limit: limit);
  }

  bool get isLoading => _isLoading;
  List<CalendarResponse> get rows => _rows;
  int get count => _count;
}
