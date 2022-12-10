import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/screens/index/components/drawer/index_drawer_list_title.dart';
import 'package:pyc/screens/notice/notice_screen.dart';

class IndexDrawer extends StatelessWidget {
  final Size size;
  final String name;

  const IndexDrawer({
    Key? key,
    required this.size,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.65,
      child: Drawer(
        child: Container(
          color: kPrimaryColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '반가워요 $name님!',
                          style: const TextStyle(
                            color: kTextWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        kQuarterHeightSizedBox,
                        const Text(
                          '무엇을 도와드릴까요?',
                          style: TextStyle(
                            color: kTextWhiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ),
                        ),
                        kHalfHeightSizeBox,
                      ],
                    ),
                  ],
                ),
              ),
              kHeightSizeBox,
              IndexDrawerListTitle(
                icon: Icons.task_outlined,
                title: '내 셀 관리',
                onTap: () {},
              ),
              IndexDrawerListTitle(
                icon: Icons.notifications,
                title: '공지사항',
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(NoticeScreen.routeName);
                },
              ),
              IndexDrawerListTitle(
                icon: Icons.logout,
                title: '로그아웃',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
