import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/models/user_data.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';

class UpdateProfileController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Update profile failed! Try again';

  Future<bool> updateProfile (String email, String firstName, String lastName, String mobile, String? password, XFile? photoFile) async{
    bool isSuccess = false;
    String? photoPath;
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if(password?.isNotEmpty ?? false){
      inputParams['password'] = password;
    }

    if (photoFile != null) {
      List<int> bytes = await photoFile.readAsBytes();
      photoPath = base64Encode(bytes);
      inputParams['photo'] = photoPath;
    }

    final response = await NetworkCaller.postRequest(Urls.updateProfile, inputParams);

    if(response.isSuccess){
      if(response.responseBody['status'] == 'success'){
        UserData userData = UserData(
          email: inputParams['email'],
          firstName: inputParams['firstName'],
          lastName: inputParams['lastName'],
          mobile: inputParams['mobile'],
          photo: inputParams['photo'],
          //photo: photoPath,
        );
        await AuthController.saveUserData(userData);
      }
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}