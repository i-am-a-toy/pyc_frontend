import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/date/date.dart';
import 'package:pyc/components/loading/loading_overlay.dart';
import 'package:pyc/controllers/notice/index_notice_controller.dart';
import 'package:pyc/controllers/user/fetch_me_controller.dart';
import 'package:pyc/data/model/notice/response/notice_response.dart';
import 'package:pyc/screens/index/components/appbar/index_appbar.dart';
import 'package:pyc/screens/index/components/card/index_content_icon.dart';
import 'package:pyc/screens/index/components/drawer/index_drawer.dart';
import 'package:pyc/screens/index/components/index_attendance.dart';
import 'package:pyc/screens/index/components/index_content_card.dart';
import 'package:pyc/screens/index/components/index_new_face_card.dart';
import 'package:pyc/screens/index/components/index_user_profile.dart';
import 'package:pyc/screens/index/components/index_user_search.dart';
import 'package:pyc/screens/index/components/layout/index_layout.dart';
import 'package:pyc/screens/notice/notice_detail_screen.dart';
import 'package:pyc/screens/notice/notice_screen.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getIndexAppbar(),
      drawer: GetBuilder<FetchMeController>(
        builder: (controller) => LoadingOverlay(
            isLoading: controller.isLoading,
            child: IndexDrawer(size: size, name: controller.name)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
        child: Column(
          children: [
            // 유저 프로필
            GetBuilder<FetchMeController>(
              builder: (controller) => LoadingOverlay(
                isLoading: controller.isLoading,
                child: IndexUserProfile(
                  userRole: controller.role,
                  name: controller.name,
                  userProfile: controller.image,
                ),
              ),
            ),
            kHeightSizeBox,
            //검색
            const IndexUserSearch(leadingIcon: Icons.search_outlined),
            kHeightSizeBox,
            //출석
            IndexLayout(
              title: '출석현황',
              goContent: () {},
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    IndexAttendance(
                      date: '2022년 12월 25일',
                      content: '예배 참석 인원',
                      attendance: 50,
                      total: 100,
                    ),
                    kWidthSizeBox,
                    IndexAttendance(
                      date: '2022년 12월 25일',
                      content: '셀모임 참석 인원',
                      attendance: 90,
                      total: 100,
                    ),
                  ],
                ),
              ),
            ),
            kHeightSizeBox,
            //공자시항
            IndexLayout(
              title: '공지사항',
              goContent: () => Get.toNamed(NoticeScreen.routeName),
              child: GetBuilder<IndexNoticeController>(
                builder: (controller) => LoadingOverlay(
                  isLoading: controller.isLoading,
                  child: Column(
                    children: [
                      for (NoticeResponse resp in controller.notices.rows)
                        IndexContentCard(
                          // avatarChild: const Icon(
                          avatarChild: getIndexContentCardIcon(
                            Icons.campaign_outlined,
                          ),
                          content: resp.title,
                          subContent: '작성자 | ${resp.name}',
                          thirdContent: getDifferceTime(resp.createdAt),
                          goTo: () {
                            Get.toNamed(
                              NoticeDetailScreen.routeName,
                              arguments: resp.id,
                            );
                          },
                        ),
                      if (controller.notices.count == 0)
                        IndexContentCard(
                          avatarChild: getIndexContentCardIcon(
                            Icons.campaign_outlined,
                          ),
                          content: '등록 된 공지사항이 없습니다.',
                        ),
                    ],
                  ),
                ),
              ),
            ),
            kHalfHeightSizeBox,
            //일정안내
            IndexLayout(
              title: '일정 안내',
              goContent: () {},
              child: Column(
                children: [
                  IndexContentCard(
                    avatarChild: const Icon(
                      Icons.edit_calendar_outlined,
                      size: kDefaultValue * 1.75,
                      color: kTextWhiteColor,
                    ),
                    content: '2022년 12월 연말 전도축제',
                    subContent: '시작일 | 22.12.25',
                    goTo: () {},
                  ),
                  kHalfHeightSizeBox,
                  IndexContentCard(
                    avatarChild: const Icon(
                      Icons.edit_calendar_outlined,
                      size: kDefaultValue * 1.75,
                      color: kTextWhiteColor,
                    ),
                    content: '2022년 12월 연말 전도축제',
                    subContent: '시작일 | 22.12.25',
                    goTo: () {},
                  ),
                ],
              ),
            ),
            kHeightSizeBox,
            //새친구 소개
            IndexLayout(
              title: '열방 New Face',
              goContent: () {},
              child: CarouselSlider.builder(
                itemCount: 2,
                itemBuilder: (context, index, realIndex) {
                  return IndexNewFaceCard(
                    avatarChild: Image.asset('assets/images/test_user.png'),
                    comeDate: DateFormat('yyyy.MM.dd').format(
                      DateTime.now(),
                    ),
                    name: '이우길',
                    weekly: 2,
                  );
                },
                options: CarouselOptions(
                  height: 190.0,
                  padEnds: false,
                  autoPlay: true,
                ),
              ),
            ),
            kHeightSizeBox,
          ],
        ),
      ),
    );
  }
}
