import 'package:appfactorytest/core/thems/assets.dart';
import 'package:appfactorytest/core/thems/colors.dart';
import 'package:appfactorytest/feature/main_layout/cubit/main_lay_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayOutCubit, MainLayOutState>(
      builder: (context, state) {
        var cubit = MainLayOutCubit.get(context);
        return Container(

          decoration: BoxDecoration(
              color: Colors.transparent,
            border: Border(top: BorderSide(color: AppColors.black,width: .3))),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          height: 70.h,
        
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  cubit.selectNavBarIndex(0);
                },
                child: SvgPicture.asset(
                  Assets.homeNavIcon,
                  height: 30.h,
                  width: 30.w,
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  cubit.selectNavBarIndex(1);
                },
                child: SizedBox(
                  child: SvgPicture.asset(
                    color: AppColors.black,
                    Assets.notificationIcon,
                    height:30.h,
                    width: 30.w,
                  ),
                ),
              ),
               Spacer(),
              InkWell(
                onTap: () {
                  cubit.selectNavBarIndex(2);
                },
                child: SvgPicture.asset(
                  Assets.groupNavIcon,
                  height: 30.h,
                  width: 30.w,
                ),
              ),
             
                 Spacer(),
              SvgPicture.asset(
                  Assets.personNavIcon,
                  height: 30.h,
                  width: 30.w,
                  color: AppColors.black,
              )  
            ],
          ),
        );
      },
    );
  }
}
