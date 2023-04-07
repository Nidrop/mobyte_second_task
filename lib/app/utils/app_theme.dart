import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static const bodySmallColor = Color(0xffa3a3a3);
  static const bodyMediumColor = Color(0xff737373);
  static const addTaskAppBarColor = Color(0xfff9f9f9);
  static const dateButtonsBackgroundColor = Color(0x1f767680);

  static const double iconSize = 32;

  static final mainTheme = ThemeData(
    primaryTextTheme: Typography.englishLike2021,
    fontFamily: 'OpenSans',
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 34.sp,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 17.sp,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 22.sp,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20.sp,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 17.sp,
        color: Colors.blue,
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
        color: Colors.blue,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15.sp,
        color: bodyMediumColor,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13.sp,
        fontStyle: FontStyle.italic,
        color: bodySmallColor,
      ),
    ),
  );
}
