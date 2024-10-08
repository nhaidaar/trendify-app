import '../../../user/data/models/user_model.dart';

class PostModel {
  final String? postId;
  final String? uid;
  final String? repliedTo;
  final String? text;
  final DateTime? createdAt;
  final List<String>? images;
  final List<String>? likes;
  final List<String>? replies;
  final List<String>? reposts;

  const PostModel({
    this.postId,
    this.uid,
    this.repliedTo,
    this.text,
    this.createdAt,
    this.images,
    this.likes,
    this.replies,
    this.reposts,
  });

  PostModel copyWith({
    String? postId,
    String? uid,
    String? repliedTo,
    String? text,
    DateTime? createdAt,
    List<String>? images,
    List<String>? likes,
    List<String>? replies,
    List<String>? reposts,
  }) {
    return PostModel(
      postId: postId ?? this.postId,
      uid: uid ?? this.uid,
      repliedTo: repliedTo ?? this.repliedTo,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      images: images ?? this.images,
      likes: likes ?? this.likes,
      replies: replies ?? this.replies,
      reposts: reposts ?? this.reposts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'repliedTo': repliedTo,
      'text': text,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'images': images,
      'likes': likes,
      'reposts': reposts,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postId: map['\$id'] ?? '',
      uid: map['uid'] ?? '',
      repliedTo: map['repliedTo'] ?? '',
      text: map['text'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      images: List<String>.from(map['images'] ?? []),
      likes: List<String>.from(map['likes'] ?? []),
      replies: List<String>.from(map['replies'] ?? []),
      reposts: List<String>.from(map['reposts'] ?? []),
    );
  }
}

class PostWithUser {
  final PostModel post;
  final UserModel? user;

  PostWithUser({required this.post, this.user});
}
