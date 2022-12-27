import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/controllers/home/home_controller.dart';
import 'package:pyc/screens/calendar/calendar_screen.dart';
import 'package:pyc/screens/calendar/calendar_scrren2.dart';
import 'package:pyc/screens/home/components/home_bottom_navigation_bar.dart';
import 'package:pyc/screens/index/index_screen.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bodies = [
      IndexScreen(),
      Text('Manager'),
      CalendarScreen2(),
      Text('MyPage'),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<HomeController>(
        builder: (controller) => bodies[controller.index],
      ),
      bottomNavigationBar: const HomeBottomNavigationBar(),
    );
  }
}
