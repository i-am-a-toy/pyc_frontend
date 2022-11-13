import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/screens/index/components/index_appbar.dart';
import 'package:pyc/screens/index/components/index_attendance.dart';
import 'package:pyc/screens/index/components/index_content_card.dart';
import 'package:pyc/screens/index/components/index_content_layout.dart';
import 'package:pyc/screens/index/components/index_drawer.dart';
import 'package:pyc/screens/index/components/index_new_face_card.dart';
import 'package:pyc/screens/index/components/index_user_profile.dart';
import 'package:pyc/screens/index/components/index_user_search.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getIndexAppbar(),
      drawer: IndexDrawer(
        size: size,
        name: '우길',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultValue,
        ),
        child: Column(
          children: [
            // 유저 프로필
            const IndexUserProfile(
              userRole: '관리자',
              name: '이우길',
              //// example Data : https://s.gravatar.com/avatar/da0e4dd62f6939f9800cfce180b02bf4?d=robohash
              userProfile:
                  'https://s.gravatar.com/avatar/da0e4dd62f6939f9800cfce180b02bf4?d=robohash',
            ),
            kHeightSizeBox,
            //검색
            const IndexUserSearch(leadingIcon: Icons.search_outlined),
            kHeightSizeBox,
            //출석
            IndexContentLayout(
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
            IndexContentLayout(
              title: '공지사항',
              goContent: () {},
              child: Column(
                children: [
                  IndexContentCard(
                    avatarChild: Image.asset('assets/images/test_user.png'),
                    content: '12월 리더모임 일정안내',
                    subContent: '작성자 | 김은률',
                    thirdContent: '2일전',
                    goTo: () {},
                  ),
                  kHalfHeightSizeBox,
                  IndexContentCard(
                    avatarChild: Image.asset('assets/images/test_user.png'),
                    content: '12월 리더모임 일정안내',
                    subContent: '작성자 | 김은률',
                    thirdContent: '2일전',
                    goTo: () {},
                  ),
                ],
              ),
            ),
            kHeightSizeBox,
            //일정안내
            IndexContentLayout(
              title: '일정 안내',
              goContent: () {},
              child: Column(
                children: [
                  IndexContentCard(
                    avatarChild: const Icon(Icons.edit_calendar_outlined),
                    content: '2022년 12월 연말 전도축제',
                    subContent: '시작일 | 22.12.25',
                    goTo: () {},
                  ),
                  kHalfHeightSizeBox,
                  IndexContentCard(
                    avatarChild: const Icon(Icons.edit_calendar_outlined),
                    content: '2022년 12월 연말 전도축제',
                    subContent: '시작일 | 22.12.25',
                    goTo: () {},
                  ),
                ],
              ),
            ),
            kHeightSizeBox,
            //새친구 소개
            IndexContentLayout(
              title: '열방 New Face',
              goContent: () {},
              child: CarouselSlider(
                items: [
                  IndexNewFaceCard(
                    avatarChild: Image.asset('assets/images/test_user.png'),
                    comeDate: DateFormat('yyyy.MM.dd').format(
                      DateTime.now(),
                    ),
                    name: '이우길',
                    weekly: 2,
                  ),
                  IndexNewFaceCard(
                    avatarChild: Image.asset('assets/images/test_user.png'),
                    comeDate: DateFormat('yyyy.MM.dd').format(
                      DateTime.now(),
                    ),
                    name: '임은하',
                    weekly: 3,
                  ),
                ],
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
