import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendify/features/auth/domain/usecases/auth_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUsecase _authUsecase;
  AuthCubit(this._authUsecase) : super(Unauthenticated());

  Future<void> checkSession() async {
    try {
      final sessionExists = await _authUsecase.checkSession();
      sessionExists.fold(
        (error) => emit(AuthError(message: error.toString())),
        (success) => emit(Authenticated()),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      final session = await _authUsecase.login(email: email, password: password);
      session.fold(
        (error) => emit(AuthError(message: error.toString())),
        (success) => emit(Authenticated()),
      );
    } catch (_) {
      rethrow;
    }
  }
}
