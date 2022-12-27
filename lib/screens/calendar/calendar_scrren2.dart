import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/builders/calendar_builder.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/theme/calendar_theme.dart';
import 'package:pyc/components/appbar/default_appbar.dart';
import 'package:pyc/components/content/default_avatar_content.dart';
import 'package:pyc/controllers/calendar/calendar_controller2.dart';
import 'package:pyc/screens/index/components/layout/index_layout.dart';
import 'package:table_calendar/table_calendar.dart';

/// CalendarScreen2
///
/// 일정관리를 위한 Screen이며 Getx를 사용하면서 StatefulWidget를 이용하는 이유는
/// StatefulWidget의 LifeCycle을 이용하여 해당 Screen에서 사용하는 Controller를 관리하기 위함.
class CalendarScreen2 extends StatefulWidget {
  const CalendarScreen2({super.key});

  @override
  State<CalendarScreen2> createState() => _CalendarScreen2State();
}

class _CalendarScreen2State extends State<CalendarScreen2> {
  final DateTime firstDay = DateTime(2022, 1, 1);
  final DateTime lastDay = DateTime(2099, 12, 31);
  final String locale = 'ko-KR';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Get.put(CalendarController2());
    log('Init CalendarScreen');
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<CalendarController2>();
    log('dispose CalendarScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getDefaultAppBar(
        title: 'Calendar',
        actions: _getActions(context),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
        child: GetBuilder<CalendarController2>(
          builder: (controller) => Column(
            children: [
              TableCalendar(
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
                  selectedBuilder: getSelectedBuilder,
                ),

                /// select Event
                onDaySelected: controller.selectDay,
                selectedDayPredicate: (day) {
                  return isSameDay(controller.selectedDay, day);
                },
              ),

              /// Spacer
              kDoubleHeightSizeBox,

              /// Event List
              LabeldContent(
                title: '일정',
                goContent: () {},
                child: SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kDefaultValue / 2),
                        child: DefaultAvatarContent(
                          title: '안녕',
                          content: '가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다',
                          subContent: '\n\n작성자 / ${DateFormat('yyyy년 MM월 dd일').format(DateTime.now())}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kDefaultValue / 2),
                        child: DefaultAvatarContent(
                          title: '안녕',
                          content: '가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다',
                          subContent: '\n\n작성자 / ${DateFormat('yyyy년 MM월 dd일').format(DateTime.now())}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kDefaultValue / 2),
                        child: DefaultAvatarContent(
                          title: '안녕',
                          content: '가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다',
                          subContent: '\n\n작성자 / ${DateFormat('yyyy년 MM월 dd일').format(DateTime.now())}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kDefaultValue / 2),
                        child: DefaultAvatarContent(
                          title: '안녕',
                          content: '가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다',
                          subContent: '\n\n작성자 / ${DateFormat('yyyy년 MM월 dd일').format(DateTime.now())}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kDefaultValue / 2),
                        child: DefaultAvatarContent(
                          title: '안녕',
                          content: '가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다',
                          subContent: '\n\n작성자 / ${DateFormat('yyyy년 MM월 dd일').format(DateTime.now())}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kDefaultValue / 2),
                        child: DefaultAvatarContent(
                          title: '안녕',
                          content: '가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다',
                          subContent: '\n\n작성자 / ${DateFormat('yyyy년 MM월 dd일').format(DateTime.now())}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kDefaultValue / 2),
                        child: DefaultAvatarContent(
                          title: '안녕',
                          content: '가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다',
                          subContent: '\n\n작성자 / ${DateFormat('yyyy년 MM월 dd일').format(DateTime.now())}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kDefaultValue / 2),
                        child: DefaultAvatarContent(
                          title: '안녕',
                          content: '가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다',
                          subContent: '\n\n작성자 / ${DateFormat('yyyy년 MM월 dd일').format(DateTime.now())}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kDefaultValue / 2),
                        child: DefaultAvatarContent(
                          title: '안녕',
                          content: '가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다',
                          subContent: '\n\n작성자 / ${DateFormat('yyyy년 MM월 dd일').format(DateTime.now())}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kDefaultValue / 2),
                        child: DefaultAvatarContent(
                          title: '안녕',
                          content: '가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다',
                          subContent: '\n\n작성자 / ${DateFormat('yyyy년 MM월 dd일').format(DateTime.now())}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kDefaultValue / 2),
                        child: DefaultAvatarContent(
                          title: '안녕',
                          content: '가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다가나다',
                          subContent: '\n\n작성자 / ${DateFormat('yyyy년 MM월 dd일').format(DateTime.now())}',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => _showBottomSheetModal(context),
        icon: const Icon(
          Icons.add_outlined,
          size: kDefaultValue * 1.5,
        ),
      ),
    ];
  }

  void _showBottomSheetModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      // isScrollControlled: true,

      /// Border Shape
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),

      builder: (_) => Form(
        key: formKey,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.75,
          ),
        ),
      ),
    );
  }
}
