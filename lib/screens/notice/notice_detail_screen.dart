import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/content/default_content_header.dart';
import 'package:pyc/components/loading/loading_overlay.dart';
import 'package:pyc/controllers/notice/notice_detail_controller.dart';
import 'package:pyc/screens/notice/components/notice_appbar.dart';

//https://blog.naver.com/PostView.nhn?blogId=getinthere&logNo=221845651741

String noticeContent =
    '12월 둘째 주 주일 리더모임을 하려고 합니다!\n시간은 추후에 공지할 예정이며, 준비사항은 따로 없습니다!\n저녁 제공되니 늦지 않게 도착하세요!감사합니다! 확인했습니다 :) 감사합니다! 확인했습니다 :) 감사합니다! 확인했습니다 :) 감사합니다! 확인했습니다 :) 감사합니다! 확인했습니다 :)';

List<Widget> comments = [
  DefaultContentHeader(
    avatar: Image.asset(
      'assets/images/test_user.png',
    ),
    title: '임은하',
    content:
        '감사합니다! 확인했습니다 :) 감사합니다! 확인했습니다 :) 감사합니다! 확인했습니다 :) 감사합니다! 확인했습니다 :) 감사합니다! 확인했습니다 :)',
  ),
  DefaultContentHeader(
    avatar: Image.asset(
      'assets/images/test_user.png',
    ),
    title: '임은하',
    content: '감사합니다! 확인했습니다 :)',
  ),
];

class NoticeDetailScreen extends StatelessWidget {
  static const routeName = '/notice-detail';
  const NoticeDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getNoticeAppBar(onTap: () {}),
      bottomSheet: GetBuilder<NoticeDetailController>(
        builder: (controller) => SizedBox(
          width: double.infinity,
          height: 80,
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                top: kDefaultValue / 2,
                left: kDefaultValue,
                right: kDefaultValue,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: TextFormField(
                autofocus: controller.autoFocus,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: kSpacerColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: '댓글을 입력해주세요.',
                  hintStyle: const TextStyle(fontSize: 18.0),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultValue / 2,
                    ),
                    child: CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: Image.asset(
                        'assets/images/test_user.png',
                      ),
                    ),
                  ),
                  suffixIcon: SvgPicture.asset(
                    'assets/icons/send_icon.svg',
                    height: 5,
                    width: 5,
                    fit: BoxFit.scaleDown,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: kDefaultValue * 2,
            ),
            // Notice Header
            GetBuilder<NoticeDetailController>(
              builder: (controller) => LoadingOverlay(
                isLoading: controller.isLoading,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultValue,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultContentHeader(
                        avatarImage: NetworkImage(controller.image),
                        title: controller.title,
                        content: '작성자 | ${controller.name}',
                        subContent: DateFormat('yyyy.MM.dd HH시 mm분').format(
                          controller.createdAt.toLocal(),
                        ),
                      ),
                      const SizedBox(
                        height: kDefaultValue * 1.5,
                      ),
                      Text(
                        controller.content,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: kTextBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: kDefaultValue * 2),
            // spacer
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xffF2F2F2), width: 8.0),
                ),
              ),
            ),
            kHeightSizeBox,
            // comment Count
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultValue),
              child: Text(
                '댓글 20개',
                style: TextStyle(
                  color: kTextGreyColor,
                  fontSize: 12.0,
                ),
              ),
            ),
            //     kHeightSizeBox,
            //     Expanded(
            //       child: ListView.builder(
            //         itemCount: 20,
            //         itemBuilder: (context, index) {
            //           return Comment(
            //             index: index,
            //             length: comments.length,
            //           );
            //         },
            //       ),
            //     ),
          ],
        ),
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final int index;
  final int length;

  const Comment({
    Key? key,
    required this.index,
    required this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        kHalfHeightSizeBox,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultValue,
          ),
          child: DefaultContentHeader(
            avatar: Image.asset(
              'assets/images/test_user.png',
            ),
            title: '임은하',
            content:
                '감사합니다! 확인했습니다 :)\n감사합니다! 확인했습니다:)\n감사합니다! 확인했습니다 :)감사합니다! 확인했습니다 :)감사합니다! 확인했습니다 :)\n감사합니다! 확인했습니다 :)\n',
            width: size.width * 0.7,
          ),
        ),
        kHalfHeightSizeBox,
        if (index != length - 1)
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xffF2F2F2), width: 1.0),
              ),
            ),
          ),
      ],
    );
  }
}
