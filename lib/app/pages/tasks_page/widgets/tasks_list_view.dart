import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobyte_second_task/app/pages/tasks_page/widgets/task_item.dart';
import 'package:mobyte_second_task/domain/task.dart';
import 'package:mobyte_second_task/domain/tasks_cubit.dart';
import 'package:mobyte_second_task/domain/tasks_sort_status.dart';
import 'package:mobyte_second_task/domain/tasks_sort_status_cubit.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({super.key});

  @override
  Widget build(BuildContext context) {
    //final int length = context.select((TasksCubit tc) => tc.state.length);
    final tasksCubit = context.watch<TasksCubit>();
    // final tasksSortStatusCubit = context.watch<TasksSortStatusCubit>();
    // int completedCount = 0;
    // tasksCubit.state.forEach((element) {
    //   if(element.isCompleted){
    //     completedCount++;
    //   }
    // });

    return ListView.builder(
      itemCount: tasksCubit.state.length,
      itemBuilder: (BuildContext context, int index) {
        return TaskItem(index);
      },
    );
  }
}
