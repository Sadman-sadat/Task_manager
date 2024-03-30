import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class EmailVerificationController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  String? _email;
  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Email Verification send failed! Try again';
  String get email => _email ?? '';

  Future<bool> emailVerify (String email) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.recoverVerifyEmail(email));
    if (response.isSuccess) {
      if (response.responseBody['status'] == 'success') {
        _email = email;
        isSuccess = true;
      } else {
        _errorMessage = response.errorMessage;
      }
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}