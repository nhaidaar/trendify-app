import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:trendify/features/auth/domain/repositories/auth_repository.dart';

class AuthUsecase {
  final AuthRepository _authRepository;

  const AuthUsecase(this._authRepository);

  Future<Either<Exception, Session>> login({required String email, required String password}) {
    return _authRepository.login(email: email, password: password);
  }

  Future<Either<Exception, void>> logout() {
    return _authRepository.logout();
  }

  Future<Either<Exception, User>> checkSession() async {
    return _authRepository.checkSession();
  }
}
