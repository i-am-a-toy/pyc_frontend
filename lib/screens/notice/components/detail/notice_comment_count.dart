import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class NoticeCommentCount extends StatelessWidget {
  final int count;

  const NoticeCommentCount({
    Key? key,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
      child: Text(
        '댓글 $count개',
        style: const TextStyle(
          color: kTextGreyColor,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
