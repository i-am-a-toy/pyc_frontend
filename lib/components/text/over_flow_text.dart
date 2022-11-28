import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/controllers/over_flow_text/over_flow_text_controller.dart';

class OverFlowText extends StatelessWidget {
  final String text;
  final int? maxLine;
  final Color? fontColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;
  final String? tag;

  const OverFlowText({
    Key? key,
    required this.text,
    this.onTap,
    this.maxLine = 2,
    this.fontColor = kTextBlackColor,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w400,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<OverFlowTextController>(OverFlowTextController(text), tag: tag);

    return GetBuilder<OverFlowTextController>(
      tag: tag,
      builder: (controller) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            maxLines: maxLine,
            overflow: controller.isOverFlow
                ? TextOverflow.ellipsis
                : TextOverflow.visible,
            style: TextStyle(
              fontSize: fontSize,
              color: fontColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          kQuarterHeightSizedBox,
          if (controller.isOverFlow)
            InkWell(
              onTap: onTap,
              child: const Text('...더보기'),
            ),
        ],
      ),
    );
  }
}
