import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_item.dart';
import 'package:task_manager/presentation/controllers/delete_task_card_controller.dart';
import 'package:task_manager/presentation/controllers/update_task_card_controller.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskItem, required this.refreshList,
  });

  final TaskItem taskItem;
  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late final UpdateTaskCardController _updateTaskCardController = Get.find<UpdateTaskCardController>();
  late final DeleteTaskCardController _deleteTaskCardController = Get.find<DeleteTaskCardController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskItem.title ?? '',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              widget.taskItem.description ?? '',
            ),
            Text("Date: ${widget.taskItem.createdDate}"),
            Row(
              children: [
                Chip(label: Text(widget.taskItem.status ?? '')),
                const Spacer(),
                GetBuilder<UpdateTaskCardController>(
                  builder: (updateTaskCardController) {
                    return Visibility(
                      visible: updateTaskCardController.isInProgress(widget.taskItem.sId!) == false,
                      replacement: const CircularProgressIndicator(),
                      child: IconButton(
                        onPressed: () {
                          _showUpdateStatusDialog(widget.taskItem.sId!);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    );
                  },
                ),
                GetBuilder<DeleteTaskCardController>(
                  builder: (deleteTaskCardController) {
                    return Visibility(
                      visible: deleteTaskCardController
                          .isInProgress(widget.taskItem.sId!) == false,
                      replacement: const CircularProgressIndicator(),
                      child: IconButton(
                        onPressed: () {
                          _deleteTaskById(widget.taskItem.sId!);
                        },
                        icon: const Icon(Icons.delete_outline),
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showUpdateStatusDialog(String id) {
    List<String> statusOptions = ['New', 'Completed', 'Progress', 'Cancelled'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Status'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: statusOptions.map((status) {
                return ListTile(
                  title: Text(status),
                  trailing: _isCurrentStatus(status) ? const Icon(Icons.check) : null,
                  onTap: () {
                    if (_isCurrentStatus(status)) {
                      return;
                    }
                    _updateTaskById(id, status);
                    Get.back();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }


  bool _isCurrentStatus(String status){
    return widget.taskItem.status! == status;
  }

  Future<void> _updateTaskById(String id, String status) async {
    final result = await _updateTaskCardController.updateTaskCard(id, status);
    if(result){
      widget.refreshList();
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, _updateTaskCardController.errorMessage);
      }
    }
  }

  Future<void> _deleteTaskById(String id) async {
    final result = await _deleteTaskCardController.deleteTaskCard(id);
    if(result){
      widget.refreshList();
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, _updateTaskCardController.errorMessage);
      }
    }
  }
}
