// ignore_for_file: void_checks

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:trendify/features/auth/domain/repositories/auth_repository.dart';
import 'package:trendify/features/user/data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Client client;
  const AuthRepositoryImpl({required this.client});

  @override
  Future<Either<AppwriteException, User>> checkSession() async {
    try {
      final user = await Account(client).get();
      return Right(user);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, User>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final account = await Account(client).create(
        userId: ID.unique(),
        name: name,
        email: email,
        password: password,
      );
      return Right(account);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, void>> registerUserModel({
    required UserModel userModel,
  }) async {
    try {
      final account = await Databases(client).createDocument(
        databaseId: dotenv.get("DATABASE_ID", fallback: "66c07fec002edb285af6"),
        collectionId: dotenv.get("COLLECTION_USERS_ID", fallback: "66c6fafc003003a09f27"),
        documentId: userModel.uid.toString(),
        data: userModel.toMap(),
      );
      return Right(account);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<String?> findEmailByUsername({required String username}) async {
    try {
      final response = await Databases(client).listDocuments(
        databaseId: dotenv.get("DATABASE_ID", fallback: "66c07fec002edb285af6"),
        collectionId: dotenv.get("COLLECTION_USERS_ID", fallback: "66c6fafc003003a09f27"),
        queries: [Query.equal("username", username)],
      );
      if (response.documents.isNotEmpty) {
        return response.documents[0].data['email'];
      } else {
        return null;
      }
    } on AppwriteException {
      return null;
    }
  }

  @override
  Future<Either<AppwriteException, Session>> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await Account(client)
          .createEmailPasswordSession(email: email, password: password);
      return Right(session);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, void>> logout() async {
    try {
      final clearedSession = await Account(client).deleteSession(
        sessionId: 'current',
      );
      return Right(clearedSession);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }
}
