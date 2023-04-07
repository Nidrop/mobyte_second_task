import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobyte_second_task/domain/task.dart';

class TasksCubit extends Cubit<List<Task>> {
  TasksCubit() : super([]);

  void addTask(Task task) {
    emit([...state, task]);
  }

  void changeTask({
    required int index,
    bool? isCompleted,
    String? title,
    DateTime? deadline,
  }) {
    if (isCompleted != null) {
      state[index].isCompleted = isCompleted;
    }
    if (title != null) {
      state[index].title = title;
    }
    if (deadline != null) {
      state[index].deadline = deadline;
    }
    emit([...state]);
  }
}
