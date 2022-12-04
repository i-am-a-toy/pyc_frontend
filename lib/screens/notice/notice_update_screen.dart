import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/validator/validator.dart';
import 'package:pyc/components/button/default_buttons.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/controllers/notice/notice_detail_controller.dart';
import 'package:pyc/controllers/notice/notice_upsert.controller.dart';

class NoticeUpdateScreen extends StatelessWidget {
  static const String routeName = '/notice_update';
  const NoticeUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final NoticeController noticeController = Get.find<NoticeController>();
    final NoticeDetailController noticeDetailController = Get.find<NoticeDetailController>();
    final Map<String, dynamic> argument = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          '수정하기',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
                  TextFormField(
                    initialValue: argument['title'],
                    maxLines: 2,
                    decoration: const InputDecoration(
                      hintText: '공지사항의 제목을 입력해주세요.',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      isDense: true,
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    onSaved: (val) => controller.updateTitle(val!),
                    validator: requiredStringValidator,
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
                  TextFormField(
                    initialValue: argument['content'],
                    maxLines: 10,
                    decoration: const InputDecoration(
                      hintText: '새로운 소식을 입력해주세요.',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      isDense: true,
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    onSaved: (val) => controller.updateContent(val!),
                    validator: requiredStringValidator,
                  ),
                  kHeightSizeBox,
                  DefaultButton(
                    onPress: () async {
                      if (!defaultFormValidator(formKey)) return;
                      formKey.currentState!.save();
                      await controller.modifiy(argument['id'] as int);
                      await noticeDetailController.refetch();
                      await noticeController.refetch();
                      Get.back();
                    },
                    title: '수정',
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
