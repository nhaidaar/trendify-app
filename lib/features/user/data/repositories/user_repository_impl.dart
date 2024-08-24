import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Client client;
  const UserRepositoryImpl({required this.client});

  @override
  Future<Either<Exception, bool>> checkEmailExists({required String email}) async {
    try {
      final response = await Databases(client).listDocuments(
        databaseId: dotenv.get("DATABASE_ID", fallback: "66c07fec002edb285af6"),
        collectionId: dotenv.get("COLLECTION_USERS_ID", fallback: "66c6fafc003003a09f27"),
        queries: [Query.equal("email", email)],
      );

      return Right(response.documents.isNotEmpty);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, bool>> checkUsernameExists({required String username}) async {
    try {
      final response = await Databases(client).listDocuments(
        databaseId: dotenv.get("DATABASE_ID", fallback: "66c07fec002edb285af6"),
        collectionId: dotenv.get("COLLECTION_USERS_ID", fallback: "66c6fafc003003a09f27"),
        queries: [Query.equal("username", username)],
      );

      return Right(response.documents.isNotEmpty);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }
}
