import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/controllers/home/home_controller.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => BottomNavigationBar(
        currentIndex: controller.index,
        onTap: (index) => controller.changeIndex(index),
        iconSize: kDefaultValue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/home.png')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/manage.png')),
            label: 'Manager',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/schedule.png')),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/mypage.png')),
            label: 'MyPage',
          ),
        ],
      ),
    );
  }
}
