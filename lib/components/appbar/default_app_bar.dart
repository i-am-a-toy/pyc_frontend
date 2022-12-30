import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

PreferredSizeWidget getDefaultAppBar({
  required String title,
  Widget? leading,
  List<Widget>? actions,
  Color? backgroundColor,
  Color? actionsColor,
}) {
  return AppBar(
    backgroundColor: backgroundColor ?? kPrimaryColor,
    title: Text(title),
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: kTextWhiteColor,
      fontSize: kDefaultValue,
      fontWeight: FontWeight.bold,
    ),
    leading: leading,
    actions: actions,
    actionsIconTheme: IconThemeData(
      color: actionsColor ?? Colors.white,
      size: kDefaultValue * 2,
    ),
  );
}
