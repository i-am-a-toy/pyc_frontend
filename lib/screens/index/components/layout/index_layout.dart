import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/button/default_text_button.dart';

class IndexLayout extends StatelessWidget {
  final String title;
  final VoidCallback goContent;
  final Widget child;

  const IndexLayout({
    Key? key,
    required this.title,
    required this.goContent,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextButton(onTap: goContent, title: title),
          kHalfHeightSizeBox,
          child,
        ],
      ),
    );
  }
}
