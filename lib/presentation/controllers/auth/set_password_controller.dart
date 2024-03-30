import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class SetPasswordController extends GetxController{
  bool _inProgress = false;
  String? _successMessage;
  String? _errorMessage;
  String? _email;
  String? _otp;
  String? _password;

  bool get inProgress => _inProgress;
  String get successMessage => _successMessage ?? 'Password Reset! Please Sign in';
  String get errorMessage => _errorMessage ?? 'Password Reset Failed! Try again';
  String get email => _email ?? '';
  String get otp => _otp ?? '';
  String get password => _password ?? '';

  Future<bool> setPassword (String email, String otp, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "OTP": otp,
      "password": password,
    };

    final response = await NetworkCaller.postRequest(Urls.resetPassword, inputParams);

    if (response.isSuccess) {
      _successMessage = response.errorMessage;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}