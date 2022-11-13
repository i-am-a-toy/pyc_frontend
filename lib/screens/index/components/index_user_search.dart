import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class IndexUserSearch extends StatelessWidget {
  final IconData leadingIcon;
  final String? hintText;
  final double? height;
  final double? borderRadius;
  final int? maxLength;

  const IndexUserSearch({
    Key? key,
    required this.leadingIcon,
    this.height = 55.0,
    this.borderRadius = 500.0,
    this.maxLength = 20,
    this.hintText = '셀원을 검색해보세요',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius!),
        color: const Color(0xffF8F8F8),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultValue,
          ),
          child: TextFormField(
            cursorColor: kPrimaryColor,
            maxLength: maxLength,
            decoration: InputDecoration(
              icon: Icon(
                leadingIcon,
                color: kPrimaryColor,
                size: 30.0,
              ),
              hintText: hintText,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              counterText: '',
              hintStyle: const TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
