import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pyc_app/components/button/default_buttons.dart';
import 'package:pyc_app/components/form/default_input_field.dart';
import 'package:pyc_app/components/form/default_password_field.dart';
import 'package:pyc_app/constants/constants.dart';
import 'package:pyc_app/utils/validator/form_validator.dart';

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
                        DefaultInputField(
                          label: "Id",
                          onSaved: (val) => id = val!.trim(),
                          validator: requiredFormValidator,
                        ),
                        kHeightSizeBox,
                        DefaultPasswordField(
                          label: "Password",
                          onSaved: (val) => password = val!.trim(),
                          validator: requiredFormValidator,
                        ),
                        kHeightSizeBox,
                        DefaultButton(
                          onPress: () {
                            bool result = formCurrentStateValidate(formKey);
                            if (!result) return;
                            formKey.currentState!.save();
                            //TODO: 로그인처리 후 Home화면
                          },
                          title: "Login",
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              log("비밀번호 찾는 로직");
                            },
                            child: const Text(
                              'Did you forget password?',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
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
