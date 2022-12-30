import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/content/default_avatar_content.dart';

class NoticeContent extends StatelessWidget {
  final String title;
  final String name;
  final DateTime createdAt;
  final String? image;
  final String content;

  const NoticeContent({
    super.key,
    required this.title,
    required this.name,
    required this.createdAt,
    required this.image,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultValue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Notice Header
          DefaultAvatarContent(
            title: title,
            content: '작성자 | $name',
            subContent: DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(createdAt.add(const Duration(hours: 9))).toString(),
            avatarImage: image,
          ),
          kHeightSizeBox,

          /// Notice Body
          Text(
            content,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: kTextBlackColor,
            ),
          ),
        ],
      ),
    );
  }
}
