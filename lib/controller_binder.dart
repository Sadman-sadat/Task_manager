import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/UpdateProfileController.dart';
import 'package:task_manager/presentation/controllers/add_new_task_controller.dart';
import 'package:task_manager/presentation/controllers/auth/email_verification_controller.dart';
import 'package:task_manager/presentation/controllers/auth/pin_verification_controller.dart';
import 'package:task_manager/presentation/controllers/auth/set_password_controller.dart';
import 'package:task_manager/presentation/controllers/cancelled_task_controller.dart';
import 'package:task_manager/presentation/controllers/completed_task_controller.dart';
import 'package:task_manager/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager/presentation/controllers/new_task_controller.dart';
import 'package:task_manager/presentation/controllers/progress_task_controller.dart';
import 'package:task_manager/presentation/controllers/auth/sign_in_controller.dart';
import 'package:task_manager/presentation/controllers/auth/sign_up_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => EmailVerificationController());
    Get.lazyPut(() => PinVerificationController());
    Get.lazyPut(() => SetPasswordController());
    Get.lazyPut(() => CountTaskByStatusController());
    Get.lazyPut(() => NewTaskController());
    Get.lazyPut(() => ProgressTaskController());
    Get.lazyPut(() => CompletedTaskController());
    Get.lazyPut(() => CancelledTaskController());
    Get.lazyPut(() => AddNewTaskController());
    Get.lazyPut(() => UpdateProfileController());
  }
}