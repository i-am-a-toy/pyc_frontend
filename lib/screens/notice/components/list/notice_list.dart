import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/screens/notice/components/list/notice_list_no_content.dart';
import 'package:pyc/screens/notice/components/list/notice_list_card.dart';
import 'package:pyc/screens/notice/notice_detail_screen.dart';

class NoticeList extends StatelessWidget {
  final NoticeController controller;
  const NoticeList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        controller: controller.scrollController,
        itemCount: controller.notices.length + 1,
        itemBuilder: (context, index) {
          if (index < controller.notices.length) {
            return NoticeListCard(
              index: index,
              title: controller.notices[index].title,
              content: controller.notices[index].content,
              writer: controller.notices[index].creator.name,
              writerImage: controller.notices[index].creator.image,
              createAt: controller.notices[index].createdAt,
              onTap: () => Get.toNamed(
                NoticeDetailScreen.routeName,
                arguments: {
                  "targetId": controller.notices[index].id,
                  "autoFocus": false,
                },
              ),
              commentTap: () => Get.toNamed(
                NoticeDetailScreen.routeName,
                arguments: {
                  "targetId": controller.notices[index].id,
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
