part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccess extends PostState {}

class PostFailed extends PostState {
  final String message;
  const PostFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class AllPostFetched extends PostState {
  final List<PostWithUser> posts;
  const AllPostFetched({required this.posts});

  @override
  List<Object> get props => [posts];
}

class PostRefreshed extends PostState {
  final PostModel model;
  const PostRefreshed({required this.model});

  @override
  List<Object> get props => [model];
}
