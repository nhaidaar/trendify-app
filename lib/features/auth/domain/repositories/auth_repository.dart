import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Exception, User>> checkSession();

  Future<Either<Exception, Session>> login({required String email, required String password});

  Future<Either<Exception, void>> logout();
}
