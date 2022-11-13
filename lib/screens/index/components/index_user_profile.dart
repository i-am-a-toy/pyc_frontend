import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/label/default_rounded_label.dart';

class IndexUserProfile extends StatelessWidget {
  final String userRole;
  final String name;
  final String userProfile;

  const IndexUserProfile({
    Key? key,
    required this.userRole,
    required this.name,
    required this.userProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultRoundedLabel(label: userRole),
            kHalfHeightSizeBox,
            const Text(
              '안녕하세요!',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 30.0,
              ),
            ),
            Text(
              '$name님',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          ],
        ),
        CircleAvatar(
          backgroundColor: kSecondaryColor,
          backgroundImage: NetworkImage(userProfile),
          maxRadius: 50,
        ),
      ],
    );
  }
}
