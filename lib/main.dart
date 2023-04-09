import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobyte_second_task/app/pages/tasks_page/tasks_page.dart';
import 'package:mobyte_second_task/app/utils/app_theme.dart';
import 'package:mobyte_second_task/data/todos_database.dart';
import 'package:mobyte_second_task/domain/tasks_cubit.dart';
import 'package:mobyte_second_task/domain/tasks_sort_status_cubit.dart';

//😨
final database = TodosDatabase();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Second Task',
            theme: AppTheme.mainTheme,
            home: MultiBlocProvider(
              providers: [
                BlocProvider<TasksCubit>(
                  // lazy: false,
                  create: (context) => TasksCubit(),
                ),
                BlocProvider<TasksSortStatusCubit>(
                  // lazy: false,
                  create: (context) => TasksSortStatusCubit(),
                ),
              ],
              child: const TasksPage(),
            ),
          );
        });
  }
}
