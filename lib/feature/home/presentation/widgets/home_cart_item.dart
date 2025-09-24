


import 'dart:convert';

import 'package:appfactorytest/core/cache_helper/cache_helper.dart';
import 'package:appfactorytest/core/thems/colors.dart';
import 'package:appfactorytest/core/widgets/custom_texts.dart';
import 'package:appfactorytest/feature/home/models/post_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class HomeCartItem extends StatefulWidget {
  HomeCartItem({super.key, required this.post});
  PostModel post;

  @override
  State<HomeCartItem> createState() => _HomeCartItemState();
}

class _HomeCartItemState extends State<HomeCartItem>
    with SingleTickerProviderStateMixin {
  bool isFavourite = false;
  late int likesCount;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  final DatabaseReference _postsRef =
      FirebaseDatabase.instance.ref().child("posts");

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    likesCount = widget.post.likes;
    isFavourite = widget.post.isLiked;

    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  Future<void> toggleFavourite() async {
    final updatedPost = await toggleLike(widget.post);

    if (updatedPost == null) return;

    setState(() {
      widget.post = updatedPost;
      likesCount = updatedPost.likes;
      isFavourite = updatedPost.isLiked;
    });

    _controller.forward(from: 0).then((_) => _controller.reverse());
  }

  Future<PostModel?> toggleLike(PostModel post) async {
    try {
      final postRef = _postsRef.child(post.id);
      var userId = CacheHelper.getData(key: "userId");

      if (userId == null) return null;

      final snapshot = await postRef.get();
      if (!snapshot.exists) return null;

      final data = Map<String, dynamic>.from(snapshot.value as Map);

      int likes = data['likes'] ?? 0;
      Map<String, dynamic> likedBy =
          Map<String, dynamic>.from(data['likedBy'] ?? {});

      bool isLikedNow;

      if (likedBy.containsKey(userId) && likedBy[userId] == true) {
        likes--;
        likedBy.remove(userId);
        isLikedNow = false;
      } else {
        likes++;
        likedBy[userId] = true;
        isLikedNow = true;
      }

      await postRef.update({
        "likes": likes,
        "likedBy": likedBy,
      });

      return post.copyWith(
        likes: likes,
        isLiked: isLikedNow,
      );
    } catch (e) {
      print("Error in toggleLike: $e");
      return null;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        //height: 400.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.memory(
                
                base64Decode(widget.post.imageBase64),
                gaplessPlayback: true,
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
                
              ),
            ),
      
            SizedBox(height: 8.h),
      
            Text18(
              text: widget.post.title,
              weight: FontWeight.bold,
              alignment: TextAlign.start,
            ),
      
            SizedBox(height: 4.h),
      
            Text16(
              text: widget.post.description,
              weight: FontWeight.w400,
              textColor: AppColors.greyFont,
              alignment: TextAlign.start,
            ),
      
            SizedBox(height: 4.h),
      
            Text12(
              text: "$likesCount likes",
              textColor: AppColors.greyFont,
            ),
      
            SizedBox(height: 8.h),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: IconButton(
                    onPressed: toggleFavourite,
                    icon: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: isFavourite ? Colors.red : Colors.grey,
                      size: 40,
                    ),
                  ),
                ),
                Text14(
                    text: "Like", textColor: AppColors.greyFont),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
