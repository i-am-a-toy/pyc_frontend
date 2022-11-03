import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/screens/home/home_screen.dart';
import 'package:pyc/screens/login/login_screen.dart';
import 'package:pyc/services/login_service.dart';

// https://velog.io/@jakob1/FlutterSecureStorage%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%9C-%EB%A1%9C%EA%B7%B8%EC%9D%B8-%EC%83%81%ED%83%9C-%EC%9C%A0%EC%A7%80
class SplashScreen extends StatefulWidget {
  static String routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //flutter_secure_storage 사용을 위한 초기화 작업
  @override
  void initState() {
    super.initState();

    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/passion_logo.png',
                width: 200.0,
                height: 200.0,
                color: kPrimaryColor,
              ),
              Text(
                'Passion',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: kPrimaryColor,
                      fontSize: 50.0,
                      fontStyle: FontStyle.normal,
                    ),
              ),
              Text(
                '열정 청년부',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: kPrimaryColor,
                      fontSize: 50.0,
                      fontStyle: FontStyle.normal,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _asyncMethod() async {
    const storage = FlutterSecureStorage();
    // reutrn String or null
    final token = await storage.read(key: 'token');
    if (token == null || token == '') {
      _goToLogin();
      return;
    } // not exist token

    try {
      final response = await LoginService().isValidated(token);
      if (response.result) {
        // validated true
        _goToHome();
        return;
      }
      _goToLogin();
    } catch (e) {
      _goToLogin(); // validate request fail
    }
  }

  void _goToLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(LoginScreen.routeName);
      return;
    });
  }

  void _goToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(HomeScreen.routeName);
      return;
    });
  }
}
