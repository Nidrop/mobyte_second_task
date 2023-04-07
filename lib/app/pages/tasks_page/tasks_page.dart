import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobyte_second_task/app/pages/add_task_page/add_task_page.dart';
import 'package:mobyte_second_task/app/pages/info_page/info_page.dart';
import 'package:mobyte_second_task/app/pages/tasks_page/widgets/tasks_list_view.dart';
import 'package:mobyte_second_task/app/pages/tasks_page/widgets/zero_tasks.dart';
import 'package:mobyte_second_task/app/utils/app_theme.dart';
import 'package:mobyte_second_task/domain/sort_status.dart';
import 'package:mobyte_second_task/domain/tasks_cubit.dart';
import 'package:mobyte_second_task/domain/tasks_sort_status.dart';
import 'package:mobyte_second_task/domain/tasks_sort_status_cubit.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final tasksSortStatus = context.watch<TasksSortStatusCubit>();

    void sort(int index) {
      tasksSortStatus.changeSort(
          tasksCubit: context.read<TasksCubit>(),
          sortStatus: SortStatus.values.elementAt(index));
    }

    void hideCompleted() {
      tasksSortStatus.changeSort(
          tasksCubit: context.read<TasksCubit>(),
          hideCompleted: !tasksSortStatus.state.hideCompleted);
    }

    void openInfoPage() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const InfoPage()));
    }

    void openAddTaskPage() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => FractionallySizedBox(
          heightFactor: 0.96,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: BlocProvider.of<TasksCubit>(context),
              ),
              BlocProvider.value(
                value: BlocProvider.of<TasksSortStatusCubit>(context),
              ),
            ],
            child: const AddTaskPage(),
          ),
        ),
      );
    }

    final bool listIsEmpty =
        context.select((TasksCubit tc) => tc.state.isEmpty);
    //final bool listIsEmpty = context.watch<TasksCubit>().state.isEmpty;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 27.w,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'My tasks',
          style: textTheme.headlineMedium,
        ),
        actions: [
          TextButton(
            onPressed: hideCompleted,
            child: Text(
              tasksSortStatus.state.hideCompleted
                  ? 'Show completed'
                  : 'Hide completed',
              style: textTheme.labelSmall,
            ),
          )
        ],
      ),
      body: listIsEmpty ? const ZeroTasks() : const TasksListView(),
      //body: const TasksListView(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 32.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 42.h,
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                elevation: 0,
                heroTag: 'infoButton',
                onPressed: openInfoPage,
                child: const Icon(
                  Icons.info_outline,
                  size: AppTheme.iconSize,
                ),
              ),
            ),
            SizedBox(
              height: 42.h,
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                elevation: 0,
                heroTag: 'addTaskButton',
                onPressed: openAddTaskPage,
                child: const Icon(
                  Icons.add,
                  size: AppTheme.iconSize,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/alphabetical_sorting_icon.svg',
                colorFilter: tasksSortStatus.state.sortStatus == SortStatus.alph
                    ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                    : null,
              ),
              label: 'sort alpha'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/alphabetical_sorting_2_icon.svg',
                colorFilter:
                    tasksSortStatus.state.sortStatus == SortStatus.revAlph
                        ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                        : null,
              ),
              label: 'sort reverse alpha'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/alphabetical_sorting_icon.svg',
                colorFilter:
                    tasksSortStatus.state.sortStatus == SortStatus.newest
                        ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                        : null,
              ),
              label: 'sort newest'),
        ],
        currentIndex: tasksSortStatus.state.sortStatus.index,
        onTap: sort,
      ),
    );
  }
}
