import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';

PreferredSizeWidget getCalendarAppbar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: const Text(
      'Calendar',
      style: TextStyle(
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: kDefaultValue / 2),
        child: IconButton(
          onPressed: () {
            Get.defaultDialog(
              title: '일정을 등록해주세요.',
              middleText: '일정등록하는 모달 만들기',
            );
          },
          icon: const Icon(
            Icons.add_outlined,
            color: kPrimaryColor,
          ),
        ),
      ),
    ],
  );
}
