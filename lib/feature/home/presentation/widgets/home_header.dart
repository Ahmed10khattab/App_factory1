import 'package:appfactorytest/core/thems/assets.dart';
import 'package:appfactorytest/core/thems/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.menu, size: 24, color: AppColors.black),
        ),
        Spacer(),
        Text(
          "Connect",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
        ),
        Spacer(),
        SvgPicture.asset(Assets.homeIcon, height: 24.h, width: 24.w),
      ],
    );
  }
}
