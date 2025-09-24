import 'package:appfactorytest/core/thems/colors.dart';
import 'package:appfactorytest/core/widgets/custom_texts.dart';
import 'package:appfactorytest/feature/home/presentation/screen/dummy_data/users_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonHomeWidget extends StatelessWidget {
  const PersonHomeWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205.h,
      width: 140.w,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5.h,
        children: [
          CircleAvatar(
            radius: 55.r,
            backgroundImage: AssetImage(DummyData.posts[index]["personImage"]),
          ),

          Text16(
            text: DummyData.posts[index]["author"],
            weight: FontWeight.w500,
          ),
          Text16(
            text: DummyData.posts[index]["mail"],
            weight: FontWeight.w400,
            textColor: AppColors.greyFont,
          ),
        ],
      ),
    );
  }
}
