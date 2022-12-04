import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/components/appbar/default_appbar.dart';
import 'package:pyc/components/content/default_avatar_content.dart';
import 'package:pyc/components/seperator/default_divider.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/controllers/notice/notice_detail_controller.dart';
import 'package:pyc/controllers/notice_comment/notice_comment_controller.dart';
import 'package:pyc/screens/notice/notice_upsert_screen.dart';

//https://blog.naver.com/PostView.nhn?blogId=getinthere&logNo=221845651741
class NoticeDetailScreen extends StatelessWidget {
  static const routeName = '/notice-detail';
  const NoticeDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoticeController noticeController = Get.find<NoticeController>();
    final NoticeDetailController noticeDetailController = Get.find<NoticeDetailController>();
    const int goList = 2; // close dialog -> go list screen

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getDefaultAppBar(
        title: '공지사항',
        actions: [
          IconButton(
            onPressed: onClickEditButton(noticeDetailController),
            icon: SvgPicture.asset('assets/icons/pencil_icon.svg'),
          ),
          IconButton(
            onPressed: onClickDeleteButton(noticeDetailController, noticeController, goList),
            icon: const Icon(Icons.close_outlined),
          ),
        ],
      ),
      // bottomSheet:
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                kHeightSizeBox,
                GetBuilder<NoticeDetailController>(
                  builder: (controller) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultValue,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultAvatarContent(
                          title: controller.title,
                          content: '작성자 | ${controller.name}',
                          subContent: DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(controller.createdAt.toLocal()).toString(),
                          avatarImage: controller.image,
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
                kHalfHeightSizeBox,
                getDefaultDivider(
                  width: 8.0,
                ),
                kHeightSizeBox,
                // notice Comment count
                GetBuilder<NoticeCommentController>(
                  builder: (controller) => Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultValue,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '댓글 ${controller.noticeComments.count}개',
                          style: const TextStyle(
                            color: kTextGreyColor,
                            fontSize: 12.0,
                          ),
                        ),
                        kHalfHeightSizeBox,
                        if (controller.hasMore)
                          const SizedBox(
                            width: double.infinity,
                            child: Text(
                              '댓글 더보기',
                            ),
                          ),
                        for (int i = 0; i < controller.noticeComments.rows.length; i++)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              kHalfHeightSizeBox,
                              DefaultAvatarContent(
                                title: controller.noticeComments.rows[i].comment,
                                content: '작성자 | ${controller.noticeComments.rows[i].creator.name}',
                                subContent: DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(controller.noticeComments.rows[i].createdAt).toString(),
                                avatarImage: controller.noticeComments.rows[i].creator.image,
                              ),
                              kHalfHeightSizeBox,
                              if (i != controller.noticeComments.rows.length - 1)
                                getDefaultDivider(
                                  width: 2.0,
                                ),
                            ],
                          )
                      ],
                    ),
                  ),
                ),
                // notice comment
              ],
            ),
          ),
        ),
      ),
    );
  }

  VoidCallback onClickEditButton(NoticeDetailController controller) {
    return () {
      if (controller.isLoading) {
        showSnackbar('요청 실패', '공지사항이 로딩 된 후 시도해주세요.');
        return;
      }
      Get.toNamed(
        NoticeUpsertScreen.updateRoute,
        arguments: {
          'id': controller.id,
          'title': controller.title,
          'content': controller.content,
        },
      );
    };
  }

  VoidCallback onClickDeleteButton(NoticeDetailController detailController, NoticeController noticeController, int closeTimes) {
    return () {
      Get.dialog(
        AlertDialog(
          title: const Text('정말로 삭제하시겠습니까?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await noticeController.delete(detailController.targetId);
                await noticeController.refetch();
                Get.close(closeTimes); // close dialog -> go list
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
              ),
              child: const Text('삭제'),
            ),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: kTextGreyColor,
              ),
              child: const Text('취소'),
            ),
          ],
        ),
      );
    };
  }
}

// child: Column(
//             children: [
//               const SizedBox(height: kDefaultValue),
//               // notice Content
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
//                 child: GetBuilder<NoticeDetailController>(
//                   builder: (controller) => LoadingOverlay(
//                     isLoading: controller.isLoading,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         DefaultContentHeader(
//                           avatarImage: controller.image != null ? NetworkImage(controller.image!) : kDefaultUserImage,
//                           title: '작성자 | ${controller.name}',
//                           content: DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(
//                             controller.createdAt.toLocal(),
//                           ),
//                           width: MediaQuery.of(context).size.width * 0.7,
//                         ),
//                         kHeightSizeBox,
//                         Text(
//                           controller.title,
//                           style: const TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                             color: kPrimaryColor,
//                           ),
//                         ),
//                         kHeightSizeBox,
//                         Text(
//                           controller.content,
//                           style: const TextStyle(
//                             fontSize: 14.0,
//                             fontWeight: FontWeight.w400,
//                             color: kTextBlackColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               kHeightSizeBox,
//               getDefaultDivider(width: 8.0),
//               kHeightSizeBox,
//               // notice Comment count
//               GetBuilder<NoticeCommentController>(
//                 builder: (controller) => Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: kDefaultValue,
//                   ),
//                   child: Text(
//                     '댓글 ${controller.noticeComments.count}개',
//                     style: const TextStyle(
//                       color: kTextGreyColor,
//                       fontSize: 12.0,
//                     ),
//                   ),
//                 ),
//               ),
//               kHeightSizeBox,
//               // notice comment
//               GetBuilder<NoticeCommentController>(
//                 builder: (controller) => Column(
//                   children: [
//                     if (controller.hasMore)
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: kDefaultValue,
//                         ),
//                         width: double.infinity,
//                         child: const Text(
//                           '댓글 더보기',
//                         ),
//                       ),
//                     for (int i = 0; i < controller.noticeComments.rows.length; i++)
//                       Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: kDefaultValue,
//                               vertical: kDefaultValue,
//                             ),
//                             child: DefaultContentHeader(
//                               title: controller.noticeComments.rows[i].creator.name,
//                               content: controller.noticeComments.rows[i].comment,
//                               avatarImage: controller.noticeComments.rows[i].creator.image != null
//                                   ? NetworkImage(controller.noticeComments.rows[i].creator.image!)
//                                   : kDefaultUserImage,
//                               width: MediaQuery.of(context).size.width * 0.7,
//                               subContent: DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(
//                                 controller.noticeComments.rows[i].createdAt.toLocal(),
//                               ),
//                             ),
//                           ),
//                           if (i != controller.noticeComments.rows.length - 1)
//                             getDefaultDivider(
//                               width: 4.0,
//                             ),
//                         ],
//                       )
//                   ],
//                 ),
//               )
//             ],
//           ),
