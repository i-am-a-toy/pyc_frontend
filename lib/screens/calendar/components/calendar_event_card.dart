import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/content/default_avatar_content.dart';

class CalendarEventCard extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String content;
  final String? subContent;

  const CalendarEventCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.content,
    this.subContent,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultValue / 2),
        child: DefaultAvatarContent(
          title: title,
          content: content,
          subContent: subContent,
        ),
      ),
    );
  }
}
