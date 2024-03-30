import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/progress_task_controller.dart';
import 'package:task_manager/presentation/widgets/background_wallpaper.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  final ProgressTaskController _progressTaskController = Get.find<ProgressTaskController>();

  @override
  void initState() {
    super.initState();
    _progressTaskController.getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: GetBuilder<ProgressTaskController>(
          builder: (progressTaskController) {
            return Visibility(
              visible: progressTaskController.inProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  _progressTaskController.getProgressTaskList();
                },
                child: Visibility(
                  visible: progressTaskController.progressTaskListWrapper.taskList?.isNotEmpty ?? false,
                  replacement: const EmptyListWidget(),
                  child: ListView.builder(
                    itemCount: progressTaskController.progressTaskListWrapper.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskItem: progressTaskController.progressTaskListWrapper.taskList![index],
                        refreshList: () {
                          _progressTaskController.getProgressTaskList();
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
