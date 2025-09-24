import 'dart:convert';

import 'package:appfactorytest/core/thems/colors.dart';
import 'package:appfactorytest/core/widgets/custom_texts.dart';
import 'package:appfactorytest/feature/home/models/post_model.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key, required this.post});
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text18(text: post.title), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Image.memory(
          base64Decode(post.imageBase64),
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
            SizedBox(height: 16.h),

            Text14(text: post.description, textColor: AppColors.greyFont),

            SizedBox(height: 16.h),

            Row(
              children: [
                const Icon(Icons.favorite, color: Colors.red),
                SizedBox(width: 6.w),
                Text("${post.likes} likes", style: TextStyle(fontSize: 16.sp)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
