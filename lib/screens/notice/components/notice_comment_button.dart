import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/button/default_leading_button.dart';

class NoticeCommentButton extends StatelessWidget {
  final VoidCallback onTap;

  const NoticeCommentButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultValue / 2),
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xffD9D9D9),
            width: 2.0,
          ),
        ),
      ),
      child: DefaultLeadingButton(
        leading: SvgPicture.asset('assets/icons/message_icon.svg'),
        onTap: onTap,
        text: '댓글 달기',
      ),
    );
  }
}
