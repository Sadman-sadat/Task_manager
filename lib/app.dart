import 'package:flutter/material.dart';
import 'package:task_manager/controller_binder.dart';
import 'package:task_manager/presentation/screens/splash_screen.dart';
import 'package:task_manager/presentation/utility/app_theme.dart';
import 'package:get/get.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManager.navigatorKey,
      title: 'Task Manager',
      theme: appThemeData(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}

