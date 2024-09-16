import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendify/features/home/domain/usecases/home_usecase.dart';
import 'package:trendify/features/post/data/models/post_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUsecase _homeUsecase;
  HomeCubit(this._homeUsecase) : super(HomeInitial());

  Future<void> fetchAllPosts() async {
    if (isClosed) return;
    try {
      emit(HomeLoading());
      final posts = await _homeUsecase.fetchAllPosts();
      posts.fold(
        (error) => emit(HomeError(message: error.message.toString())),
        (success) => emit(HomeSuccess(posts: success)),
      );
    } catch (_) {
      rethrow;
    }
  }
}
