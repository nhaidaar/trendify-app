import 'package:flutter/foundation.dart';
import 'package:trendify/features/user/domain/entities/user_entity.dart';

@immutable
class UserModel {
  final String? uid;
  final String? username;
  final String? email;
  final String? fullName;
  final List<String>? followers;
  final List<String>? following;
  final String? profilePicture;
  final String? bio;
  final bool? isVerified;

  const UserModel({
    this.uid,
    this.username,
    this.email,
    this.fullName,
    this.followers,
    this.following,
    this.profilePicture,
    this.bio,
    this.isVerified,
  });

  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
    String? fullName,
    List<String>? followers,
    List<String>? following,
    String? profilePicture,
    String? bio,
    bool? isVerified,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'fullName': fullName,
      'followers': followers,
      'following': following,
      'profilePicture': profilePicture,
      'bio': bio,
      'isVerified': isVerified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['\$id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      fullName: map['fullName'] ?? '',
      followers: List<String>.from(map['followers']),
      following: List<String>.from(map['following']),
      profilePicture: map['profilePicture'] ?? '',
      bio: map['bio'] ?? '',
      isVerified: map['isVerified'] ?? false,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, username: $username, email: $email, fullName: $fullName, followers: $followers, following: $following, profilePicture: $profilePicture, bio: $bio, isVerified: $isVerified)';
  }

  UserEntity toEntity() => UserEntity(
        uid: uid,
        username: username,
        email: email,
        fullName: fullName,
        followers: followers,
        following: following,
        profilePicture: profilePicture,
        bio: bio,
        isVerified: isVerified,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.username == username &&
        other.email == email &&
        other.fullName == fullName &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following) &&
        other.profilePicture == profilePicture &&
        other.bio == bio &&
        other.isVerified == isVerified;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        username.hashCode ^
        email.hashCode ^
        fullName.hashCode ^
        followers.hashCode ^
        following.hashCode ^
        profilePicture.hashCode ^
        bio.hashCode ^
        isVerified.hashCode;
  }
}
