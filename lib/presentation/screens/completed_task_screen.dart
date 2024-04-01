import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/completed_task_controller.dart';
import 'package:task_manager/presentation/widgets/background_wallpaper.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {

  late final CompletedTaskController _completedTaskController = Get.find<CompletedTaskController>();

  @override
  void initState() {
    super.initState();
    _completedTaskController.getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: GetBuilder<CompletedTaskController>(
          builder: (completedTaskController) {
            return Visibility(
              visible: completedTaskController.inProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  _completedTaskController.getCompletedTaskList();
                },
                child: Visibility(
                  visible: completedTaskController.completedTaskListWrapper.taskList?.isNotEmpty ?? false,
                  replacement: const EmptyListWidget(),
                  child: ListView.builder(
                    itemCount: completedTaskController.completedTaskListWrapper.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskItem: completedTaskController.completedTaskListWrapper.taskList![index],
                        refreshList: () {
                          _completedTaskController.getCompletedTaskList();
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