import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/validator/validator.dart';
import 'package:pyc/components/appbar/default_app_bar.dart';
import 'package:pyc/components/form/default_border_input_field.dart';
import 'package:pyc/components/loading/loading_overlay.dart';
import 'package:pyc/controllers/calendar/calendar_controller.dart';
import 'package:pyc/data/model/calendar/response/calendar_response.dart';
import 'package:pyc/data/repository/calendar_repository.dart';
import 'package:pyc/extension/date_time.dart';
import 'package:pyc/screens/calendar/components/calendar_date_form_field.dart';
import 'package:pyc/screens/calendar/components/calendar_event_card.dart';
import 'package:pyc/screens/calendar/components/default_table_calendar.dart';
import 'package:pyc/screens/index/components/layout/labeled_content.dart';

/// CalendarScreen
///
/// @description: 해당 Widget을 StateFul Widget으로 선언한 이유는 StateWidget의 LifeCycle을 이용하여
/// Getx의 Controller를 Put/Delete 하기 위함이다.
/// 일정관리를 할 수 있는 Screen이며 일정에 대한 C,R,U,D가 일어난다.
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DateTime firstDay = DateTime(2022, 1, 1);
  final DateTime lastDay = DateTime(2099, 12, 31);
  final String locale = 'ko-KR';
  String title = '';
  String content = '';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Get.put(CalendarController(repository: Get.find<CalendarRepository>()));
    log('Init CalendarScreen');
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<CalendarController>();
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
            GetBuilder<CalendarController>(
              builder: (controller) => DefaultTableCalendar(
                locale: locale,
                firstDay: firstDay,
                lastDay: lastDay,
                focusDay: controller.focusDay,
                selectedDay: controller.selectedDay,
                onSelect: controller.selectDay,
                onPageChanged: controller.updatePage,
                eventLoader: controller.getEventsForDay,
              ),
            ),

            /// Spacer
            kDoubleHeightSizeBox,

            /// Event List
            LabeledContent(
              title: '일정',
              child: SizedBox(
                width: double.infinity,
                height: 250,
                child: GetBuilder<CalendarController>(
                  builder: (controller) => ListView(
                    /// TODO: 초기 처음 Screen으로 들어왔을 때 현재 날짜의 이벤트를 List 뿌려주기
                    children: [
                      ...controller.getEventsForDay(controller.selectedDay).map(
                            (e) => CalendarEventCard(
                              onTap: () => _showBottomSheetModal(data: e),
                              title: e.title,
                              content: e.content,
                              subContent: e.isAllDay ? '\n하루종일' : '\n${e.start.toHHmm()} ~ ${e.end.toHHmm()}',
                            ),
                          ),
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

  /// _getActions
  ///
  /// @description: Calendar Widget Appbar에 대한 Action Widget에 대한 List
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

  /// _showBottomSheetModal
  ///
  /// @description: Calendar 일정을 등록, 수정, 삭제를 위한 BottomSheetModal
  /// 인자로 들어오는 Data가 존재한다면 수정, 삭제에 대한 모달을 보여주고 그렇지 않은 경우 생성 모달을 보여준다.
  /// 해당 모달이 종료될 때 whenComplete 이벤트를 통해 start, end, isAllDay에 대한 상태는 초기화 된다.
  void _showBottomSheetModal({CalendarResponse? data}) {
    // Data가 있다면 start, end, isAllDay Update 해주기
    if (data != null) {
      CalendarController controller = Get.find<CalendarController>();
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
            child: GetBuilder<CalendarController>(
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
    ).whenComplete(() => Get.find<CalendarController>().resetBottomSheet());
  }
}
