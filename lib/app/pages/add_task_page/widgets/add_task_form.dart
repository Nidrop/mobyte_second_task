import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobyte_second_task/app/utils/app_theme.dart';
import 'package:mobyte_second_task/domain/sort_status.dart';
import 'package:mobyte_second_task/domain/task.dart';
import 'package:mobyte_second_task/domain/tasks_cubit.dart';
import 'package:mobyte_second_task/domain/tasks_sort_status_cubit.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();

  final _textController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: SizedBox(
        height: 300.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Name',
                  style: textTheme.titleSmall,
                ),
                SizedBox(
                  width: 16.w,
                ),
                SizedBox(
                  width: 240.w,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'write your task here',
                        hintStyle: textTheme.bodyMedium),
                    validator: _validateText,
                    controller: _textController,
                  ),
                ),
              ],
            ),
            //SizedBox(height: 40.h),
            Row(
              children: [
                Text(
                  'Time',
                  style: textTheme.titleSmall,
                ),
                SizedBox(
                  width: 22.w,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppTheme.dateButtonsBackgroundColor,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  onPressed: _showTimePicker,
                  child: Text(
                    '${selectedDate.hour}:${selectedDate.minute}',
                    style: textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            //SizedBox(height: 40.h),
            Row(
              children: [
                Text(
                  'Date',
                  style: textTheme.titleSmall,
                ),
                SizedBox(
                  width: 24.w,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppTheme.dateButtonsBackgroundColor,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  onPressed: _showDatePicker,
                  child: Text(
                    '${selectedDate.day}.${selectedDate.month}.${selectedDate.year}',
                    style: textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            //SizedBox(height: 47.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size.fromHeight(46.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              onPressed: _addTask,
              child: Text(
                'Done',
                style: textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Methods

  String? _validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void _addTask() {
    if (_formKey.currentState!.validate()) {
      Task newTask = Task(title: _textController.text, deadline: selectedDate);
      final TasksCubit tasksCubit = context.read<TasksCubit>();
      tasksCubit.addTask(newTask);
      final TasksSortStatusCubit tasksSortStatusCubit =
          context.read<TasksSortStatusCubit>();
      tasksCubit.sort(tasksSortStatusCubit.state.sortStatus);
      Navigator.pop(context);
    }
  }

  void _showTimePicker() async {
    final time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time == null) {
      return;
    }
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, time.hour, time.minute);
    });
  }

  void _showDatePicker() async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 366)));
    if (date == null) {
      return;
    }
    setState(() {
      selectedDate = DateTime(date.year, date.month, date.day,
          selectedDate.hour, selectedDate.minute);
    });
  }
}
