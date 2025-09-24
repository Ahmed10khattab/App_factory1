import 'package:appfactorytest/core/cache_helper/cache_helper.dart';
import 'package:appfactorytest/core/cache_helper/cache_values.dart';
import 'package:appfactorytest/feature/home/models/post_model.dart';
import 'package:firebase_database/firebase_database.dart';

class PostRepository {
  final DatabaseReference _postsRef = FirebaseDatabase.instance.ref().child(
    "posts",
  );

  /// إضافة بوست جديد
  Future<void> addPost(PostModel post) async {
    await _postsRef.child(post.id).set(post.toMap());
  }

  Future<List<PostModel>> getPosts() async {
    var userId = CacheHelper.getData(key:CacheKeys.userId);

    final snapshot = await _postsRef.get();
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);

      return data.entries.map((entry) {
        return PostModel.fromMap(
          Map<String, dynamic>.from(entry.value),
          entry.key,
          userId,
        );
      }).toList();
    }
    return [];
  } 

  Future<PostModel?> toggleLike(PostModel post) async {
    try {
      final postRef = _postsRef.child(post.id);
      final userId = CacheHelper.getData(key: "userId");

      if (userId == null) {
        print("Error: User ID is null");
        return null;
      }

      final snapshot = await postRef.get();
      if (!snapshot.exists) {
        print("Error: Post does not exist");
        return null;
      }

      final data = Map<String, dynamic>.from(snapshot.value as Map);
      int likes = data['likes'] ?? 0;
      Map<String, dynamic> likedBy = Map<String, dynamic>.from(
        data['likedBy'] ?? {},
      );

      bool isLikedNow;

      if (likedBy.containsKey(userId)) {
        // المستخدم عامل لايك قبل كده → شيل اللايك
        likes = (likes > 0) ? likes - 1 : 0;
        likedBy.remove(userId);
        isLikedNow = false;
      } else {
        // المستخدم يعمل لايك لأول مرة
        likes += 1;
        likedBy[userId] = true;
        isLikedNow = true;
      }

      // تحديث DB
      await postRef.update({
        "likes": likes,
        "likedBy": likedBy,
        "isLiked": isLikedNow,
      });

      // رجع نسخة جديدة محدثة مع isLiked محسوبة
      return post.copyWith(likes: likes, isLiked: isLikedNow);
    } catch (e) {
      print("Error in toggleLike: $e");
      return null;
    }
  }
}
