import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

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
          InkWell(
            onTap: goContent,
            child: Text(
              title,
              style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          kHalfHeightSizeBox,
          child,
        ],
      ),
    );
  }
}
