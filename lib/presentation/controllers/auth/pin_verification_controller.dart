import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class PinVerificationController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  String? _email;
  String? _otp;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'OTP verification failed! Try again';
  String get email => _email ?? '';
  String get otp => _otp ?? '';

  Future<bool> pinVerify (String email, String otp) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.recoverOTPVerify(email, otp));
    if(response.isSuccess){
      _email = email;
      _otp = otp;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}