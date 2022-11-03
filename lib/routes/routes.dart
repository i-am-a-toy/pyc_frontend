import 'package:get/get.dart';
import 'package:pyc/controllers/login/login_controller.dart';
import 'package:pyc/screens/home/home_screen.dart';
import 'package:pyc/screens/login/login_screen.dart';
import 'package:pyc/screens/splash/splash_screen.dart';

List<GetPage> routes = [
  GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
  GetPage(
    name: LoginScreen.routeName,
    page: () => const LoginScreen(),
    binding: BindingsBuilder(
      () {
        Get.put(LoginController());
      },
    ),
  ),
  GetPage(name: HomeScreen.routeName, page: () => const HomeScreen()),
];
