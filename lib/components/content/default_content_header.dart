import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class DefaultContentHeader extends StatelessWidget {
  final Widget avatar;
  final String title;
  final String content;
  final double? width;
  final String? subContent;
  final double? avatarRadius;
  final double? titleSize;
  final Color? titleColor;
  final double? contentSize;
  final Color? contentColor;
  final double? subContentSize;
  final Color? subContentColor;

  const DefaultContentHeader({
    Key? key,
    required this.avatar,
    required this.title,
    required this.content,
    this.subContent,
    this.avatarRadius = 24.0,
    this.titleSize = 16.0,
    this.titleColor = kPrimaryColor,
    this.contentSize = 14.0,
    this.contentColor = kTextGreyColor,
    this.subContentSize,
    this.subContentColor,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: kPrimaryColor,
          maxRadius: avatarRadius,
          child: avatar,
        ),
        kWidthSizeBox,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            kQuarterHeightSizedBox,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  width: width,
                  child: SizedBox(
                    child: Text(
                      content,
                      style: TextStyle(
                        fontSize: contentSize,
                        fontWeight: FontWeight.w400,
                        color: contentColor,
                      ),
                    ),
                  ),
                ),
                kQuarterWidthSizedBox,
                if (subContent != null)
                  Text(
                    subContent!,
                    style: TextStyle(
                      fontSize: subContentSize,
                      fontWeight: FontWeight.w400,
                      color: subContentColor,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
