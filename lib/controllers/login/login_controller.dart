import 'package:get/get.dart';

class LoginController extends GetxController {
  final RegExp _idReg = RegExp(r"^[ㄱ-ㅎ가-힣A-Z]{2,10}$");
  final RegExp _passwordInputReg = RegExp(r"^[ㄱ-ㅎ가-힣ㅏ-ㅣA-Za-z@$!#?&]{5,}$");

  bool _isValidId = false;
  bool _isEnterdPassword = false;
  bool _isValid = false;
  bool _isSavedId = false;

  bool get isValidId => _isValidId;
  bool get isEnterdPassword => _isEnterdPassword;
  bool get isValid => _isValid;
  bool get isSavedId => _isSavedId;

  void validInputId(String input) {
    _isValidId = _idReg.hasMatch(input);
    _toggleIsValid();
    update();
  }

  void validInputPassword(String input) {
    _isEnterdPassword = _passwordInputReg.hasMatch(input);
    _toggleIsValid();
    update();
  }

  void toggleSavedId(bool? value) {
    _isSavedId = !_isSavedId;
    update();
  }

  void _toggleIsValid() {
    _isValid = _isValidId && isEnterdPassword;
    update();
  }
}
