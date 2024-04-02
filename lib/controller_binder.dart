import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/update_profile_controller.dart';
import 'package:task_manager/presentation/controllers/add_new_task_controller.dart';
import 'package:task_manager/presentation/controllers/auth/email_verification_controller.dart';
import 'package:task_manager/presentation/controllers/auth/pin_verification_controller.dart';
import 'package:task_manager/presentation/controllers/auth/set_password_controller.dart';
import 'package:task_manager/presentation/controllers/cancelled_task_controller.dart';
import 'package:task_manager/presentation/controllers/completed_task_controller.dart';
import 'package:task_manager/presentation/controllers/widgets/count_task_by_status_controller.dart';
import 'package:task_manager/presentation/controllers/widgets/delete_task_card_controller.dart';
import 'package:task_manager/presentation/controllers/new_task_controller.dart';
import 'package:task_manager/presentation/controllers/progress_task_controller.dart';
import 'package:task_manager/presentation/controllers/auth/sign_in_controller.dart';
import 'package:task_manager/presentation/controllers/auth/sign_up_controller.dart';
import 'package:task_manager/presentation/controllers/widgets/update_task_card_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    //Get.put(SignUpController());
    Get.lazyPut(() => SignUpController(),fenix: true);
    Get.lazyPut(() => EmailVerificationController(),fenix: true);
    Get.lazyPut(() => PinVerificationController(),fenix: true);
    Get.lazyPut(() => SetPasswordController(),fenix: true);
    Get.lazyPut(() => CountTaskByStatusController(),fenix: true);
    //Get.put(NewTaskController());
    Get.lazyPut(() => NewTaskController(),fenix: true);
    Get.lazyPut(() => ProgressTaskController(),fenix: true);
    Get.lazyPut(() => CompletedTaskController(),fenix: true);
    Get.lazyPut(() => CancelledTaskController(),fenix: true);
    Get.lazyPut(() => AddNewTaskController(),fenix: true);
    Get.lazyPut(() => UpdateTaskCardController(),fenix: true);
    Get.lazyPut(() => DeleteTaskCardController(),fenix: true);
    // Get.put(() => UpdateTaskCardController());
    // Get.put(() => DeleteTaskCardController());
    Get.lazyPut(() => UpdateProfileController(),fenix: true);
  }
}