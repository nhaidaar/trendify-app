import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trendify/features/post/data/models/post_model.dart';

import '../../domain/usecases/post_usecase.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostUsecase _postUsecase;
  PostCubit(this._postUsecase) : super(PostInitial());

  Future<void> fetchAllPosts({required bool isRefresh}) async {
    if (isClosed) return;
    try {
      if (!isRefresh) {
        emit(PostLoading());
      }
      final posts = await _postUsecase.fetchAllPosts();
      posts.fold(
        (error) => emit(PostFailed(message: error.message.toString())),
        (success) => emit(AllPostFetched(posts: success)),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> makePost({required PostModel post}) async {
    try {
      emit(PostLoading());
      final response = await _postUsecase.makePost(post: post);
      response.fold(
        (error) => emit(PostFailed(message: error.message.toString())),
        (success) => emit(PostSuccess()),
      );
      fetchAllPosts(isRefresh: false);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> likePost({required String postId, required String uid}) async {
    try {
      await _postUsecase.likePost(postId: postId, uid: uid);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> unlikePost({required String postId, required String uid}) async {
    try {
      await _postUsecase.unlikePost(postId: postId, uid: uid);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> repostPost({required String postId, required String uid}) async {
    try {
      await _postUsecase.repostPost(postId: postId, uid: uid);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> unrepostPost({required String postId, required String uid}) async {
    try {
      await _postUsecase.unrepostPost(postId: postId, uid: uid);
    } catch (_) {
      rethrow;
    }
  }
}
