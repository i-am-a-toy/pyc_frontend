import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class IndexContentCard extends StatelessWidget {
  final double? height;
  final Widget avatarChild;
  final String content;
  final String? subContent;
  final String? thirdContent;
  final VoidCallback? goTo;

  const IndexContentCard({
    Key? key,
    this.height = 80.0,
    required this.avatarChild,
    required this.content,
    this.subContent,
    this.thirdContent,
    this.goTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultValue / 2),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(kDefaultValue / 2),
      ),
      padding: const EdgeInsets.only(left: kDefaultValue),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            maxRadius: 24.0,
            backgroundColor: kPrimaryColor,
            child: avatarChild,
          ),
          kWidthSizeBox,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                kQuarterHeightSizedBox,
                if (subContent != null)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        subContent!,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kQuarterWidthSizedBox,
                      if (thirdContent != null)
                        Text(
                          thirdContent!,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          if (subContent != null)
            IconButton(
              onPressed: goTo,
              icon: const Icon(
                Icons.keyboard_arrow_right_outlined,
                size: 32.0,
                color: kPrimaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
