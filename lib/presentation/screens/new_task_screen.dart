import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_count_by_status_data.dart';
import 'package:task_manager/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager/presentation/controllers/new_task_controller.dart';
import 'package:task_manager/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager/presentation/utility/app_colors.dart';
import 'package:task_manager/presentation/widgets/background_wallpaper.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';
import 'package:task_manager/presentation/widgets/task_counter_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  late final CountTaskByStatusController countTaskByStatusController = Get.find<CountTaskByStatusController>();
  late final NewTaskController newTaskController= Get.find<NewTaskController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    _getDataFromApi();
    });
    _getDataFromApi();
    super.initState();
  }

  void _getDataFromApi() {
    countTaskByStatusController.getCountTaskByStatus();
    newTaskController.getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Column(
          children: [
            GetBuilder<CountTaskByStatusController>(
              builder: (countTaskByStatusController) {
                return Visibility(
                    visible: countTaskByStatusController.inProgress == false,
                    replacement: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(),
                    ),
                    child: taskCounterSection(countTaskByStatusController.countByStatusWrapper.listOfTaskByStatusData ?? []));
              }
            ),
            Expanded(
              child: GetBuilder<NewTaskController>(
                builder: (newTaskController) {
                  return Visibility(
                    visible: newTaskController.inProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        _getDataFromApi();
                      },
                      child: Visibility(
                        visible: newTaskController.newTaskListWrapper.taskList?.isNotEmpty ?? false,
                        replacement: const EmptyListWidget(),
                        child: ListView.builder(
                          itemCount: newTaskController.newTaskListWrapper.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              key: UniqueKey(),
                              taskItem: newTaskController.newTaskListWrapper.taskList![index],
                              refreshList: () {
                                _getDataFromApi();
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.to(()=>const AddNewTaskScreen());
          if (result != null && result == true){
            _getDataFromApi();
          }
        },
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget taskCounterSection(List<TaskCountByStatusData> listOfTaskCountByStatus) {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: listOfTaskCountByStatus.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TaskCounterCard(
              amount: listOfTaskCountByStatus[index].sum ?? 0,
              title: listOfTaskCountByStatus[index].sId ?? '',
            );
          },
          separatorBuilder: (_, __) {
            return const SizedBox(width: 8);
          },
        ),
      ),
    );
  }
}
