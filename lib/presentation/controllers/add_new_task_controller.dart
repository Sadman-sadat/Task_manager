import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class AddNewTaskController extends GetxController{
  bool _inProgress = false;
  String? _successMessage;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get successMessage => _successMessage ?? 'New Task has been added!';
  String get errorMessage => _errorMessage ?? 'Add New Task Failed!';

  Future<bool> addNewTask (String title, String description) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "title": title,
      "description": description,
      "status": "New"
    };

    final response = await NetworkCaller.postRequest(Urls.createTask, inputParams);

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