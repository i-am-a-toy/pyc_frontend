import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverFlowTextController extends GetxController {
  String text;
  int? maxLength = 50;
  bool _isOverFlow = false;

  OverFlowTextController(this.text, {int? maxLength});

  @override
  @mustCallSuper
  void onInit() {
    super.onInit();
    _isOverFlow = text.length > maxLength!;
  }

  get isOverFlow => _isOverFlow;
}
