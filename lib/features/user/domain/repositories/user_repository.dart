import 'package:fpdart/fpdart.dart';

abstract class UserRepository {
  Future<Either<Exception, bool>> checkEmailExists({required String email});

  Future<Either<Exception, bool>> checkUsernameExists({required String username});
}
