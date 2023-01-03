import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/appbar/default_app_bar.dart';
import 'package:pyc/screens/index/components/index_content_card.dart';

class GroupScreen extends StatelessWidget {
  final Widget child;
  const GroupScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getDefaultAppBar(
        title: '네트워크 목록',
        actions: _getAction(),
      ),
      body: Stack(
        children: [
          /// Orientation.portrait 모드일 경우에만 List Bottom Image가 보여지게 된다.
          if (MediaQuery.of(context).orientation == Orientation.portrait)
            Positioned(
              bottom: -(kDefaultValue * 2.5),
              child: ClipOval(
                child: Container(
                  // color: const Color(0xffEDFCFC),
                  color: kPrimaryColor,
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                ),
              ),
            ),
          if (MediaQuery.of(context).orientation == Orientation.portrait)
            Positioned(
              bottom: -(kDefaultValue * 2.5),
              child: Container(
                // color: const Color(0xffEDFCFC),
                color: kPrimaryColor,
                width: MediaQuery.of(context).size.width,
                height: 80,
              ),
            ),

          /// Orientation.portrait 모드일 경우에만 List Bottom Image가 보여지게 된다.
          if (MediaQuery.of(context).orientation == Orientation.portrait)
            Positioned(
              bottom: -(kDefaultValue),
              width: MediaQuery.of(context).size.width,
              child: SvgPicture.asset(
                'assets/images/list_bottom_image.svg',
                alignment: Alignment.bottomCenter,
              ),
            ),
          Positioned.fill(
            top: kDefaultValue * 2,
            child: RefreshIndicator(
              color: kPrimaryColor,
              onRefresh: () async => print('그룹 리스트 리 패칭'),

              /// TODO: 무한 스크롤 적용해야 합니다.
              child: ListView(
                children: const <GroupCard>[
                  GroupCard(
                    groupId: 1,
                    groupName: '임은하 그룹',
                    leaderName: '임은하',
                  ),
                  GroupCard(
                    groupId: 2,
                    groupName: '박순홍 그룹',
                    leaderName: '박순홍',
                  ),
                  GroupCard(
                    groupId: 3,
                    groupName: '고희석 그룹',
                    leaderName: '고희석',
                  ),
                  GroupCard(
                    groupId: 4,
                    groupName: '송제영 그룹',
                    leaderName: '송제영',
                  ),
                  GroupCard(
                    groupId: 5,
                    groupName: '김민지 그룹',
                    leaderName: '김민지',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getAction() {
    return [
      IconButton(
        onPressed: () => print('그룹을 등록하는 페이지로 이동'),
        icon: const Icon(
          Icons.add_circle_outline,
          size: kDefaultValue * 1.5,
        ),
      ),
    ];
  }
}

class GroupCard extends StatelessWidget {
  final int groupId;
  final String groupName;
  final String leaderName;

  const GroupCard({
    Key? key,
    required this.groupId,
    required this.groupName,
    required this.leaderName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultValue,
        ),
        child: InkWell(
          onTap: () {},
          child: IndexContentCard(
            title: groupName,
            content: '그룹장 - $leaderName',
            goTo: () => print('$groupId 로 이동해야 해요'),
          ),
        ),
      ),
    );
  }
}
