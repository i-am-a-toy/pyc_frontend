import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pyc_app/components/button/default_state_button.dart';
import 'package:pyc_app/components/checkbox/default_checkbox_button.dart';
import 'package:pyc_app/components/form/default_password_field.dart';
import 'package:pyc_app/components/form/default_suffix_input_field.dart';
import 'package:pyc_app/constants/constants.dart';
import 'package:pyc_app/controllers/login/login_controller.dart';
import 'package:pyc_app/utils/validator/validator.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();
    String id = '';
    String password = '';

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    kDefaultValue,
                    kDefaultValue * 2,
                    kDefaultValue,
                    0,
                  ),
                  child: SizedBox(
                    height: size.height / 2.5,
                    child: SvgPicture.asset(
                      'assets/icons/in_love_image.svg',
                    ),
                  ),
                ),
                Text(
                  'Hi Leader :)',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: kPrimaryColor,
                        fontSize: 35.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                kHeightSizeBox,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultValue,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        GetBuilder<LoginController>(
                          builder: (controller) => DefaultSuffixInputField(
                            label: 'ID',
                            hint: '아이디를 입력해주세요.',
                            onChange: controller.validInputId,
                            validator: requiredStringValidator,
                            onSaved: (val) => id = val!.trim(),
                            isValid: controller.isValidId,
                          ),
                        ),
                        kDoubleHeightSizeBox,
                        GetBuilder<LoginController>(
                          builder: (controller) => DefaultPasswordField(
                            label: 'Password',
                            hint: '비밀번호를 입력해주세요.',
                            onChage: controller.validInputPassword,
                            validator: requiredStringValidator,
                            onSaved: (val) => id = val!.trim(),
                          ),
                        ),
                        kHalfHeightSizeBox,
                        SizedBox(
                          width: size.width,
                          height: 25.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              GetBuilder<LoginController>(
                                builder: (controller) => SizedBox(
                                  height: kDefaultValue,
                                  width: kDefaultValue,
                                  child: DefaultCheckBox(
                                    initValue: controller.isSavedId,
                                    onChanged: controller.toggleSavedId,
                                  ),
                                ),
                              ),
                              kHalfWidthSizedBox,
                              const Text(
                                '아이디 저장',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w300,
                                  color: kHintTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        kHeightSizeBox,
                        GetBuilder<LoginController>(
                          builder: (controller) => DefaultStatusButton(
                            onPress: () {
                              // bool result = formCurrentStateValidate(formKey);
                              // if (!result) return;
                              // formKey.currentState!.save();
                            },
                            title: '로그인',
                            status: controller.isValid,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
