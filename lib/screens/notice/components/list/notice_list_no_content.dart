import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';

/// NoticeListNoContent
///
/// 공지사항의 스크롤 이벤트로 서버에서 새로운 List를 요청하였을 때 더이상 서버에 데이터가 없을 경우
/// 공지사항 List에 보여 질 Widget 추 후 공통 Component로 빠질 수 있음
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
