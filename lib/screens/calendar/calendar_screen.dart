import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/builders/calendar_builder.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/theme/calendar_theme.dart';
import 'package:pyc/components/appbar/default_appbar.dart';
import 'package:pyc/components/loading/loading_overlay.dart';
import 'package:pyc/controllers/calendar/calendar_controller.dart';
import 'package:table_calendar/table_calendar.dart';

// https://github.com/aleksanderwozniak/table_calendar/issues/160#issuecomment-773265340
class Event {
  String title;

  Event(this.title);
}

Map<DateTime, List<Event>> events = {
  DateTime.utc(2022, 11, 13): [Event('title')],
  DateTime.utc(2022, 11, 19): [Event('은하생일')],
};

List<Event> _getEventsForDay(DateTime day) {
  return events[day] ?? [];
}

/// CalendarScreen
///
/// Getx를 사용하면서 CalendarScreen 위젯을 StatefulWidget로 작성한 이유는
/// 해당 위젯을 보여줄 때 Route로 관리되는 것이 아니기 때문
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DateTime firstDay = DateTime(2022, 1, 1);
  final DateTime lastDay = DateTime(2099, 12, 31);
  final String locale = 'ko-KR';

  @override
  void initState() {
    super.initState();
    Get.put<CalendarController>(CalendarController());
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<CalendarController>();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(CalendarController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getDefaultAppBar(title: 'Calendar'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultValue,
        ),
        child: Column(
          children: [
            GetBuilder<CalendarController>(
              builder: (controller) => LoadingOverlay(
                isLoading: controller.isLoading,
                child: TableCalendar(
                  /// for Scroll
                  availableGestures: AvailableGestures.none,

                  /// initial Setting
                  locale: locale,
                  firstDay: firstDay,
                  lastDay: lastDay,
                  focusedDay: controller.focusDay,
                  daysOfWeekHeight: kDefaultValue,

                  /// style
                  headerStyle: getHeaderStyle(),
                  calendarStyle: getCalendarStyle(),
                  calendarBuilders: const CalendarBuilders(
                    dowBuilder: getDowBuilder,
                    markerBuilder: getMarkerBuilder,
                  ),

                  /// select Event
                  onDaySelected: (selectedDay, focusedDay) {
                    if (isSameDay(selectedDay, controller.focusDay)) return;
                    controller.select(selectedDay, focusedDay);
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(controller.selectedDay, day);
                  },

                  /// TODO: 달이 변경 되면 월의 이벤트를 불러와 Event를 Update
                  /// 여기서 상태를 변경하여 Calendar를 Rerendering 하게 되면
                  /// eventLoader에서 현재 달+ 이동되는 달 까지의 loop를 돌게된다.
                  onPageChanged: (focusedDay) {},

                  // eventLoader: _getEventsForDay,
                  eventLoader: controller.getEventsForDay,
                ),
              ),
            ),
            kHeightSizeBox,
            // 이벤트 리스트
          ],
        ),
      ),
    );
  }
}
