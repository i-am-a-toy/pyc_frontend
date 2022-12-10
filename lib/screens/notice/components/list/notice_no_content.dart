import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class NoticeNoContent extends StatelessWidget {
  final String content = '등록된 공지사항이 없습니다.';
  const NoticeNoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          content,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
