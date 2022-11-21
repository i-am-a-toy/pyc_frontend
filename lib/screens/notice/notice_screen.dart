import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/screens/notice/components/notice_appbar.dart';
import 'package:pyc/screens/notice/components/notice_drop_down.dart';
import 'package:pyc/screens/notice/components/notice_list_card.dart';

class NoticeScreen extends StatelessWidget {
  static const String routeName = '/notice';
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: getNoticeAppBar(onTap: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultValue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHalfHeightSizeBox,
            const NoticeSortDropDown(),
            kHalfHeightSizeBox,
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                //TODO: 공지사항에 대한 데이터를 여기서 내려줘야 한다.
                itemBuilder: (context, index) => NoticeListCard(
                  index: index,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
