import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/content/default_content_header.dart';
import 'package:pyc/components/loading/loading_overlay.dart';
import 'package:pyc/components/seperator/default_seperator.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kDefaultValue * 2),
            // Notice Header
            GetBuilder<NoticeDetailController>(
              builder: (controller) => LoadingOverlay(
                isLoading: controller.isLoading,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultValue,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultContentHeader(
                        avatarImage: controller.image != null
                            ? NetworkImage(controller.image!)
                            : Image.asset(
                                'assets/icons/person_icon.png',
                                width: kDefaultValue,
                                height: kDefaultValue,
                              ).image,
                        title: controller.title,
                        content: '작성자 | ${controller.name}',
                        subContent: DateFormat('yyyy.MM.dd HH시 mm분').format(
                          controller.createdAt.toLocal(),
                        ),
                      ),
                      const SizedBox(
                        height: kDefaultValue * 1.5,
                      ),
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
            const SizedBox(height: kDefaultValue),
            // spacer
            getDefaultSeperator(),
            kHeightSizeBox,
            // comment Count
            GetBuilder<NoticeCommentController>(
              builder: (controller) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
                child: Text(
                  '댓글 ${controller.noticeComments.count}개',
                  style: const TextStyle(
                    color: kTextGreyColor,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            //     kHeightSizeBox,
            //     Expanded(
            //       child: ListView.builder(
            //         itemCount: 20,
            //         itemBuilder: (context, index) {
            //           return Comment(
            //             index: index,
            //             length: comments.length,
            //           );
            //         },
            //       ),
            //     ),
          ],
        ),
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final int index;
  final int length;

  const Comment({
    Key? key,
    required this.index,
    required this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        kHalfHeightSizeBox,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultValue,
          ),
          child: DefaultContentHeader(
            avatar: Image.asset(
              'assets/images/test_user.png',
            ),
            title: '임은하',
            content:
                '감사합니다! 확인했습니다 :)\n감사합니다! 확인했습니다:)\n감사합니다! 확인했습니다 :)감사합니다! 확인했습니다 :)감사합니다! 확인했습니다 :)\n감사합니다! 확인했습니다 :)\n',
            width: size.width * 0.7,
          ),
        ),
        kHalfHeightSizeBox,
        if (index != length - 1)
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xffF2F2F2), width: 1.0),
              ),
            ),
          ),
      ],
    );
  }
}
