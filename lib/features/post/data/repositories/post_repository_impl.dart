// ignore_for_file: void_checks

import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:trendify/features/post/domain/repositories/post_repository.dart';
import 'package:trendify/features/user/data/models/user_model.dart';

import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final Client client;
  const PostRepositoryImpl({required this.client});

  @override
  Future<Either<AppwriteException, List<PostWithUser>>> fetchAllPosts() async {
    try {
      final response = await Databases(client).listDocuments(
        databaseId: dotenv.get("DATABASE_ID"),
        collectionId: dotenv.get("COLLECTION_TWEETS_ID"),
        queries: [Query.isNull("repliedTo")],
      );

      List<PostWithUser> posts = await Future.wait(response.documents.map(
        (rawPost) async {
          // JSON to Model
          final post = PostModel.fromMap(rawPost.data);

          // Get All Comments
          final fetchComments = await Databases(client).listDocuments(
            databaseId: dotenv.get("DATABASE_ID"),
            collectionId: dotenv.get("COLLECTION_TWEETS_ID"),
            queries: [Query.equal("repliedTo", post.postId)],
          );
          final comments = fetchComments.documents.map((doc) {
            final postOfComment = PostModel.fromMap(doc.data);
            return postOfComment.postId.toString();
          }).toList();
          final newPost = post.copyWith(
            comments: comments,
          );

          // Fetch Author Details
          final user = await fetchAuthor(uid: post.uid.toString());

          // Return PostModel and UserModel (in PostWithUser)
          return PostWithUser(post: newPost, user: user);
        },
      ));

      return Right(posts);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<UserModel?> fetchAuthor({required String uid}) async {
    try {
      final user = await Databases(client).getDocument(
        databaseId: dotenv.get("DATABASE_ID"),
        collectionId: dotenv.get("COLLECTION_USERS_ID"),
        documentId: uid,
      );

      return UserModel.fromMap(user.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Either<AppwriteException, void>> likePost({
    required String postId,
    required String uid,
  }) async {
    try {
      final document = await Databases(client).getDocument(
        databaseId: dotenv.get("DATABASE_ID"),
        collectionId: dotenv.get("COLLECTION_TWEETS_ID"),
        documentId: postId,
      );

      List<String> currentLikes = List<String>.from(document.data['likes'] ?? []);

      if (!currentLikes.contains(uid)) {
        currentLikes.add(uid);

        await Databases(client).updateDocument(
          databaseId: dotenv.get("DATABASE_ID"),
          collectionId: dotenv.get("COLLECTION_TWEETS_ID"),
          documentId: postId,
          data: {'likes': currentLikes},
        );
      }
      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, void>> unlikePost({
    required String postId,
    required String uid,
  }) async {
    try {
      final document = await Databases(client).getDocument(
        databaseId: dotenv.get("DATABASE_ID"),
        collectionId: dotenv.get("COLLECTION_TWEETS_ID"),
        documentId: postId,
      );

      List<String> currentLikes = List<String>.from(document.data['likes'] ?? []);

      if (currentLikes.contains(uid)) {
        currentLikes.remove(uid);

        await Databases(client).updateDocument(
          databaseId: dotenv.get("DATABASE_ID"),
          collectionId: dotenv.get("COLLECTION_TWEETS_ID"),
          documentId: postId,
          data: {'likes': currentLikes},
        );
      }
      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, void>> repostPost({
    required String postId,
    required String uid,
  }) async {
    try {
      final document = await Databases(client).getDocument(
        databaseId: dotenv.get("DATABASE_ID"),
        collectionId: dotenv.get("COLLECTION_TWEETS_ID"),
        documentId: postId,
      );

      List<String> currentReposts = List<String>.from(document.data['reposts'] ?? []);

      if (!currentReposts.contains(uid)) {
        currentReposts.add(uid);

        await Databases(client).updateDocument(
          databaseId: dotenv.get("DATABASE_ID"),
          collectionId: dotenv.get("COLLECTION_TWEETS_ID"),
          documentId: postId,
          data: {'reposts': currentReposts},
        );
      }
      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, void>> unrepostPost({
    required String postId,
    required String uid,
  }) async {
    try {
      final document = await Databases(client).getDocument(
        databaseId: dotenv.get("DATABASE_ID"),
        collectionId: dotenv.get("COLLECTION_TWEETS_ID"),
        documentId: postId,
      );

      List<String> currentReposts = List<String>.from(document.data['reposts'] ?? []);

      if (currentReposts.contains(uid)) {
        currentReposts.remove(uid);

        await Databases(client).updateDocument(
          databaseId: dotenv.get("DATABASE_ID"),
          collectionId: dotenv.get("COLLECTION_TWEETS_ID"),
          documentId: postId,
          data: {'reposts': currentReposts},
        );
      }
      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }
}
