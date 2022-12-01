import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/content/default_content_header.dart';
import 'package:pyc/components/loading/loading_overlay.dart';
import 'package:pyc/components/seperator/default_divider.dart';
import 'package:pyc/controllers/notice/notice_detail_controller.dart';
import 'package:pyc/controllers/notice_comment/notice_comment_controller.dart';
import 'package:pyc/screens/notice/components/notice_appbar.dart';

//https://blog.naver.com/PostView.nhn?blogId=getinthere&logNo=221845651741
class NoticeDetailScreen extends StatelessWidget {
  static const routeName = '/notice-detail';
  const NoticeDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getNoticeAppBar(onTap: () {}),
      // bottomSheet:
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: kDefaultValue),
              // notice Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
                child: GetBuilder<NoticeDetailController>(
                  builder: (controller) => LoadingOverlay(
                    isLoading: controller.isLoading,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultContentHeader(
                          avatarImage: controller.image != null ? NetworkImage(controller.image!) : kDefaultUserImage,
                          title: controller.title,
                          content: '작성자 | ${controller.name}',
                          subContent: DateFormat('yyyy.MM.dd HH시 mm분').format(
                            controller.createdAt.toLocal(),
                          ),
                        ),
                        kHeightSizeBox,
                        Text(
                          controller.content,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: kTextBlackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              kHeightSizeBox,
              getDefaultDivider(width: 8.0),
              kHeightSizeBox,
              // notice Comment count
              GetBuilder<NoticeCommentController>(
                builder: (controller) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultValue,
                  ),
                  child: Text(
                    '댓글 ${controller.noticeComments.count}개',
                    style: const TextStyle(
                      color: kTextGreyColor,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
              kHeightSizeBox,
              // notice comment
              GetBuilder<NoticeCommentController>(
                builder: (controller) => Column(
                  children: [
                    if (controller.hasMore)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultValue,
                        ),
                        width: double.infinity,
                        child: const Text(
                          '댓글 더보기',
                        ),
                      ),
                    for (int i = 0; i < controller.noticeComments.rows.length; i++)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultValue,
                              vertical: kDefaultValue,
                            ),
                            child: DefaultContentHeader(
                              title: controller.noticeComments.rows[i].creator.name,
                              content: controller.noticeComments.rows[i].comment,
                              avatarImage: controller.noticeComments.rows[i].creator.image != null
                                  ? NetworkImage(controller.noticeComments.rows[i].creator.image!)
                                  : kDefaultUserImage,
                              width: MediaQuery.of(context).size.width * 0.7,
                            ),
                          ),
                          if (i != controller.noticeComments.rows.length - 1)
                            getDefaultDivider(
                              width: 4.0,
                            ),
                        ],
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
