import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/appbar/default_appbar.dart';
import 'package:pyc/components/loading/loading_overlay.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/screens/notice/components/list/notice_list.dart';
import 'package:pyc/screens/notice/components/list/notice_no_content.dart';
import 'package:pyc/screens/notice/components/list/notice_drop_down.dart';
import 'package:pyc/screens/notice/notice_upsert_screen.dart';

class NoticeScreen extends StatelessWidget {
  static const String routeName = '/notice';
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,

      /// Appbar
      appBar: getDefaultAppBar(
        title: '공지사항',
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(NoticeUpsertScreen.createRoute),
            icon: SvgPicture.asset('assets/icons/pencil_icon.svg'),
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

      /// Body
      body: RefreshIndicator(
        color: kPrimaryColor,
        onRefresh: () => Get.find<NoticeController>().refetch(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHalfHeightSizeBox,
              const NoticeSortDropDown(),
              kHalfHeightSizeBox,
              GetBuilder<NoticeController>(
                builder: (controller) => LoadingOverlay(
                  isLoading: controller.isLoading,
                  child: controller.count != 0
                      ? NoticeList(controller: controller)
                      : const NoticeNoContent(
                          content: '등록된 공지사항이 없습니다.',
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
