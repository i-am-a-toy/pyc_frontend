import 'package:get/get.dart';

class HomeController extends GetxController {
  int _index = 0;

  get index => _index;

  //TODO: index가 0인 경우 즉 Index로 다시 오는 경우 공지사항, Calendar 등등 Refetch 해야함.
  changeIndex(int index) {
    _index = index;
    update();
  }
}
