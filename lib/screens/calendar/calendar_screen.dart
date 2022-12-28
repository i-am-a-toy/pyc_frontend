import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/extension/date_time.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/builders/calendar_builder.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/theme/calendar_theme.dart';
import 'package:pyc/common/utils/validator/validator.dart';
import 'package:pyc/components/appbar/default_appbar.dart';
import 'package:pyc/components/content/default_avatar_content.dart';
import 'package:pyc/components/form/default_border_input_field.dart';
import 'package:pyc/components/loading/loading_overlay.dart';
import 'package:pyc/controllers/calendar/calendar_controller.dart';
import 'package:pyc/data/repository/calendar_repository.dart';
import 'package:pyc/screens/calendar/components/calendar_date_form_field.dart';
import 'package:pyc/screens/index/components/layout/labeled_content.dart';
import 'package:table_calendar/table_calendar.dart';

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
    Get.put(CalendarController(repository: Get.find<CalendarRepository>()));
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<CalendarController>();
  }

  @override
  Widget build(BuildContext context) {
    String title = '';
    String content = '';

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getDefaultAppBar(
        title: 'Calendar',
        actions: [
          /// for Bottom Sheet
          IconButton(
            onPressed: () {
              /// init Bottom Sheet Start & end
              Get.find<CalendarController>().resetBottomSheet();

              /// showModalBottomSheet
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

                  /// GestureDetector because close keboard
                  child: GestureDetector(
                    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.75,

                      /// for BottomSheetField
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          top: kDefaultValue,
                          right: kDefaultValue,
                          left: kDefaultValue,
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),

                        /// BottomSheet Body
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            /// Calendar Modal Header
                            GetBuilder<CalendarController>(
                              builder: (controller) => Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Register Bottom Modal
                                  IconButton(
                                    onPressed: () => {Navigator.pop(context), controller.resetBottomSheet()},
                                    icon: const Icon(
                                      Icons.close_outlined,
                                      size: kDefaultValue * 1.5,
                                      color: kTextGreyColor,
                                    ),
                                  ),

                                  /// create or update
                                  IconButton(
                                    onPressed: () {
                                      if (!defaultFormValidator(formKey)) return;
                                      formKey.currentState!.save();
                                      controller.createCalendars(title, content);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.check_circle_outline,
                                      size: kDefaultValue * 1.5,
                                      color: kTextGreyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            kHeightSizeBox,

                            /// title Form
                            DefaultBorderInputField(
                              hint: '일정의 제목을 입력해주세요.',
                              maxLine: 2,
                              onSaved: (val) => title = val!.trim(),
                              validator: requiredStringValidator,
                            ),
                            kHeightSizeBox,

                            /// content Form
                            DefaultBorderInputField(
                              hint: '일정에 대한 세부 내용을 입력해주세요.',
                              maxLine: 5,
                              onSaved: (val) => content = val!.trim(),
                              validator: requiredStringValidator,
                            ),
                            kHeightSizeBox,

                            /// isAllDay switch
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text('하루종일'),
                                GetBuilder<CalendarController>(
                                  builder: (controller) => Switch(
                                    value: controller.isAllDay,
                                    onChanged: controller.toggleIsAllDay,
                                    activeColor: kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                            kHeightSizeBox,

                            /// start & end
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// START
                                GetBuilder<CalendarController>(
                                  builder: (controller) => CalendarDateFormField(
                                    context: context,
                                    title: '시작',
                                    isAllDay: controller.isAllDay,
                                    initialValue: controller.start,
                                    onConfirm: controller.updateStart,
                                  ),
                                ),

                                /// Spacer
                                kHeightSizeBox,

                                /// END
                                GetBuilder<CalendarController>(
                                  builder: (controller) => GetBuilder<CalendarController>(
                                    builder: (controller) => CalendarDateFormField(
                                      context: context,
                                      title: '종료',
                                      isAllDay: controller.isAllDay,
                                      initialValue: controller.end,
                                      onConfirm: controller.updateEnd,
                                      minTime: controller.start,
                                      validator: (value) {
                                        return value!.isAfterOrEqualTo(controller.start) ? null : '종료는 시작과 같거나 이 후 시점이여야 합니다.';
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            kHeightSizeBox,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ).whenComplete(() => Get.find<CalendarController>().resetBottomSheet());
            },
            icon: const Icon(
              Icons.add_outlined,
              size: kDefaultValue * 1.5,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultValue,
        ),
        child: GetBuilder<CalendarController>(
          builder: (controller) => LoadingOverlay(
            isLoading: controller.isLoading,
            child: Column(
              children: [
                /// Table Calendar
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
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.select(selectedDay, focusedDay);
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(controller.selectedDay, day);
                  },

                  /// 여기서 상태를 변경하여 Calendar를 Rerendering 하게 되면
                  /// eventLoader에서 현재 달+ 이동되는 달 까지의 loop를 돌게된다.
                  onPageChanged: (DateTime focusTime) {
                    controller.updatePage(focusTime);
                  },

                  eventLoader: controller.getEventsForDay,
                ),
                kDoubleHeightSizeBox,

                // 이벤트 리스트
                LabeldContent(
                  title: '일정',
                  goContent: () {},
                  child: SizedBox(
                    height: 250,
                    child: ListView(
                      children: [
                        ...controller.getEventsForDay(controller.focusDay).map(
                              (e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  // horizontal: kDefaultValue,
                                  vertical: kDefaultValue / 2,
                                ),
                                child: DefaultAvatarContent(
                                  avatarChild: const Icon(Icons.calendar_month_outlined, size: kDefaultValue * 1.5),
                                  title: e.title,
                                  content: e.content,
                                  subContent:
                                      '\n${e.creator.name} / ${DateFormat('yyyy년 MM월 dd일').format(e.createdAt.add(const Duration(hours: 9))).toString()}',
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
                kDoubleHeightSizeBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
