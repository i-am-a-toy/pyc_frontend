import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/screens/notice/components/list/notice_list_no_content.dart';
import 'package:pyc/screens/notice/components/list/notice_list_card.dart';
import 'package:pyc/screens/notice/notice_detail_screen.dart';

class NoticeContent extends StatelessWidget {
  final NoticeController controller;
  const NoticeContent({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: controller.scrollController,
        itemCount: controller.notices.rows.length + 1,
        itemBuilder: (context, index) {
          if (index < controller.notices.rows.length) {
            return NoticeListCard(
              index: index,
              title: controller.notices.rows[index].title,
              content: controller.notices.rows[index].content,
              writer: controller.notices.rows[index].creator.name,
              writerImage: controller.notices.rows[index].creator.image,
              onTap: () => Get.toNamed(
                NoticeDetailScreen.routeName,
                arguments: {
                  "targetId": controller.notices.rows[index].id,
                  "autoFocus": false,
                },
              ),
              commentTap: () => Get.toNamed(
                NoticeDetailScreen.routeName,
                arguments: {
                  "targetId": controller.notices.rows[index].id,
                  "autoFocus": true,
                },
              ),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultValue,
                vertical: kDefaultValue / 2,
              ),
              child: NoticeListNoContent(),
            );
          }
        },
      ),
    );
  }
}
