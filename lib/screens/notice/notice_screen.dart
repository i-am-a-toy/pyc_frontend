import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/loading/loading_overlay.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/screens/notice/components/notice_appbar.dart';
import 'package:pyc/screens/notice/components/notice_drop_down.dart';
import 'package:pyc/screens/notice/components/notice_list_card.dart';

class NoticeScreen extends StatelessWidget {
  static const String routeName = '/notice';
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: getNoticeAppBar(onTap: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultValue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHalfHeightSizeBox,
            const NoticeSortDropDown(),
            kHalfHeightSizeBox,
            GetBuilder<NoticeController>(
              builder: (controller) => LoadingOverlay(
                isLoading: controller.isLoading,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: controller.notices.rows.length,
                    itemBuilder: (context, index) => NoticeListCard(
                      index: index,
                      title: controller.notices.rows[index].title,
                      content: controller.notices.rows[index].content,
                      writer: controller.notices.rows[index].name,
                      writerImage: controller.notices.rows[index].image,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
