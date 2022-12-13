import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/date/date.dart';
import 'package:pyc/components/content/default_avatar_content.dart';
import 'package:pyc/components/text/over_flow_text.dart';
import 'package:pyc/screens/notice/components/list/notice_comment_button.dart';

class NoticeListCard extends StatelessWidget {
  final int index;
  final String title;
  final String writer;
  final String content;
  final DateTime createAt;
  final String? writerImage;
  final VoidCallback onTap;
  final VoidCallback commentTap;

  const NoticeListCard({
    Key? key,
    required this.index,
    required this.title,
    required this.writer,
    required this.content,
    required this.writerImage,
    required this.onTap,
    required this.commentTap,
    required this.createAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: kDefaultValue),
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultValue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            kHeightSizeBox,
            DefaultAvatarContent(
              title: title,
              content: '작성자 | $writer',
              overflow: TextOverflow.ellipsis,
              avatarImage: writerImage,
              subContent: getDifferceTime(createAt),
            ),
            kHeightSizeBox,
            Expanded(
              child: OverFlowText(
                text: content,
              ),
            ),
            kHeightSizeBox,
            SizedBox(
              height: kDefaultValue * 2.5,
              child: NoticeCommentButton(
                onTap: commentTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
