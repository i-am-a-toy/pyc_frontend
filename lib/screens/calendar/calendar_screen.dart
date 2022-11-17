import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/builders/calendar_builder.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/theme/calendar_theme.dart';
import 'package:pyc/controllers/calendar/calendar_controller.dart';
import 'package:pyc/screens/calendar/components/calendar_appbar.dart';
import 'package:pyc/screens/index/components/index_content_card.dart';
import 'package:pyc/screens/index/components/index_content_layout.dart';
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

/// StatelessWidget에서는 라이프 사이클을 사용할 수 없기 때문에
/// initState 및 dispose를 이용하기 위해 StatefulWidget를 사용.
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DateTime _calendarStartDate = DateTime(2022, 1, 1);
  final DateTime _calendarEndDate = DateTime(2099, 12, 31);
  final String _calendarLocale = 'ko-KR';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getCalendarAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultValue,
        ),
        child: Column(
          children: [
            GetBuilder<CalendarController>(
              builder: (controller) => TableCalendar(
                locale: _calendarLocale,
                firstDay: _calendarStartDate,
                lastDay: _calendarEndDate,
                focusedDay: controller.focusDay,
                daysOfWeekHeight: kDefaultValue,
                // for scroll able
                availableGestures: AvailableGestures.none,
                headerStyle: getHeaderStyle(),
                calendarStyle: getCalendarStyle(),
                calendarBuilders: const CalendarBuilders(
                  dowBuilder: getDowBuilder,
                  markerBuilder: getMarkerBuilder,
                ),
                eventLoader: _getEventsForDay,
                onDaySelected: (selectedDay, focusedDay) {
                  if (isSameDay(selectedDay, controller.focusDay)) return;
                  controller.select(selectedDay, focusedDay);
                },
                selectedDayPredicate: (day) {
                  return isSameDay(controller.selectedDay, day);
                },
                onPageChanged: (focusedDay) {
                  if (focusedDay.month == DateTime.now().month) {
                    controller.select(DateTime.now(), DateTime.now());
                    return;
                  }
                  controller.select(focusedDay, focusedDay);
                },
              ),
            ),
            kHeightSizeBox,
            // 이벤트 리스트
            SizedBox(
              child: IndexContentLayout(
                goContent: () {},
                title: '이벤트',
                child: SizedBox(
                  height: 200,
                  child: ListView(
                    children: [
                      IndexContentCard(
                        avatarChild: const Icon(
                          Icons.event,
                        ),
                        content: '테스트',
                        subContent: '안녕하세요',
                        goTo: () {},
                      ),
                      kHeightSizeBox,
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
