import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class DeleteTaskCardController extends GetxController {
  final Map<String, bool> _inProgressMap = {};

  String? _errorMessage;
  String? _id;

  String get errorMessage => _errorMessage ?? 'Delete task status has failed!';
  String get id => _id ?? '';

  bool isInProgress(String id) {
    return _inProgressMap[id] ?? false;
  }

  Future<bool> deleteTaskCard(String id) async {
    bool isSuccess = false;
    _inProgressMap[id] = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.deleteTask(id));
    if (response.isSuccess) {
      _id = id;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgressMap[id] = false;
    update();
    return isSuccess;
  }
}
