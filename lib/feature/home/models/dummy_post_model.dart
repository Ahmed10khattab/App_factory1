class DummyPostModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int likes;
  final String author;
  final String mail;
  final String personImage;

  DummyPostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.likes,
    required this.author,
    required this.mail,
    required this.personImage,
  });

  factory DummyPostModel.fromJson(Map<String, dynamic> json) {
    return DummyPostModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      imageUrl: json["imageUrl"],
      likes: json["likes"],
      author: json["author"],
      mail: json["mail"],
      personImage: json["personImage"],
    );
  }

  
}
