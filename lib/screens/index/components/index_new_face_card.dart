import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class IndexNewFaceCard extends StatelessWidget {
  final Widget avatarChild;
  final String name;
  final String comeDate;
  final int weekly;
  final String? content;
  final double? height;

  const IndexNewFaceCard({
    Key? key,
    required this.avatarChild,
    required this.name,
    required this.comeDate,
    this.content = '새친구팀 만남',
    this.height = 70.0,
    required this.weekly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        margin: const EdgeInsets.only(
          right: kDefaultValue,
        ),
        padding: const EdgeInsets.all(kDefaultValue),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(
            kDefaultValue / 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: kSecondaryColor,
                    maxRadius: 35.0,
                    child: avatarChild,
                  ),
                  kHalfWidthSizedBox,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: kTextWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        '$comeDate 첫방문',
                        style: const TextStyle(
                          color: kTextWhiteColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 60.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultValue,
                ),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(
                    kDefaultValue / 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      content!,
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '$weekly주차',
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
