import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_wrapper.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class CompletedTaskController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  TaskListWrapper _completedTaskListWrapper = TaskListWrapper();

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Get Completed task list has failed!';
  TaskListWrapper get completedTaskListWrapper => _completedTaskListWrapper;

  Future<bool> getCompletedTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.completedTaskList);
    if (response.isSuccess) {
      _completedTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}