import 'package:get/get.dart';
import 'package:pyc_app/controllers/login/login_controller.dart';
import 'package:pyc_app/screen/login/login_screen.dart';
import 'package:pyc_app/screen/login/new_login_screen.dart';
import 'package:pyc_app/screen/splash/splash_screen.dart';

List<GetPage> routes = [
  GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
  GetPage(name: LoginScreen.routeName, page: () => const LoginScreen()),
  GetPage(
      name: NewLoginScreen.routeName,
      page: () => const NewLoginScreen(),
      binding: BindingsBuilder.put(() => LoginController())),
];
