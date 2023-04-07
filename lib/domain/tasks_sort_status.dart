import 'package:mobyte_second_task/domain/sort_status.dart';

class TasksSortStatus {
  TasksSortStatus(
      {this.hideCompleted = false, this.sortStatus = SortStatus.alph});

  bool hideCompleted;
  SortStatus sortStatus;
}
