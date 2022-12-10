import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

PreferredSizeWidget getNoticeAppBar({required List<Widget> actions}) {
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
    actions: actions,
  );
}

// IconButton(
//         onPressed: onTap,
//         icon: SvgPicture.asset(
//           'assets/icons/pencil_icon.svg',
//           width: kDefaultValue * 2,
//           color: kTextWhiteColor,
//         ),
//       ),
