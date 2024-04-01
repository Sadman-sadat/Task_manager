import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/cancelled_task_controller.dart';
import 'package:task_manager/presentation/widgets/background_wallpaper.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  late final CancelledTaskController _cancelledTaskController = Get.find<CancelledTaskController>();

  @override
  void initState() {
    super.initState();
    _cancelledTaskController.getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: GetBuilder<CancelledTaskController>(
          builder: (cancelledTaskController) {
            return Visibility(
              visible: cancelledTaskController.inProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  _cancelledTaskController.getCancelledTaskList();
                },
                child: Visibility(
                  visible: cancelledTaskController.cancelledTaskListWrapper.taskList?.isNotEmpty ?? false,
                  replacement: const EmptyListWidget(),
                  child: ListView.builder(
                    itemCount: cancelledTaskController.cancelledTaskListWrapper.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskItem: cancelledTaskController.cancelledTaskListWrapper.taskList![index],
                        refreshList: () {
                          _cancelledTaskController.getCancelledTaskList();
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
