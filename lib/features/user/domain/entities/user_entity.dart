import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? username;
  final String? email;
  final String? fullName;
  final List<String>? followers;
  final List<String>? following;
  final String? profilePicture;
  final String? bio;
  final bool? isVerified;

  const UserEntity({
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

  @override
  List<Object?> get props => [
        uid,
        username,
        email,
        fullName,
        followers,
        following,
        profilePicture,
        bio,
        isVerified,
      ];
}
