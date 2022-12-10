import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';

class NoticeListNoContent extends StatelessWidget {
  final String content = '공지사항이 없습니다.';
  const NoticeListNoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeController>(
      builder: (controller) => Center(
        child: Get.find<NoticeController>().hasMore
            ? const CircularProgressIndicator(
                color: kPrimaryColor,
              )
            : Text(
                content,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 14.0,
                ),
              ),
      ),
    );
  }
}
