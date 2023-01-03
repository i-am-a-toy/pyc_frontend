import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultAvatarContent extends StatelessWidget {
  final String? avatarImage;
  final Widget? avatarChild;
  final String title;
  final String content;
  final String? subContent;
  final TextOverflow? overflow;

  const DefaultAvatarContent({
    super.key,
    required this.title,
    required this.content,
    this.avatarImage,
    this.subContent,
    this.overflow,
    this.avatarChild,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (avatarChild != null || avatarImage != null)
          CircleAvatar(
            maxRadius: 24.0,
            backgroundColor: kPrimaryColor,
            backgroundImage: avatarChild != null
                ? null
                : avatarImage != null
                    ? NetworkImage(avatarImage!)
                    : kDefaultUserImage,
            child: avatarChild,
          ),
        kHalfWidthSizedBox,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: overflow ?? TextOverflow.visible,
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kQuarterHeightSizedBox,
              RichText(
                overflow: overflow ?? TextOverflow.visible,
                text: TextSpan(
                  text: '$content ',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: kTextBlackColor,
                  ),
                  children: [
                    if (subContent != null)
                      TextSpan(
                        text: subContent!,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: kTextBlackColor,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
