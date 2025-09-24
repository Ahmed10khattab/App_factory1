import 'dart:convert';
import 'dart:io';

import 'package:appfactorytest/core/helpers/extentions.dart';
import 'package:appfactorytest/core/thems/colors.dart';
import 'package:appfactorytest/core/widgets/custom_button.dart';
import 'package:appfactorytest/core/widgets/custom_text_form_field.dart';
import 'package:appfactorytest/core/widgets/custom_texts.dart';
import 'package:appfactorytest/feature/home/cubit/posts_cubit.dart';
import 'package:appfactorytest/feature/home/models/post_model.dart';
import 'package:appfactorytest/feature/home/repo/posts_repo.dart';
import 'package:dotted_border/dotted_border.dart' show DottedBorder;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleCnt = TextEditingController();
  final TextEditingController descriptionCnt = TextEditingController();
  String? imageBase64;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70.h,
          title: Text18(text: "Create post", weight: FontWeight.w700),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 20),
                CustomTextFormFeild(
                  controller: titleCnt,
                  hint: "Tilte",
                  validator: (val) => val!.isEmpty ? "enter Tilte" : null,
                ),
                SizedBox(height: 15),
                CustomTextFormFeild(
                  validator: (val) => val!.isEmpty ? "enter description" : null,
                  controller: descriptionCnt,
                  hint: "description",
                  maxLines: 6,
                ),
                SizedBox(height: 20),
                _uploadImageBox(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _addPostButton(),
      ),
    );
  }

  Widget _uploadImageBox() {
    return Center(
      child: DottedBorder(
        child: Container(
          height: 300.h,

          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            color: Colors.transparent,
          ),
          child: Center(
            child: imageBase64 != null
                ? ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(10.r),
                    child: Image.memory(
                      base64Decode(imageBase64!),
                      height: 300.h,
                      // cacheWidth: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text18(text: "Upoad Image", weight: FontWeight.bold),
                      Text14(text: "Darg and drop or click to upload "),
                      MaterialButton(
                        onPressed: () async {
                          final picked = await pickImageAsBase64();
                          if (picked != null) {
                            setState(() {
                              imageBase64 = picked;
                            });
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(24),
                        ),
                        color: AppColors.grey,
                        child: Text14(text: "Upload", weight: FontWeight.bold),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _addPostButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: BlocProvider(
        create: (context) => PostCubit(PostRepository()),
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            return CustomButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  var cubit = PostCubit.get(context);
                  if (titleCnt.text.isNotEmpty &&
                      descriptionCnt.text.isNotEmpty &&
                      imageBase64 != null) {
                    final post = PostModel(
                      id: const Uuid().v4(),
                      title: titleCnt.text,
                      description: descriptionCnt.text,
                      imageBase64: imageBase64!,
                      likes: 0,
                      isLiked: false,
                    );

                    await cubit.addPost(post, context);
                    context.pop();
                  }
                }
              },
              text: "Publish",
              color: AppColors.blue,
              borderRadius: 24,
            );
          },
        ),
      ),
    );
  }

  Future<String?> pickImageAsBase64() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await File(pickedFile.path).readAsBytes();
      return base64Encode(bytes);
    }
    return null;
  }
}
