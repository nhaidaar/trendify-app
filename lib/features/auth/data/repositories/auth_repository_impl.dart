import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:trendify/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Client client;
  const AuthRepositoryImpl({required this.client});

  @override
  Future<Either<Exception, Session>> login({required String email, required String password}) async {
    try {
      final session = await Account(client).createEmailPasswordSession(email: email, password: password);
      return Right(session);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> logout() async {
    try {
      final clearedSession = await Account(client).deleteSession(
        sessionId: 'current',
      );
      // ignore: void_checks
      return Right(clearedSession);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, User>> checkSession() async {
    try {
      final user = await Account(client).get();
      return Right(user);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }
}
