import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:trendify/features/home/domain/usecases/home_usecase.dart';
import 'package:trendify/features/post/data/models/post_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  // final HomeUsecase _homeUsecase;
  HomeCubit(
      // this._homeUsecase
      )
      : super(HomeInitial());
}
