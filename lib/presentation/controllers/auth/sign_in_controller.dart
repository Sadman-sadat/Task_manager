import 'package:get/get.dart';
import 'package:task_manager/data/models/login_response.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';

class SignInController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Sign In Failed! Try again';

  Future<bool> signIn (String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> inoutParams = {
      "email": email,
      "password": password,
    };

    final ResponseObject response = await NetworkCaller.postRequest(Urls.login, inoutParams, fromSignIn: true);

    if (response.isSuccess) {
      LoginResponse loginResponse = LoginResponse.fromJson(response.responseBody);

      await AuthController.saveUserData(loginResponse.userData!);
      await AuthController.saveUserToken(loginResponse.token!);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}