import 'package:get/get.dart';
import 'package:pyc_app/screen/login/login_screen.dart';
import 'package:pyc_app/screen/splash/splash_screen.dart';

List<GetPage> routes = [
  GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
  GetPage(name: LoginScreen.routeName, page: () => const LoginScreen())
];
