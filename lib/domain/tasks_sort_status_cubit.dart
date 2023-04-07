import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobyte_second_task/domain/sort_status.dart';
import 'package:mobyte_second_task/domain/task.dart';
import 'package:mobyte_second_task/domain/tasks_cubit.dart';
import 'package:mobyte_second_task/domain/tasks_sort_status.dart';

class TasksSortStatusCubit extends Cubit<TasksSortStatus> {
  TasksSortStatusCubit() : super(TasksSortStatus());

  void changeSort({
    required TasksCubit tasksCubit,
    bool? hideCompleted,
    SortStatus? sortStatus,
  }) {
    if (hideCompleted != null) {
      state.hideCompleted = hideCompleted;
      tasksCubit.sortCompleted();
    }
    if (sortStatus != null) {
      state.sortStatus = sortStatus;
      tasksCubit.sort(sortStatus);
    }
    emit(TasksSortStatus(
        hideCompleted: state.hideCompleted, sortStatus: state.sortStatus));
  }
}
