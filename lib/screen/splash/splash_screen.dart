import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc_app/constants/constants.dart';
import 'package:pyc_app/screen/login/new_login_screen.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //3초 뒤에 로그인 페이지로 이동시키키
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(NewLoginScreen.routeName);
    });

    return Scaffold(
      backgroundColor: kBackgroundColor,
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
                      color: kSecondaryColor,
                      fontSize: 50.0,
                      fontStyle: FontStyle.normal,
                    ),
              ),
              Text(
                '열정 청년부',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: kSecondaryColor,
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
}
