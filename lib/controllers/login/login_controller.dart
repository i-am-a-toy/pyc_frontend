import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  String _id = '';
  bool _isLoading = false;
  bool _isSavedId = false;

  @override
  @mustCallSuper
  void onInit() async {
    super.onInit();
    String? id = await getId();
    if (id != null && id.isNotEmpty) _id = id;
    _isLoading = false;
    update();
  }

  bool get isLoading => _isLoading;
  bool get isSavedId => _isSavedId;
  String get id => _id;

  void toggleSavedId() {
    _isSavedId = !_isSavedId;
    update();
  }

  Future<String?> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? selected = prefs.getString('id');
    return selected;
  }

  Future<void> setId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);
  }
}
