import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/validator/validator.dart';
import 'package:pyc/components/appbar/default_appbar.dart';
import 'package:pyc/components/button/default_buttons.dart';
import 'package:pyc/controllers/notice_comment/notice_comment_controller.dart';

class NoticeUpdateCommentScreen extends StatelessWidget {
  static const String routeName = '/comment_update';
  final String appBarTitle;
  final String buttonTitle;
  const NoticeUpdateCommentScreen({
    super.key,
    required this.appBarTitle,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    final NoticeCommentController controller = Get.find<NoticeCommentController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final Map<String, dynamic> argument = Get.arguments;
    String changed = '';

    return Scaffold(
      appBar: getDefaultAppBar(title: appBarTitle),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultValue,
          vertical: kDefaultValue * 2,
        ),
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '댓글',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              kHalfHeightSizeBox,
              TextFormField(
                initialValue: argument['comment'],
                maxLines: 5,
                decoration: const InputDecoration(
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
                onSaved: (val) => {changed = val!},
                validator: requiredStringValidator,
              ),
              kHeightSizeBox,
              DefaultButton(
                onPress: () async {
                  if (!defaultFormValidator(formKey)) return;
                  formKey.currentState!.save();
                  await controller.updateComment(argument['id'], changed);
                  Get.back();
                },
                title: buttonTitle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
