import 'package:get/get.dart';

class CalendarController extends GetxController {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusDay = DateTime.now();
  DateTime get selectedDay => _selectedDay;
  DateTime get focusDay => _focusDay;

  select(DateTime selectDay, DateTime focusDay) {
    _selectedDay = selectDay;
    _focusDay = focusDay;
    update();
  }

  changeFocusDay(DateTime day) {
    _focusDay = day;
  }
}
