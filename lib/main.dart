import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/theme/input_theme.dart';
import 'package:pyc/routes/routes.dart';
import 'package:pyc/screens/splash/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  //https://github.com/aleksanderwozniak/table_calendar#initialization
  initializeDateFormatting().then((_) => runApp(const MyApp()));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PYC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: inputDecorationTheme,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
            color: kPrimaryColor,
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            color: kHintTextColor,
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const Text('Hello World'),
      getPages: routes,
      initialRoute: SplashScreen.routeName,
      // home: const HomeScreen(),
    );
  }
}
