import 'package:get/get.dart';
import 'package:pyc/binding/home_binding.dart';
import 'package:pyc/binding/notice_binding.dart';
import 'package:pyc/controllers/login/login_controller.dart';
import 'package:pyc/screens/home/home_screen.dart';
import 'package:pyc/screens/login/login_screen.dart';
import 'package:pyc/screens/notice/notice_detail_screen.dart';
import 'package:pyc/screens/notice/notice_screen.dart';
import 'package:pyc/screens/splash/splash_screen.dart';

List<GetPage> routes = [
  GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
  GetPage(
    name: NoticeScreen.routeName,
    page: () => const NoticeScreen(),
    binding: NoticeBinding(),
  ),
  GetPage(
    name: NoticeDetailScreen.routeName,
    page: () => const NoticeDetailScreen(),
  ),
  GetPage(
    name: LoginScreen.routeName,
    page: () => const LoginScreen(),
    binding: BindingsBuilder(
      () {
        Get.put(LoginController());
      },
    ),
  ),
  GetPage(
    name: HomeScreen.routeName,
    page: () => const HomeScreen(),
    binding: HomeBinding(),
  ),
];
