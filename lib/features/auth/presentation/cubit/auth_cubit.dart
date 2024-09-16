import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendify/features/auth/domain/usecases/auth_usecase.dart';

import '../../../user/data/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUsecase _authUsecase;
  AuthCubit(this._authUsecase) : super(AuthInitial());

  Future<void> checkSession() async {
    try {
      final sessionExists = await _authUsecase.checkSession();
      sessionExists.fold(
        (error) {
          emit(AuthError(message: error.message.toString()));
          emit(Unauthenticated());
        },
        (success) => emit(Authenticated()),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> register({
    required UserModel userModel,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      final account = await _authUsecase.register(
        name: userModel.fullName.toString(),
        email: userModel.email.toString(),
        password: password,
      );
      account.fold(
        (error) => emit(AuthError(message: error.message.toString())),
        (success) async {
          try {
            await _authUsecase
                .registerUserModel(
                  userModel: userModel.copyWith(uid: success.$id),
                )
                .then(
                  (_) => login(
                    email: userModel.email.toString(),
                    password: password,
                  ),
                );
          } on Exception catch (e) {
            emit(AuthError(message: e.toString()));
          }
        },
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
      final newEmail = await _authUsecase.findEmailByUsername(username: email);
      final session = await _authUsecase.login(
        email: newEmail ?? email,
        password: password,
      );

      session.fold(
        (error) => emit(AuthError(message: error.message.toString())),
        (success) => emit(Authenticated()),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      emit(AuthLoading());
      final logout = await _authUsecase.logout();
      logout.fold(
        (error) => emit(AuthError(message: error.toString())),
        (success) => emit(Unauthenticated()),
      );
    } catch (_) {
      rethrow;
    }
  }
}
