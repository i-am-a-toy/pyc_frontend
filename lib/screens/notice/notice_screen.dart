import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/appbar/default_appbar.dart';
import 'package:pyc/components/loading/loading_overlay.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';
import 'package:pyc/screens/notice/components/list/notice_content.dart';
import 'package:pyc/screens/notice/components/list/notice_no_content.dart';
import 'package:pyc/screens/notice/components/notice_appbar.dart';
import 'package:pyc/screens/notice/components/notice_drop_down.dart';
import 'package:pyc/screens/notice/notice_write_screen.dart';

class NoticeScreen extends StatelessWidget {
  static const String routeName = '/notice';
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: getDefaultAppBar(title: '공지사항', actions: [
        IconButton(
          onPressed: () => Get.toNamed(NoticeWriteScreen.routeName),
          icon: SvgPicture.asset('assets/icons/pencil_icon.svg'),
        ),
      ]),
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
                  child: controller.notices.count != 0 ? NoticeContent(controller: controller) : const NoticeNoContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
