import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/controllers/home/home_controller.dart';
import 'package:pyc/screens/home/components/home_bottom_navigation_bar.dart';
import 'package:pyc/screens/index/index_screen.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const bodies = [
      IndexScreen(),
      Text('Manager'),
      Text('Schedule'),
      Text('MyPage'),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color(0xff606060),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      drawer: SizedBox(
        width: size.width * 0.65,
        child: Drawer(
          child: Container(
            color: kPrimaryColor,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '반가워요 우길님!',
                            style: TextStyle(
                              color: kTextWhiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          kQuarterHeightSizedBox,
                          Text(
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
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                  ),
                ),
                kHeightSizeBox,
                ListTile(
                  leading: Icon(
                    Icons.task_outlined,
                    color: Colors.white,
                    size: 32.0,
                  ),
                  title: Text(
                    '내 셀 관리',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: kTextWhiteColor,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 32.0,
                  ),
                  title: Text(
                    '공지사항',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: kTextWhiteColor,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.task_outlined,
                    color: Colors.white,
                    size: 32.0,
                  ),
                  title: Text(
                    '로그아웃',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: kTextWhiteColor,
                    ),
                  ),
                  // minLeadingWidth: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => bodies[controller.index],
      ),
      bottomNavigationBar: const HomeBottomNavigationBar(),
    );
  }
}
