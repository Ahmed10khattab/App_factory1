
class PostModel {
  final String id;
  final String title;
  final String description;
  final String imageBase64; // الصورة متخزنة Base64
  final int likes;
  final bool isLiked;  

  PostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageBase64,
    required this.likes,
    required this.isLiked,
  });

  
  Map<String, dynamic> toMap({Map<String, dynamic>? likedBy}) {
    return {
      "id": id,
      "title": title,
      "description": description,
      "imageBase64": imageBase64,
      "likes": likes,
      if (likedBy != null)
        "likedBy": likedBy, 
    };
  }

  factory PostModel.fromMap(
    Map<dynamic, dynamic> map,
    String id,
    String userId, 
  ) {
    final likedBy = Map<String, dynamic>.from(map["likedBy"] ?? {});

    return PostModel(
      id: id,
      title: map["title"] ?? '',
      description: map["description"] ?? '',
      imageBase64: map["imageBase64"] ?? '',
      likes: map["likes"] ?? 0,
      isLiked: likedBy.containsKey(userId),  
    );
  }

  PostModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageBase64,
    int? likes,
    bool? isLiked,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageBase64: imageBase64 ?? this.imageBase64,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
