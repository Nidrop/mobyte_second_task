import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobyte_second_task/domain/sort_status.dart';
import 'package:mobyte_second_task/domain/task.dart';
import 'package:mobyte_second_task/domain/tasks_sort_status.dart';

class TasksSortStatusCubit extends Cubit<TasksSortStatus> {
  TasksSortStatusCubit() : super(TasksSortStatus());

  void changeSort({
    required Cubit<List<Task>> tasksCubit,
    bool? hideCompleted,
    SortStatus? sortStatus,
  }) {
    if (hideCompleted != null) {
      state.hideCompleted = hideCompleted;
    }
    if (sortStatus != null) {
      state.sortStatus = sortStatus;
    }
    emit(TasksSortStatus(
        hideCompleted: state.hideCompleted, sortStatus: state.sortStatus));
  }
}
