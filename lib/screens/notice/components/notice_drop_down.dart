import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';

class NoticeSortDropDown extends StatelessWidget {
  const NoticeSortDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      '최신순',
      '오래된순',
    ];

    return SizedBox(
      // width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: kPrimaryColor,
                            width: 1.0, // Underline thickness
                          ),
                        ),
                      ),
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff606060),
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          value: '최신순',
          onChanged: (value) {},
          buttonHeight: 40,
          buttonWidth: 90,
          itemHeight: 40,
          dropdownDecoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(kDefaultValue / 2),
          ),
          iconEnabledColor: kPrimaryColor,
          icon: const Icon(
            Icons.expand_more_outlined,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}
