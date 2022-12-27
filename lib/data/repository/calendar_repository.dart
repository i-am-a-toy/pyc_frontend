import 'package:get/get.dart';
import 'package:pyc/data/model/calendar/request/create_calendar_request.dart';
import 'package:pyc/data/model/calendar/response/calendar_list_response.dart';
import 'package:pyc/data/provider/calendar_provider.dart';

class CalendarRepository extends GetxService {
  final CalendarProvider calendarProvider;
  CalendarRepository({required this.calendarProvider});

  Future<CalendarListResponse> getMonthEvent(int year, int month, {int? offset, int? limit}) async {
    final result = await calendarProvider.getMonthEvent(
      year,
      month,
      offset: offset,
      limit: limit,
    );
    return CalendarListResponse.fromJSON(result.data);
  }

  Future<void> save(CreateCalendarRequest req) async {
    await calendarProvider.createCalendar(req: req);
  }
}
