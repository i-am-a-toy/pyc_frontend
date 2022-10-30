import 'package:flutter/material.dart';

bool defaultFormValidator(GlobalKey<FormState> formKey) {
  return formKey.currentState != null && formKey.currentState!.validate();
}

String? requiredStringValidator(String? val) {
  print(val);
  if (val == null || val.trim().isEmpty) {
    return '필수 입력입니다.';
  }
  return null;
}

String? requiredNumberValidator(String? val) {
  if (val == null || val.trim().isEmpty) {
    return '필수 입력입니다.';
  }

  if (num.tryParse(val) == null) {
    return '숫자만 입력해주세요.';
  }
  return null;
}
