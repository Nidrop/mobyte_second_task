import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobyte_second_task/app/utils/app_theme.dart';
import 'package:mobyte_second_task/domain/task.dart';
import 'package:mobyte_second_task/domain/tasks_cubit.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
    this.index, {
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    //final task = context.select((TasksCubit tc) => tc.state[widget.index]);
    final task = context.watch<TasksCubit>().state[index];

    void onChanged(bool? val) {
      if (val == null) {
        return;
      }
      context.read<TasksCubit>().changeTask(index: index, isCompleted: val);
    }

    void onTap() {
      onChanged(!task.isCompleted);
    }

    return ListTile(
      horizontalTitleGap: 0,
      leading: Checkbox(
        activeColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
        side: MaterialStateBorderSide.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return BorderSide(color: Colors.black);
            }
            return BorderSide(color: Colors.grey);
          },
        ),
        value: task.isCompleted,
        onChanged: onChanged,
      ),
      title: Text(
        task.title,
        style: task.isCompleted
            ? textTheme.bodyMedium!.copyWith(
                decoration: TextDecoration.lineThrough,
                color: AppTheme.bodyMediumColor.withOpacity(0.3))
            : textTheme.bodyMedium,
      ),
      subtitle: Text(
        '${task.deadline.day}.${task.deadline.month}.${task.deadline.year} ${task.deadline.hour}:${task.deadline.minute}',
        style: task.isCompleted
            ? textTheme.bodySmall!.copyWith(
                decoration: TextDecoration.lineThrough,
                color: AppTheme.bodySmallColor.withOpacity(0.3))
            : textTheme.bodySmall,
      ),
      onTap: onTap,
    );
    /*
    return Row(
      children: [
        Flexible(
          child: Checkbox(
            activeColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
            side: MaterialStateBorderSide.resolveWith(
              (states) {
                if (states.contains(MaterialState.selected)) {
                  return BorderSide(color: Colors.black);
                }
                return BorderSide(color: Colors.grey);
              },
            ),
            value: isCompleted,
            onChanged: (val) {},
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.bodyMedium,
              ),
              Text(
                '${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute}',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        )
      ],
    );
    */
  }
}
