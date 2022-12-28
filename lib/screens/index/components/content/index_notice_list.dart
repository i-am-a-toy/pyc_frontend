import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/data/model/notice/response/notice_response.dart';
import 'package:pyc/extension/date_time.dart';
import 'package:pyc/screens/index/components/icon/index_content_icon.dart';
import 'package:pyc/screens/index/components/index_content_card.dart';
import 'package:pyc/screens/notice/notice_detail_screen.dart';

class IndexNoticeList extends StatelessWidget {
  const IndexNoticeList({
    Key? key,
    required this.cardCount,
    required this.rows,
    required this.count,
  }) : super(key: key);

  final int cardCount;
  final List<NoticeResponse> rows;
  final int count;

  @override
  Widget build(BuildContext context) {
    final range = rows.length < cardCount ? rows.length : cardCount;
    return Column(
      children: <Widget>[
        if (count != 0)
          for (int i = 0; i < range; i++)
            IndexContentCard(
              // avatarChild: const Icon(
              avatarChild: getIndexContentCardIcon(Icons.campaign_outlined),
              title: rows[i].title,
              content: '작성자 | ${rows[i].creator.name}',
              subContent: rows[i].createdAt.getDifferenceNow(),
              goTo: () {
                Get.toNamed(
                  NoticeDetailScreen.routeName,
                  arguments: {"targetId": rows[i].id, "autoFocus": false},
                );
              },
            ),
        if (count == 0)
          IndexContentCard(
            title: '등록 된 공지사항이 없습니다.',
            avatarChild: getIndexContentCardIcon(Icons.campaign_outlined),
            content: '공지사항을 등록해주세요.',
          ),
      ],
    );
  }
}
