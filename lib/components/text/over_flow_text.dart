import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class OverFlowText extends StatefulWidget {
  final String text;
  final int? maxLength;
  final int? maxLine;
  final VoidCallback? onTap;
  const OverFlowText({
    super.key,
    required this.text,
    this.onTap,
    this.maxLine = 2,
    this.maxLength = 50,
  });

  @override
  State<OverFlowText> createState() => _OverFlowTextState();
}

class _OverFlowTextState extends State<OverFlowText> {
  bool _isOverFlow = false;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _isOverFlow = widget.text.length > widget.maxLength!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: widget.maxLine,
          overflow: _isOverFlow ? TextOverflow.ellipsis : TextOverflow.visible,
          style: const TextStyle(
            fontSize: 14.0,
            color: kTextBlackColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        kQuarterHeightSizedBox,
        if (_isOverFlow)
          InkWell(
            onTap: widget.onTap,
            child: const Text(
              '...더보기',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
      ],
    );
  }
}
