import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:trendify/features/home/domain/repositories/home_repository.dart';
import 'package:trendify/features/post/data/models/post_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final Client client;
  const HomeRepositoryImpl({required this.client});

  @override
  Future<Either<AppwriteException, List<PostModel>>> fetchAllPosts() async {
    try {
      final response = await Databases(client).listDocuments(
        databaseId: dotenv.get("DATABASE_ID", fallback: "66c07fec002edb285af6"),
        collectionId:
            dotenv.get("COLLECTION_TWEETS_ID", fallback: "66c6fafc003003a09f27"),
      );

      List<PostModel> posts = response.documents.map((post) {
        return PostModel.fromMap(post.data);
      }).toList();

      return Right(posts);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }
}
