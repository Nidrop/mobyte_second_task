import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobyte_second_task/app/pages/tasks_page/widgets/task_item.dart';
import 'package:mobyte_second_task/app/pages/tasks_page/widgets/zero_tasks.dart';
import 'package:mobyte_second_task/domain/sort_status.dart';
import 'package:mobyte_second_task/domain/task.dart';
import 'package:mobyte_second_task/domain/tasks_cubit.dart';
import 'package:mobyte_second_task/domain/tasks_sort_status.dart';
import 'package:mobyte_second_task/domain/tasks_sort_status_cubit.dart';
import 'package:mobyte_second_task/main.dart';

class TasksListView extends StatefulWidget {
  const TasksListView({super.key});

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  bool isRecieved = false;
  late Future<List<Task>> recievedData;

  @override
  void initState() {
    super.initState();
    recievedData = database.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    //final int length = context.select((TasksCubit tc) => tc.state.length);
    final tasksCubit = context.watch<TasksCubit>();
    final tasksSortStatusCubit = context.watch<TasksSortStatusCubit>();
    int completedCount = 0;
    for (var element in tasksCubit.state) {
      if (element.isCompleted) {
        completedCount++;
      }
    }

    return FutureBuilder<List<Task>>(
      future: recievedData,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          if (isRecieved == false) {
            final tc = context.read<TasksCubit>();
            tc.setList(snapshot.data);
            tc.sort(SortStatus.alph);
            tc.sortCompleted();
            isRecieved = true;
          }
          if (tasksCubit.state.isNotEmpty) {
            return ListView.builder(
              itemCount: tasksSortStatusCubit.state.hideCompleted
                  ? tasksCubit.state.length - completedCount
                  : tasksCubit.state.length,
              itemBuilder: (BuildContext context, int index) {
                return TaskItem(index);
              },
            );
          } else {
            return const ZeroTasks();
          }
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('error getting data from local db'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
