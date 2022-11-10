import 'package:get/get.dart';

class HomeController extends GetxController {
  int _index = 0;

  get index => _index;

  changeIndex(int index) {
    _index = index;
    update();
  }
}
