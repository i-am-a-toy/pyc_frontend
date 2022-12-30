import 'package:flutter/material.dart';
import 'package:pyc/data/model/calendar/response/calendar_response.dart';
import 'package:pyc/screens/index/components/icon/index_content_icon.dart';
import 'package:pyc/screens/index/components/index_content_card.dart';

class IndexCalendarList extends StatelessWidget {
  const IndexCalendarList({
    Key? key,
    required this.cardCount,
    required this.rows,
    required this.count,
  }) : super(key: key);

  final int cardCount;
  final List<CalendarResponse> rows;
  final int count;

  @override
  Widget build(BuildContext context) {
    final range = rows.length < cardCount ? rows.length : cardCount;
    return Column(
      children: <Widget>[
        if (count != 0)
          for (int i = 0; i < range; i++)
            IndexContentCard(
              avatarChild: getIndexContentCardIcon(Icons.edit_calendar_outlined),
              title: rows[i].title,
              content: rows[i].content,
              goTo: () {},
            ),
        if (count == 0)
          IndexContentCard(
            title: '등록 된 일정이 없습니다.',
            avatarChild: getIndexContentCardIcon(Icons.edit_calendar_outlined),
            content: '일정 탭에서 일정을 등록해주세요.',
          ),
      ],
    );
  }
}
