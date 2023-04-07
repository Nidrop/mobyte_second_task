import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ZeroTasks extends StatelessWidget {
  const ZeroTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 27.w,
        top: 41.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 153.w,
            height: 115.h,
            alignment: Alignment.topLeft,
            child: Text(
              'Looks like there is no tasks yet! Go ahead and push a plus button below',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 30.w,
            ),
            child: SvgPicture.asset(
              'assets/images/arrow.svg',
              width: 232.w,
              height: 404.h,
            ),
          )
        ],
      ),
    );
  }
}
