import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc_app/components/button/default_state_button.dart';
import 'package:pyc_app/components/checkbox/default_checkbox_button.dart';
import 'package:pyc_app/components/form/default_password_field.dart';
import 'package:pyc_app/components/form/default_suffix_input_field.dart';
import 'package:pyc_app/constants/constants.dart';
import 'package:pyc_app/controllers/login/login_controller.dart';
import 'package:pyc_app/utils/validator/form_validator.dart';
import 'package:pyc_app/utils/validator/validator.dart';

/// REFERENCES
/// Checkbox: https://stackoverflow.com/questions/53152386/flutter-how-to-remove-default-padding-48-px-as-per-doc-from-widgets-iconbut

// 상태관리가 되어야 한다.
// Login Controller를 만들어서 상태를 관리해보자.
class NewLoginScreen extends StatelessWidget {
  static String routeName = '/login2';
  const NewLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = '';
    String password = '';
    GlobalKey formKey = GlobalKey<FormState>();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: ListView(
              children: <Widget>[
                SizedBox(
                  width: size.width,
                  height: 120.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '반가워요!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      kQuarterHeightSizedBox,
                      Text(
                        '회원서비스를 위해 로그인이 필요합니다.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF606060),
                        ),
                      ),
                    ],
                  ),
                ),
                kHeightSizeBox,
                Container(
                  width: size.width,
                  height: 200.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/login_page.png'),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                kHeightSizeBox,
                Form(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
