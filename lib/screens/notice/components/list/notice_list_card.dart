import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/content/default_content_header.dart';
import 'package:pyc/components/text/over_flow_text.dart';
import 'package:pyc/screens/notice/components/notice_comment_button.dart';

class NoticeListCard extends StatelessWidget {
  final int index;
  final String title;
  final String writer;
  final String writerImage;
  final String content;
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: kDefaultValue),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(
          top: kDefaultValue,
          left: kDefaultValue,
          right: kDefaultValue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultContentHeader(
                  avatarImage: NetworkImage(writerImage),
                  title: title,
                  content: '작성자 | $writer',
                ),
                kHeightSizeBox,
                OverFlowText(
                  text: content,
                  tag: 'notice$index',
                ),
                kHalfHeightSizeBox,
              ],
            ),
            //Comment Button
            Expanded(child: NoticeCommentButton(onTap: commentTap)),
          ],
        ),
      ),
    );
  }
}