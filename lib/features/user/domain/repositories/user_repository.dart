import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<AppwriteException, UserModel>> getUserModel({required String uid});

  Future<Either<Exception, bool>> checkEmailExists({required String email});

  Future<Either<Exception, bool>> checkUsernameExists({required String username});
}
