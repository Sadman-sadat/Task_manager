import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class UpdateTaskCardController extends GetxController {
  final Map<String, bool> _inProgressMap = {};

  String? _errorMessage;
  String? _id;
  String? _status;

  String get errorMessage => _errorMessage ?? 'Update task status has failed!';
  String get id => _id ?? '';
  String get status => _status ?? '';

  bool isInProgress(String id) {
    return _inProgressMap[id] ?? false;
  }

  Future<bool> updateTaskCard(String id, String status) async {
    bool isSuccess = false;
    _inProgressMap[id] = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));
    if (response.isSuccess) {
      _id = id;
      _status = status;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgressMap[id] = false;
    update();
    return isSuccess;
  }
}