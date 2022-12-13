import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/enum/sort_type.dart';
import 'package:pyc/controllers/notice/notice_controller.dart';

class NoticeSortDropDown extends StatelessWidget {
  const NoticeSortDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GetBuilder<NoticeController>(
        builder: (controller) => DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            items: controller.items
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff606060),
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
                .toList(),
            value: controller.sortType.displayName,
            onChanged: (value) {
              controller.sort(SortType.getByDisplayName(value!));
            },
            buttonHeight: kDefaultValue * 2,
            buttonWidth: 90,
            itemHeight: kDefaultValue * 2,
            dropdownDecoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(kDefaultValue / 2),
            ),
            iconEnabledColor: kPrimaryColor,
            icon: const Icon(Icons.expand_more_outlined, size: kDefaultValue * 1.5),
          ),
        ),
      ),
    );
  }
}
