import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';
import 'package:trendify/features/post/domain/repositories/post_repository.dart';

import '../../../user/data/models/user_model.dart';
import '../../data/models/post_model.dart';

class PostUsecase {
  final PostRepository _postRepository;
  const PostUsecase(this._postRepository);

  Future<Either<AppwriteException, List<PostWithUser>>> fetchAllPosts() async {
    return _postRepository.fetchAllPosts();
  }

  Future<UserModel?> fetchAuthor({required String uid}) async {
    return _postRepository.fetchAuthor(uid: uid);
  }

  Future<Either<AppwriteException, void>> likePost({
    required String postId,
    required String uid,
  }) async {
    return _postRepository.likePost(postId: postId, uid: uid);
  }

  Future<Either<AppwriteException, void>> unlikePost({
    required String postId,
    required String uid,
  }) async {
    return _postRepository.unlikePost(postId: postId, uid: uid);
  }

  Future<Either<AppwriteException, void>> repostPost({
    required String postId,
    required String uid,
  }) async {
    return _postRepository.repostPost(postId: postId, uid: uid);
  }

  Future<Either<AppwriteException, void>> unrepostPost({
    required String postId,
    required String uid,
  }) async {
    return _postRepository.unrepostPost(postId: postId, uid: uid);
  }
}
