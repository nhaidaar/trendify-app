import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';
import 'package:trendify/features/user/data/models/user_model.dart';

import '../../data/models/post_model.dart';

abstract class PostRepository {
  Future<Either<AppwriteException, List<PostWithUser>>> fetchAllPosts();

  Future<UserModel?> fetchAuthor({required String uid});

  Future<Either<AppwriteException, void>> makePost({required PostModel post});

  Future<Either<AppwriteException, void>> likePost({
    required String postId,
    required String uid,
  });

  Future<Either<AppwriteException, void>> unlikePost({
    required String postId,
    required String uid,
  });

  Future<Either<AppwriteException, void>> repostPost({
    required String postId,
    required String uid,
  });

  Future<Either<AppwriteException, void>> unrepostPost({
    required String postId,
    required String uid,
  });
}
