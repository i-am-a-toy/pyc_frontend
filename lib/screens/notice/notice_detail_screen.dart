import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/components/seperator/default_divider.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/controllers/notice/notice_detail_controller.dart';
import 'package:pyc/controllers/notice_comment/notice_comment_controller.dart';
import 'package:pyc/screens/notice/components/notice_appbar.dart';
import 'package:pyc/screens/notice/notice_update_screen.dart';

//https://blog.naver.com/PostView.nhn?blogId=getinthere&logNo=221845651741
class NoticeDetailScreen extends StatelessWidget {
  static const routeName = '/notice-detail';
  const NoticeDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoticeController noticeController = Get.find<NoticeController>();
    final NoticeDetailController detailController = Get.find<NoticeDetailController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getNoticeAppBar(
        actions: [
          IconButton(
            onPressed: () {
              final controller = Get.find<NoticeDetailController>();
              if (controller.isLoading) {
                showSnackbar('요청 실패', '공지사항이 로딩 된 후 시도해주세요.');
                return;
              }
              Get.toNamed(NoticeUpdateScreen.routeName, arguments: {
                'id': controller.id,
                'title': controller.title,
                'content': controller.content,
              });
            },
            icon: SvgPicture.asset(
              'assets/icons/pencil_icon.svg',
              width: kDefaultValue * 2,
              color: kTextWhiteColor,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Text('정말로 삭제하시겠습니까?'),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        await noticeController.delete(detailController.targetId);
                        await noticeController.refetch();
                        Get.close(2); // close dialog -> go list
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                      ),
                      child: Text('삭제'),
                    ),
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kTextGreyColor,
                      ),
                      child: Text('취소'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.close_outlined,
              size: kDefaultValue * 2,
              color: kTextWhiteColor,
            ),
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
                        Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 24.0,
                              backgroundColor: kPrimaryColor,
                              backgroundImage: controller.image != null ? NetworkImage(controller.image!) : kDefaultUserImage,
                            ),
                            kHalfWidthSizedBox,
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.title,
                                    style: const TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  kQuarterHeightSizedBox,
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '작성자 | ${controller.name}',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      kQuarterWidthSizedBox,
                                      Text(
                                        DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(controller.createdAt.toLocal()).toString(),
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    maxRadius: 24.0,
                                    backgroundColor: kPrimaryColor,
                                    backgroundImage: controller.noticeComments.rows[i].creator.image != null
                                        ? NetworkImage(controller.noticeComments.rows[i].creator.image!)
                                        : kDefaultUserImage,
                                  ),
                                  kHalfWidthSizedBox,
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(controller.noticeComments.rows[i].comment),
                                        kQuarterHeightSizedBox,
                                        Row(
                                          children: [
                                            Text(
                                              '작성자 | ${controller.noticeComments.rows[i].creator.name}',
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            kQuarterWidthSizedBox,
                                            Text(
                                              DateFormat('yyyy년 MM월 dd일 HH시 mm분')
                                                  .format(
                                                    controller.noticeComments.rows[i].createdAt,
                                                  )
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
