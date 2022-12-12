import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/components/appbar/default_appbar.dart';
import 'package:pyc/components/button/default_text_button.dart';
import 'package:pyc/components/content/default_avatar_content.dart';
import 'package:pyc/components/loading/loading_overlay.dart';
import 'package:pyc/components/seperator/default_divider.dart';
import 'package:pyc/components/slidable/default_slidable_action.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/controllers/notice/notice_detail_controller.dart';
import 'package:pyc/controllers/notice_comment/notice_comment_controller.dart';
import 'package:pyc/controllers/user/fetch_me_controller.dart';
import 'package:pyc/screens/notice/components/detail/notice_comment_count.dart';
import 'package:pyc/screens/notice/components/detail/notice_comment_list.dart';
import 'package:pyc/screens/notice/components/detail/notice_content.dart';
import 'package:pyc/screens/notice/components/detail/notice_detail_bottom_sheet.dart';
import 'package:pyc/screens/notice/notice_update_comment_screen.dart';
import 'package:pyc/screens/notice/notice_upsert_screen.dart';

class NoticeDetailScreen extends StatelessWidget {
  static const routeName = '/notice-detail';
  const NoticeDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final NoticeController noticeController = Get.find<NoticeController>();
    final NoticeDetailController noticeDetailController = Get.find<NoticeDetailController>();
    final NoticeCommentController noticeCommentController = Get.find<NoticeCommentController>();
    const int goList = 2; // close dialog -> go list screen

    return Scaffold(
      backgroundColor: Colors.white,

      /// Appbar
      appBar: getDefaultAppBar(
        title: '공지사항',
        actions: [
          IconButton(
            onPressed: _onClickEditButton(noticeDetailController),
            icon: SvgPicture.asset('assets/icons/pencil_icon.svg'),
          ),
          IconButton(
            onPressed: _onClickDeleteButton(noticeDetailController, noticeController, goList),
            icon: const Icon(Icons.close_outlined),
          ),
        ],
        leading: IconButton(
          onPressed: () => Get.find<NoticeController>().getBack(),
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            size: kDefaultValue * 1.2,
          ),
        ),
      ),

      /// Bottom Sheet
      bottomSheet: NoticeDetailBottomSheet(
        autoFocus: Get.arguments['autoFocus'],
        image: Get.find<FetchMeController>().image,
        saveComment: (comment) => noticeCommentController.save(
          noticeDetailController.id,
          comment,
        ),
      ),

      /// Body
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          Slidable.of(context)?.close();
        },
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: <Widget>[
              kHeightSizeBox,

              /// Notice
              GetBuilder<NoticeDetailController>(
                builder: (controller) => NoticeContent(
                  title: controller.title,
                  name: controller.name,
                  createdAt: controller.createdAt,
                  image: controller.image,
                  content: controller.content,
                ),
              ),
              kHeightSizeBox,

              /// Devider
              getDefaultDivider(width: kDefaultValue * 0.4),
              kHeightSizeBox,

              /// Notice Comment
              GetBuilder<NoticeCommentController>(
                builder: (controller) => LoadingOverlay(
                  isLoading: controller.isLoding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Comment Count
                      NoticeCommentCount(count: controller.count),
                      kHeightSizeBox,

                      /// Get More Button
                      if (controller.hasMore && !controller.isCommentLoading)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
                          child: DefaultTextButton(
                            onTap: () => controller.getMore(),
                            title: '댓글 더보기',
                            textColor: Colors.black,
                          ),
                        ),

                      /// Comment Get More Progress Indicator
                      if (controller.isCommentLoading)
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: kDefaultValue,
                            vertical: kDefaultValue,
                          ),
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        ),

                      /// Comment List
                      Builder(
                        builder: (context) => NoticeCommentList(
                          userId: Get.find<FetchMeController>().id,
                          comments: controller.comments,
                          count: controller.count,
                          modifiy: controller.goUpdateScreen2,
                          delete: controller.delete,
                        ),
                      )
                      // SlidableAutoCloseBehavior(
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       /// Commnet List
                      //       for (int i = 0; i < controller.comments.length; i++)
                      //         Slidable(
                      //           enabled: Get.find<FetchMeController>().id == controller.comments[i].createdBy,
                      //           key: UniqueKey(),
                      //           endActionPane: ActionPane(
                      //             motion: const ScrollMotion(),
                      //             children: [
                      //               DefaultSlidableAction(
                      //                 onPressed: (ctx) {
                      //                   Get.toNamed(
                      //                     NoticeUpdateCommentScreen.routeName,
                      //                     arguments: {
                      //                       'id': controller.comments[i].id,
                      //                       'comment': controller.comments[i].comment,
                      //                     },
                      //                   );
                      //                 },
                      //                 label: 'Modifiy',
                      //                 icon: Icons.edit_note_outlined,
                      //                 color: kPrimaryColor,
                      //               ),
                      //               DefaultSlidableAction(
                      //                 onPressed: (ctx) {
                      //                   Slidable.of(ctx)?.dismiss(
                      //                     curve: Curves.fastOutSlowIn,
                      //                     ResizeRequest(const Duration(milliseconds: 300), () async {
                      //                       await controller.delete(controller.comments[i].id, i);
                      //                     }),
                      //                   );
                      //                 },
                      //                 label: 'Delete',
                      //                 icon: Icons.delete,
                      //                 color: Colors.red.shade600,
                      //               ),
                      //             ],
                      //           ),
                      //           child: Column(
                      //             children: [
                      //               Padding(
                      //                 padding: const EdgeInsets.symmetric(
                      //                   vertical: kDefaultValue / 2,
                      //                   horizontal: kDefaultValue,
                      //                 ),
                      //                 child: DefaultAvatarContent(
                      //                   title: controller.comments[i].creator.name,
                      //                   content: controller.comments[i].comment,
                      //                   subContent: '\n\n${DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(controller.comments[i].createdAt).toString()}',
                      //                   avatarImage: controller.comments[i].creator.image,
                      //                 ),
                      //               ),
                      //               if (i < controller.comments.length - 1) getDefaultDivider(width: kDefaultValue * 0.1),
                      //             ],
                      //           ),
                      //         ),
                      //       const SizedBox(height: kDefaultValue * 2),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: kDefaultValue * 2),
            ],
          ),
        ),
      ),
    );
  }

  VoidCallback _onClickEditButton(
    NoticeDetailController controller,
  ) {
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

  VoidCallback _onClickDeleteButton(
    NoticeDetailController detailController,
    NoticeController noticeController,
    int closeTimes,
  ) {
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
