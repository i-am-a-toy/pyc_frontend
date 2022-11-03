import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/common/utils/validator/validator.dart';
import 'package:pyc/components/button/default_buttons.dart';
import 'package:pyc/components/checkbox/default_checkbox_button.dart';
import 'package:pyc/components/form/default_input_field.dart';
import 'package:pyc/components/form/default_password_field.dart';
import 'package:pyc/components/loading/loading_overlay.dart';
import 'package:pyc/controllers/login/login_controller.dart';
import 'package:pyc/services/login_service.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = '';
    String password = '';
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultValue,
              vertical: kDefaultValue * 6,
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        '반가워요!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                      kQuarterHeightSizedBox,
                      const Text(
                        '서비스를 이용하기 위해 로그인 해주세요.',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: kHintTextColor,
                        ),
                      ),
                      kDoubleHeightSizeBox,
                      Image.asset('assets/images/login_page.png'),
                      GetBuilder<LoginController>(
                        builder: (controller) => LoadingOverlay(
                          isLoading: controller.isLoading,
                          child: DefaultInputField(
                            key: Key(controller.id),
                            init: controller.id,
                            label: 'ID',
                            validator: requiredStringValidator,
                            onSaved: (val) {
                              id = val!.trim();
                            },
                          ),
                        ),
                      ),
                      kHeightSizeBox,
                      DefaultPasswordField(
                        label: 'PASSWORD',
                        validator: requiredStringValidator,
                        onSaved: (val) {
                          password = val!.trim();
                        },
                      ),
                      kHalfHeightSizeBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: kDefaultValue,
                            height: kDefaultValue,
                            child: GetBuilder<LoginController>(
                              builder: (controller) => DefaultCheckBox(
                                initValue: controller.isSavedId,
                                onChanged: (val) {
                                  controller.toggleSavedId();
                                },
                              ),
                            ),
                          ),
                          kHalfWidthSizedBox,
                          const Text(
                            '아이디 저장',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: kHintTextColor,
                            ),
                          ),
                        ],
                      ),
                      kDoubleHeightSizeBox,
                      DefaultButton(
                        onPress: () async {
                          if (!defaultFormValidator(formKey)) return;
                          formKey.currentState!.save();
                          await login(id, password);
                        },
                        title: '로그인',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login(String name, String password) async {
    //1. 아이디 저장
    Get.find<LoginController>().setId(name);

    try {
      //2. id와 password를 사용하여 로그인 처리
      final response = await LoginService().login(name, password);

      //3. 토큰을 얻어와서 기기에 저장
      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: response.token);

      //4. Index Page로 이동
      Get.offNamed('/home');
    } catch (e) {
      if (e is DioError) {
        showSnackbar('로그인 실패', e.response!.data['message']);
        return;
      }
      showSnackbar('로그인 실패', '관리자에게 문의해주세요.');
    }
  }
}
