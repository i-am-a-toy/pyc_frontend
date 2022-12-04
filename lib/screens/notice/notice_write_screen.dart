import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/validator/validator.dart';
import 'package:pyc/components/appbar/default_appbar.dart';
import 'package:pyc/components/button/default_buttons.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/controllers/notice/notice_upsert.controller.dart';

class NoticeWriteScreen extends StatelessWidget {
  static const String routeName = '/notice_write';

  const NoticeWriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final NoticeController noticeController = Get.find<NoticeController>();
    return GetBuilder<NoticeUpserController>(
      builder: (controller) => Scaffold(
        appBar: getDefaultAppBar(title: '등록하기'),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultValue,
            vertical: kDefaultValue * 2,
          ),
          width: double.infinity,
          child: SingleChildScrollView(
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
                    onSaved: (val) => {controller.updateTitle(val!)},
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
                    onSaved: (val) => {controller.updateContent(val!)},
                    validator: requiredStringValidator,
                  ),
                  kHeightSizeBox,
                  DefaultButton(
                    onPress: () async {
                      if (!defaultFormValidator(formKey)) return;
                      formKey.currentState!.save();
                      await controller.write();
                      await noticeController.refetch();
                      Get.back();
                    },
                    title: '등록',
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
