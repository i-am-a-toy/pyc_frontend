import 'package:dio/dio.dart';
import 'package:pyc/common/libraries/auth_api_client.dart';
import 'package:pyc/data/model/calendar/request/create_calendar_request.dart';
import 'package:pyc/data/model/calendar/request/update_calendar_request.dart';

class CalendarProvider {
  Future<Response> getMonthEvent(
    int year,
    int month, {
    int? offset,
    int? limit,
  }) async {
    final client = await getAuthApiClient();
    Map<String, dynamic> queryParameter = {"year": year, "month": month};
    if (offset != null && limit != null) queryParameter.addAll({'offset': offset, 'limit': limit});

    return client.get(
      '/api/v1/calendars',
      queryParameters: queryParameter,
    );
  }

  Future<void> createCalendar({
    required CreateCalendarRequest req,
  }) async {
    final client = await getAuthApiClient();
    await client.post(
      '/api/v1/calendars',
      data: req.toJson(),
    );
  }

  Future<void> updateCalendar({
    required int id,
    required UpdateCalendarRequest req,
  }) async {
    final client = await getAuthApiClient();
    await client.put(
      '/api/v1/calendars/$id',
      data: req.toJson(),
    );
  }

  Future<void> deleteCalendar({required int id}) async {
    final client = await getAuthApiClient();
    await client.delete('/api/v1/calendars/$id');
  }
}
