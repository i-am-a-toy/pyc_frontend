import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:pyc/common/constants/constants.dart';

class CalendarDateFormField extends FormField<DateTime> {
  CalendarDateFormField({
    required BuildContext context,
    required FormFieldSetter<DateTime> onConfirm,
    required DateTime initialValue,
    required bool isAllDay,
    required String title,
    FormFieldSetter<DateTime>? onSaved,
    FormFieldValidator<DateTime>? validator,
    DateTime? minTime,
    DateTime? maxTime,
    Key? key,
  }) : super(
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          key: key,
          builder: (FormFieldState<DateTime> state) {
            return InkWell(
              onTap: () => isAllDay
                  ? DatePicker.showDatePicker(
                      context,
                      locale: LocaleType.ko,
                      onConfirm: onConfirm,
                      currentTime: initialValue,
                      minTime: minTime,
                      maxTime: maxTime,
                    )
                  : DatePicker.showDateTimePicker(
                      context,
                      locale: LocaleType.ko,
                      currentTime: initialValue,
                      onConfirm: onConfirm,
                      minTime: minTime,
                      maxTime: maxTime,
                    ),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16.0,
                      ),
                    ),
                    kHalfHeightSizeBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('yyyy??? MM??? dd???').format(initialValue).toString(),
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        kWidthSizeBox,
                        if (!isAllDay)
                          Text(
                            DateFormat('a hh:mm').format(initialValue).toString(),
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                          ),
                      ],
                    ),
                    if (state.hasError)
                      Builder(
                        builder: (BuildContext context) => Text(
                          '${state.errorText}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12.0,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            );
          },
        );
}
