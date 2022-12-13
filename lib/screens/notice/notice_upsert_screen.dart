import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/validator/validator.dart';
import 'package:pyc/components/appbar/default_appbar.dart';
import 'package:pyc/components/button/default_buttons.dart';
import 'package:pyc/components/form/default_border_input_field.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/controllers/notice/notice_detail_controller.dart';
import 'package:pyc/controllers/notice/notice_upsert.controller.dart';

class NoticeUpsertScreen extends StatelessWidget {
  static const String updateRoute = '/notice_update';
  static const String createRoute = '/notice_create';
  final String appBarTitle;
  final String buttonTitle;
  const NoticeUpsertScreen({
    super.key,
    required this.appBarTitle,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final NoticeController noticeController = Get.find<NoticeController>();
    final Map<String, dynamic>? argument = Get.arguments;
    return Scaffold(
      appBar: getDefaultAppBar(title: appBarTitle),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultValue,
          vertical: kDefaultValue * 2,
        ),
        width: double.infinity,
        child: GetBuilder<NoticeUpserController>(
          builder: (controller) => SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '제목',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  kHalfHeightSizeBox,
                  DefaultBorderInputField(
                    init: argument?['title'],
                    hint: '공지사항의 제목을 입력해주세요.',
                    onSaved: (val) => controller.updateTitle(val!),
                    validator: requiredStringValidator,
                    maxLine: 2,
                  ),
                  kHeightSizeBox,
                  const Text(
                    '내용',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  kHalfHeightSizeBox,
                  DefaultBorderInputField(
                    init: argument?['content'],
                    hint: '새로운 소식을 입력해주세요.',
                    onSaved: (val) => controller.updateContent(val!),
                    validator: requiredStringValidator,
                    maxLine: 10,
                  ),
                  kHeightSizeBox,
                  DefaultButton(
                    onPress: () async {
                      if (!defaultFormValidator(formKey)) return;
                      formKey.currentState!.save();
                      argument != null
                          ? {
                              await controller.modifiy(argument['id'] as int),
                              await Get.find<NoticeDetailController>().refetch(),
                            }
                          : await controller.write();
                      await noticeController.refetch();
                      Get.back();
                    },
                    title: buttonTitle,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
