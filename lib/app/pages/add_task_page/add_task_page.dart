import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobyte_second_task/app/pages/add_task_page/widgets/add_task_form.dart';
import 'package:mobyte_second_task/app/utils/app_theme.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    void close() {
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.addTaskAppBarColor,
        foregroundColor: Colors.black,
        elevation: 1,
        centerTitle: true,
        leadingWidth: 100.w,
        leading: TextButton(
          onPressed: close,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.chevron_left,
                size: AppTheme.iconSize,
              ),
              Text(
                'Close',
                style: textTheme.labelLarge,
              ),
            ],
          ),
        ),
        title: Text(
          'Task',
          style: textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add a task',
              style: textTheme.headlineMedium,
            ),
            SizedBox(
              height: 30.h,
            ),
            const AddTaskForm(),
          ],
        ),
      ),
    );
  }
}
