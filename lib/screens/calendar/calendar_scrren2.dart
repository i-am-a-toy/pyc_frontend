import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/builders/calendar_builder.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/theme/calendar_theme.dart';
import 'package:pyc/common/utils/validator/validator.dart';
import 'package:pyc/components/appbar/default_appbar.dart';
import 'package:pyc/components/content/default_avatar_content.dart';
import 'package:pyc/components/form/default_border_input_field.dart';
import 'package:pyc/components/loading/loading_overlay.dart';
import 'package:pyc/controllers/calendar/calendar_controller2.dart';
import 'package:pyc/data/model/calendar/response/calendar_response.dart';
import 'package:pyc/data/repository/calendar_repository.dart';
import 'package:pyc/extension/date_time.dart';
import 'package:pyc/screens/calendar/components/calendar_date_form_field.dart';
import 'package:pyc/screens/index/components/layout/labeled_content.dart';
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
  String title = '';
  String content = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Get.put(CalendarController2(repository: Get.find<CalendarRepository>()));
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
        actions: _getActions(),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
        child: Column(
          children: [
            GetBuilder<CalendarController2>(
              builder: (controller) => TableCalendar(
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
                  todayBuilder: getTodayBuilder,
                ),

                /// select Event
                onDaySelected: controller.selectDay,
                selectedDayPredicate: (day) {
                  return isSameDay(controller.selectedDay, day);
                },
                onPageChanged: controller.updatePage,

                /// show Event
                eventLoader: controller.getEventsForDay,
              ),
            ),

            /// Spacer
            kHeightSizeBox,

            /// Event List
            LabeledContent(
              title: '일정',
              child: SizedBox(
                width: double.infinity,
                height: 250,
                child: GetBuilder<CalendarController2>(
                  builder: (controller) => ListView(
                    children: [
                      ...controller.getEventsForDay(controller.selectedDay).map(
                            (e) => InkWell(
                              onTap: () => _showBottomSheetModal(data: e),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: kDefaultValue / 2),
                                child: DefaultAvatarContent(
                                  title: e.title,
                                  content: e.content,
                                  subContent:
                                      e.isAllDay ? null : '\n\n${DateFormat('yy-MM-dd').format(e.start)} ~ ${DateFormat('yy-MM-dd').format(e.end)}',
                                ),
                              ),
                            ),
                          )
                    ],
                  ),
                ),
              ),
            ),

            /// Spacer
            kDoubleHeightSizeBox,
          ],
        ),
      ),
    );
  }

  List<Widget> _getActions() {
    return [
      IconButton(
        onPressed: () => _showBottomSheetModal(),
        icon: const Icon(
          Icons.add_outlined,
          size: kDefaultValue * 1.5,
        ),
      ),
    ];
  }

  void _showBottomSheetModal({CalendarResponse? data}) {
    // Data가 있다면 start, end, isAllDay Update 해주기
    if (data != null) {
      CalendarController2 controller = Get.find<CalendarController2>();
      controller.updateStart(data.start);
      controller.updateEnd(data.end);
      controller.toggleIsAllDay(data.isAllDay);
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      /// Border Shape
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),

      builder: (context) => Form(
        key: formKey,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.75,
            child: GetBuilder<CalendarController2>(
              builder: (controller) => LoadingOverlay(
                isLoading: controller.isLoading,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: kDefaultValue,
                    right: kDefaultValue,
                    left: kDefaultValue,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          data == null
                              ? IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    Icons.close_outlined,
                                    color: kPrimaryColor,
                                    size: kDefaultValue * 1.5,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () async => await controller.deleteCalendar(context, data.id),
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: kPrimaryColor,
                                    size: kDefaultValue * 1.5,
                                  ),
                                ),
                          data == null
                              ? IconButton(
                                  onPressed: () async {
                                    /// validate
                                    if (!formKey.currentState!.validate()) return;

                                    /// save & pop
                                    formKey.currentState!.save();
                                    await controller.addCalendar(context, title, content);
                                  },
                                  icon: const Icon(
                                    Icons.add_outlined,
                                    color: kPrimaryColor,
                                    size: kDefaultValue * 1.5,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () async {
                                    /// validate
                                    if (!formKey.currentState!.validate()) return;

                                    /// save & pop
                                    formKey.currentState!.save();
                                    await controller.updateCalendar(context, data.id, title, content);
                                  },
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    color: kPrimaryColor,
                                    size: kDefaultValue * 1.5,
                                  ),
                                ),
                        ],
                      ),

                      /// Spacer
                      kHeightSizeBox,

                      /// Title Form
                      DefaultBorderInputField(
                        hint: '일정에 제목을 입력해주세요.',
                        maxLine: 2,
                        init: data?.title,
                        onSaved: (val) => title = val!.trim(),
                        validator: requiredStringValidator,
                      ),

                      /// Spacer
                      kHeightSizeBox,

                      /// Title Form
                      DefaultBorderInputField(
                        hint: '일정에 대한 설명을 입력해주세요.',
                        maxLine: 5,
                        init: data?.content,
                        onSaved: (val) => content = val!.trim(),
                        validator: requiredStringValidator,
                      ),

                      /// isAllDay switch
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('하루종일'),
                          Switch(
                            value: controller.isAllDay,
                            onChanged: controller.toggleIsAllDay,
                            activeColor: kPrimaryColor,
                          ),
                        ],
                      ),
                      kHeightSizeBox,

                      /// Start
                      CalendarDateFormField(
                        context: context,
                        title: '시작',
                        isAllDay: controller.isAllDay,
                        initialValue: controller.start,
                        onConfirm: controller.updateStart,
                      ),

                      /// Spacer
                      kHeightSizeBox,

                      /// End
                      CalendarDateFormField(
                        context: context,
                        title: '종료',
                        isAllDay: controller.isAllDay,
                        initialValue: controller.end,
                        minTime: controller.start,
                        onConfirm: controller.updateEnd,
                        validator: (val) => controller.end.isAfterOrEqualTo(val!) ? null : '종료는 시작과 같거나 이 후 시점이여야 합니다.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ).whenComplete(() => Get.find<CalendarController2>().resetBottomSheet());
  }
}
