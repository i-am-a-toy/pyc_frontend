import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc_app/constants/constants.dart';
import 'package:pyc_app/routes/routes.dart';
import 'package:pyc_app/screen/splash/splash_screen.dart';
import 'package:pyc_app/theme/input_theme.dart';
// import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'passion',
      theme: ThemeData.light().copyWith(
        primaryColor: kPrimaryColor,
        inputDecorationTheme: inputDecorationTheme,
        appBarTheme: const AppBarTheme(
          color: kPrimaryColor,
          elevation: 0,
        ),
      ),
      home: const Text('foo'),
      initialRoute: SplashScreen.routeName,
      getPages: routes,
    );
  }
}
