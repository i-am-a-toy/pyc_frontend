import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/content/default_content_header.dart';
import 'package:pyc/components/text/over_flow_text.dart';
import 'package:pyc/screens/notice/components/notice_comment_button.dart';

List<String> texts = [
  '감사합니다! 확인했습니다 :) 감사합니다! 확인했습니다 :) 감사합니다! 확인했습니다 :) 감사합니다! 확인했습니다 :) 감사합니다! 확인했습니다 :)',
  '12월 청년부 일정에 대한 공지사항입니다. \n두번째 내용은 없습니다.',
  '12월 청년부 일정에 대한 공지사항입니다. \n세번째 공지사항은 앞으로 여러분들과 함께 할 어플을 공개합니다.',
];

class NoticeListCard extends StatelessWidget {
  final int index;

  const NoticeListCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              // TODO: 넘겨받은 데이터로 Content Header를 그려줘야 한다.
              DefaultContentHeader(
                avatar: Image.asset(
                  'assets/images/test_user.png',
                ),
                title: '12월 공지사항 입니다.',
                content: '작성자 | 이우길',
              ),
              kHeightSizeBox,
              OverFlowText(
                text: texts[index],
                tag: 'notice$index',
                onTap: () {},
              ),
              kHalfHeightSizeBox,
            ],
          ),
          //Comment Button
          Expanded(
            child: NoticeCommentButton(
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
