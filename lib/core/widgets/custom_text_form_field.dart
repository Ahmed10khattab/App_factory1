import 'package:appfactorytest/core/thems/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
    final int? maxLines;

  final String? Function(String?)? validator;

  const CustomTextFormFeild({
    super.key,
    this.maxLines,
    required this.controller,
    required this.hint,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines??1,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        fillColor: AppColors.grey,
        filled: true,
        hintText: hint, 
        hintStyle:GoogleFonts.plusJakartaSans(fontSize: 16.sp,color: AppColors.greyFont),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
