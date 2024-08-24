import 'package:fpdart/fpdart.dart';
import 'package:trendify/features/user/domain/repositories/user_repository.dart';

class UserUsecase {
  final UserRepository _userRepository;

  const UserUsecase(this._userRepository);

  Future<Either<Exception, bool>> checkEmailExists({required String email}) {
    return _userRepository.checkEmailExists(email: email);
  }

  Future<Either<Exception, bool>> checkUsernameExists({required String username}) {
    return _userRepository.checkUsernameExists(username: username);
  }
}
