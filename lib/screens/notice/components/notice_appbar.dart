import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pyc/common/constants/constants.dart';

PreferredSizeWidget getNoticeAppBar({VoidCallback? onTap}) {
  return AppBar(
    title: const Text(
      '공지사항',
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    backgroundColor: kPrimaryColor,
    actions: [
      IconButton(
        onPressed: onTap,
        icon: SvgPicture.asset(
          'assets/icons/pencil_icon.svg',
          width: kDefaultValue * 2,
          color: kTextWhiteColor,
        ),
      )
    ],
  );
}
