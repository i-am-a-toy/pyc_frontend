import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/data/model/user/response/user_response.dart';
import 'package:pyc/data/repository/user_repository.dart';
import 'package:pyc/screens/login/login_screen.dart';

class FetchMeController extends GetxController {
  final UserRepository repo;
  FetchMeController({required this.repo});

  @override
  @mustCallSuper
  void onInit() async {
    super.onInit();

    try {
      UserResponse resp = await repo.fetchMe();
      _isLoading = false;
      _id = resp.id;
      _churchId = resp.churchId;
      _cellId = resp.cellId;
      _name = resp.name;
      _image = resp.image;
      _age = resp.age;
      _role = resp.role;
      _rank = resp.rank;
      _gender = resp.gender;
      _zipCode = resp.zipCode;
      _address = resp.address;
      _birth = resp.birth;
      _contact = resp.contact;
      _isLongAbsenced = resp.isLongAbsenced;
      update();
    } catch (e) {
      if (e is DioError) {
        Get.offAll(LoginScreen.routeName);
        showSnackbar('요청 실패', e.message);
        return;
      }
      Get.offAll(LoginScreen.routeName);
      showSnackbar('요청 실패', '서버에 문제가 있습니다.\n관리자에게 문의해주세요.');
    }
  }

  bool _isLoading = true;
  int _id = 0;
  int _churchId = 0;
  int? _cellId;
  String _name = '';
  String _image = '';
  int _age = 0;
  String _role = '';
  String _rank = '';
  String _gender = '';
  String _zipCode = '';
  String _address = '';
  String _birth = '';
  String _contact = '';
  bool _isLongAbsenced = false;

  get isLoading => _isLoading;
  get id => _id;
  get churchId => _churchId;
  get getCellId => _cellId;
  get name => _name;
  get image => _image;
  get age => _age;
  get role => _role;
  get rank => _rank;
  get gender => _gender;
  get zipCode => _zipCode;
  get address => _address;
  get birth => _birth;
  get contact => _contact;
  get isLongAbsenced => _isLongAbsenced;
}
