import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());
}
