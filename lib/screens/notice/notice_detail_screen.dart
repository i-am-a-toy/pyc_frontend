import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/components/appbar/default_appbar.dart';
import 'package:pyc/components/content/default_avatar_content.dart';
import 'package:pyc/components/loading/loading_overlay.dart';
import 'package:pyc/components/seperator/default_divider.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/controllers/notice/notice_detail_controller.dart';
import 'package:pyc/controllers/notice_comment/notice_comment_controller.dart';
import 'package:pyc/controllers/user/fetch_me_controller.dart';
import 'package:pyc/screens/notice/notice_update_comment_screen.dart';
import 'package:pyc/screens/notice/notice_upsert_screen.dart';

//https://blog.naver.com/PostView.nhn?blogId=getinthere&logNo=221845651741
class NoticeDetailScreen extends StatelessWidget {
  static const routeName = '/notice-detail';
  const NoticeDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final NoticeController noticeController = Get.find<NoticeController>();
    final NoticeDetailController noticeDetailController = Get.find<NoticeDetailController>();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    const int goList = 2; // close dialog -> go list screen

    String comment = '';

    return Scaffold(
      backgroundColor: Colors.white,
      // appbar
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
      ),
      bottomSheet: Form(
        key: formKey,
        child: Container(
          width: double.infinity,
          height: kDefaultValue * 4,
          padding: const EdgeInsets.only(
            top: kDefaultValue / 2,
            left: kDefaultValue,
            right: kDefaultValue,
          ),
          child: TextFormField(
            autofocus: Get.arguments['autoFocus'] as bool,
            validator: (val) {
              return val == '' ? '' : null;
            },
            onSaved: (val) {
              comment = val!.trim();
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: kDefaultValue / 2),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultValue / 2),
                child: CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  backgroundImage: NetworkImage(Get.find<FetchMeController>().image),
                ),
              ),
              suffixIcon: InkWell(
                onTap: () async {
                  if (!formKey.currentState!.validate()) return;
                  formKey.currentState!.save();
                  await Get.find<NoticeCommentController>().save(noticeDetailController.id, comment);
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(microseconds: 10000),
                    curve: Curves.fastOutSlowIn,
                  );
                  FocusManager.instance.primaryFocus?.unfocus();
                  formKey.currentState!.reset();
                },
                child: SvgPicture.asset(
                  'assets/icons/send_icon.svg',
                  color: kPrimaryColor,
                  fit: BoxFit.scaleDown,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(40),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(40),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(40),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        ),
      ),

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
              // notice content
              GetBuilder<NoticeDetailController>(
                builder: (controller) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultValue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // notice header
                      DefaultAvatarContent(
                        title: controller.title,
                        content: '작성자 | ${controller.name}',
                        subContent: DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(controller.createdAt.toLocal()).toString(),
                        avatarImage: controller.image,
                      ),
                      kHeightSizeBox,
                      //notice body
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
              getDefaultDivider(width: kDefaultValue * 0.4),
              kHeightSizeBox,
              // notice Comment
              GetBuilder<NoticeCommentController>(
                builder: (controller) => LoadingOverlay(
                  isLoading: controller.isLoding,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
                        child: Text(
                          '댓글 ${controller.count}개',
                          style: const TextStyle(
                            color: kTextGreyColor,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      kHeightSizeBox,
                      SlidableAutoCloseBehavior(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // has more button
                            if (controller.hasMore)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
                                child: InkWell(
                                  onTap: () async {
                                    controller.getMore();
                                  },
                                  child: const Text(
                                    '댓글 더보기',
                                    style: TextStyle(
                                      color: kTextBlackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            for (int i = 0; i < controller.comments.length; i++)
                              Slidable(
                                enabled: Get.find<FetchMeController>().id == controller.comments[i].createdBy,
                                key: UniqueKey(),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    // A SlidableAction can have an icon and/or a label.
                                    SlidableAction(
                                      onPressed: (ctx) {
                                        Get.toNamed(
                                          NoticeUpdateCommentScreen.routeName,
                                          arguments: {
                                            'id': controller.comments[i].id,
                                            'comment': controller.comments[i].comment,
                                          },
                                        );
                                      },
                                      backgroundColor: kPrimaryColor,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit_note_outlined,
                                      label: 'Modifiy',
                                    ),
                                    SlidableAction(
                                      autoClose: false,
                                      onPressed: (ctx) {
                                        Slidable.of(ctx)?.dismiss(
                                          curve: Curves.fastOutSlowIn,
                                          ResizeRequest(const Duration(milliseconds: 300), () async {
                                            await controller.delete(controller.comments[i].id, i);
                                          }),
                                        );
                                      },
                                      backgroundColor: Colors.red.shade600,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: kDefaultValue / 2,
                                        horizontal: kDefaultValue,
                                      ),
                                      child: DefaultAvatarContent(
                                        title: controller.comments[i].creator.name,
                                        content: controller.comments[i].comment,
                                        subContent: '\n\n${DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(controller.comments[i].createdAt).toString()}',
                                        avatarImage: controller.comments[i].creator.image,
                                      ),
                                    ),
                                    if (i < controller.comments.length - 1) getDefaultDivider(width: kDefaultValue * 0.1),
                                  ],
                                ),
                              ),
                            const SizedBox(height: kDefaultValue * 2),
                          ],
                        ),
                      ),
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

  VoidCallback _onClickEditButton(NoticeDetailController controller) {
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

  VoidCallback _onClickDeleteButton(NoticeDetailController detailController, NoticeController noticeController, int closeTimes) {
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
