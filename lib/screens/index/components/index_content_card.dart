import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/content/default_avatar_content.dart';

class IndexContentCard extends StatelessWidget {
  final double? height;
  final Widget avatarChild;
  final String title;
  final String content;
  final String? subContent;
  final VoidCallback? goTo;

  const IndexContentCard({
    Key? key,
    this.height = 80.0,
    required this.avatarChild,
    required this.title,
    required this.content,
    this.subContent,
    this.goTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: kDefaultValue / 2,
      ),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(kDefaultValue / 2),
      ),
      padding: const EdgeInsets.only(left: kDefaultValue),
      child: Row(
        children: [
          Expanded(
            child: DefaultAvatarContent(
              title: title,
              content: content,
              subContent: subContent,
              overflow: TextOverflow.ellipsis,
              avatarChild: avatarChild,
            ),
          ),
          if (goTo != null)
            IconButton(
              onPressed: goTo,
              icon: const Icon(
                Icons.keyboard_arrow_right_outlined,
                size: 32.0,
                color: kPrimaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
