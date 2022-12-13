import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/form/default_border_input_field.dart';

class NoticeDetailBottomSheet extends StatelessWidget {
  final bool autoFocus;
  final String image;
  final Future<void> Function(String) saveComment;

  const NoticeDetailBottomSheet({
    super.key,
    required this.autoFocus,
    required this.image,
    required this.saveComment,
  });

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String comment = '';

    return Form(
      key: formKey,
      child: Container(
        width: double.infinity,
        height: kDefaultValue * 4,
        padding: const EdgeInsets.only(
          top: kDefaultValue / 2,
          left: kDefaultValue,
          right: kDefaultValue,
        ),
        child: DefaultBorderInputField(
          autoFocus: autoFocus,
          isRounded: true,
          validator: (val) => (val == null || val.trim().isEmpty) ? '' : null,
          onSaved: (val) => comment = val!,
          contentPadding: const EdgeInsets.symmetric(vertical: kDefaultValue / 2),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultValue / 2),
            child: CircleAvatar(
              backgroundColor: kPrimaryColor,
              backgroundImage: NetworkImage(image),
            ),
          ),
          suffixIcon: InkWell(
            onTap: () async {
              if (!formKey.currentState!.validate()) return;
              formKey.currentState!.save();
              await saveComment(comment);
              FocusManager.instance.primaryFocus?.unfocus();
              formKey.currentState!.reset();
            },
            child: SvgPicture.asset(
              'assets/icons/send_icon.svg',
              color: kPrimaryColor,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
