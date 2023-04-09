import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobyte_second_task/domain/sort_status.dart';
import 'package:mobyte_second_task/domain/task.dart';
import 'package:mobyte_second_task/main.dart';

class TasksCubit extends Cubit<List<Task>> {
  TasksCubit() : super([]);

  void setList(List<Task>? list) {
    if (list == null) {
      emit([Task(title: 'error: smth bad happened', deadline: DateTime.now())]);
    } else {
      emit(list);
    }
  }

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

  void sortCompleted() {
    state.sort((a, b) {
      if (!b.isCompleted) {
        return 1;
      }
      return -1;
    });

    emit([...state]);
  }

  void sort(SortStatus sortStatus) {
    switch (sortStatus) {
      case SortStatus.alph:
        state.sort((b, a) => a.title.compareTo(b.title));
        break;
      case SortStatus.revAlph:
        state.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortStatus.newest:
        state.sort((b, a) => a.deadline.compareTo(b.deadline));
        break;
    }
    sortCompleted();
    emit([...state]);
  }
}
