import 'package:get/get.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;
  String? _successMessage;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get successMessage => _successMessage ?? 'Registration Completed! Please Sign in';
  String get errorMessage => _errorMessage ?? 'Registration Failed! Try again';

  Future<bool> signUp (String email, String firstName, String lastName, String mobile, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };

    final ResponseObject response = await NetworkCaller.postRequest(Urls.registration, inputParams);

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