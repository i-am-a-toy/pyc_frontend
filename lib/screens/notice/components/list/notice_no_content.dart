import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

/// NoticeNoContent
///
/// 공지사항의 List가 없는 경우 보여질 Widget 추 후 공통컴포넌트로 빠질 수 있음.
class NoticeNoContent extends StatelessWidget {
  final String content;
  const NoticeNoContent({
    super.key,
    required this.content,
  });

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
