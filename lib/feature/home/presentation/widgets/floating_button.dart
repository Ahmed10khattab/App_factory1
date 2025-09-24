import 'package:appfactorytest/core/routing/routes.dart' show Routes;
import 'package:appfactorytest/feature/home/presentation/banner_ad/banner_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
          onPressed:(){
onFabPressed(context);
          } ,
          child: Container(
            height: 56.h,
            width: 64.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Icon(Icons.add),
          ),
        );
  }
   void onFabPressed(context) {
    AdManager.instance.showInterstitial(
      onAdDismissed: () {
        context.pushNamed(Routes.addPost);
      },
    );
  }
}