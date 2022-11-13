import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class IndexAttendance extends StatelessWidget {
  final double? height;
  final Color? color;
  final String date;
  final String content;
  final int attendance;
  final int total;

  const IndexAttendance({
    Key? key,
    this.height = 130,
    this.color = kPrimaryColor,
    required this.date,
    required this.content,
    required this.attendance,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultValue / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeightSizeBox,
              Text(
                date,
                style: const TextStyle(
                  color: kTextWhiteColor,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                content,
                style: const TextStyle(
                  color: kTextWhiteColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kHeightSizeBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$attendance',
                    style: const TextStyle(
                      color: kPointColor,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    '/$total',
                    style: const TextStyle(
                      color: kTextWhiteColor,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  const Text(
                    '명',
                    style: TextStyle(
                      color: kTextWhiteColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
