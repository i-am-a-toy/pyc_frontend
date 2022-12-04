import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/date/date.dart';
import 'package:pyc/components/text/over_flow_text.dart';
import 'package:pyc/screens/notice/components/notice_comment_button.dart';

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
            Row(
              children: [
                // TODO: 공통 부분 발생
                CircleAvatar(
                  maxRadius: 24.0,
                  backgroundColor: kPrimaryColor,
                  backgroundImage: writerImage != null ? NetworkImage(writerImage!) : kDefaultUserImage,
                ),
                kWidthSizeBox,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      kQuarterHeightSizedBox,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '작성자 | $writer',
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          kQuarterWidthSizedBox,
                          Text(
                            getDifferceTime(createAt),
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                kHeightSizeBox,
              ],
            ),
            kHeightSizeBox,
            Expanded(
              child: OverFlowText(
                text: content,
                tag: 'notice$index',
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

// Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 DefaultContentHeader(
//                   width: MediaQuery.of(context).size.width * 0.65,
//                   avatarImage: writerImage != null
//                       ? NetworkImage(writerImage!)
//                       : Image.asset(
//                           'assets/icons/person_icon.png',
//                           width: kDefaultValue,
//                           height: kDefaultValue,
//                         ).image,
//                   title: title,
//                   content: '작성자 | $writer',
//                 ),
//                 kHeightSizeBox,
//                 OverFlowText(
//                   text: content,
//                   tag: 'notice$index',
//                 ),
//                 kHalfHeightSizeBox,
//               ],
//             ),
//             //Comment Button
//             SizedBox(
//               height: kDefaultValue * 2.5,
//               child: NoticeCommentButton(
//                 onTap: commentTap,
//               ),
//             ),
//           ],
//         ),
