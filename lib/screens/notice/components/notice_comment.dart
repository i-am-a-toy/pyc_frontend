import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/content/default_content_header.dart';

class Comment extends StatelessWidget {
  final int index;
  final int length;
  final Widget avatar;
  final String writer;
  final String comment;

  const Comment({
    Key? key,
    required this.index,
    required this.length,
    required this.avatar,
    required this.writer,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kHalfHeightSizeBox,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultValue,
          ),
          child: DefaultContentHeader(
            avatar: avatar,
            title: writer,
            content: comment,
            titleColor: kTextBlackColor,
          ),
        ),
        kHalfHeightSizeBox,
        if (index != length - 1)
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kSpacerColor,
                  width: 1.0,
                ),
              ),
            ),
          )
      ],
    );
  }
}
