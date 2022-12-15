import 'package:pyc/data/model/calendar/response/calendar_list_response.dart';
import 'package:pyc/data/model/calendar/response/calendar_response.dart';
import 'package:pyc/data/model/creator/creator_dto.dart';
import 'package:pyc/data/model/last_modifier/last_modifier_dto.dart';

final CalendarListResponse calendarList = CalendarListResponse([
  CalendarResponse(
    1,
    1,
    DateTime.parse('2022-12-01'),
    DateTime.parse('2022-12-01'),
    false,
    '안녕하세요',
    '12월 1일의 이벤트',
    Creator(name: 'leewoooo', role: '리더', image: null),
    DateTime.now(),
    LastModifier(name: 'leewoooo', role: '리더', image: null),
    DateTime.now(),
  ),
  CalendarResponse(
    1,
    1,
    DateTime.parse('2022-12-02'),
    DateTime.parse('2022-12-02'),
    false,
    '안녕하세요',
    '12월 1일의 이벤트',
    Creator(name: 'leewoooo', role: '리더', image: null),
    DateTime.now(),
    LastModifier(name: 'leewoooo', role: '리더', image: null),
    DateTime.now(),
  ),
  CalendarResponse(
    1,
    1,
    DateTime.parse('2022-12-01'),
    DateTime.parse('2022-12-31'),
    false,
    '안녕하세요',
    '12월 1일부터 31일까지의 이벤트',
    Creator(name: 'leewoooo', role: '리더', image: null),
    DateTime.now(),
    LastModifier(name: 'leewoooo', role: '리더', image: null),
    DateTime.now(),
  ),
], 3);
