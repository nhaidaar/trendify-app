import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant.dart';
import '../../../post/presentation/cubit/post_cubit.dart';
import '../widgets/post_card.dart';

class HomeDiscover extends StatelessWidget {
  const HomeDiscover({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            await context.read<PostCubit>().fetchAllPosts(isRefresh: true);
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              if (state is PostLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else if (state is AllPostFetched)
                ...state.posts.map(
                  (post) => PostCard(model: post, user: user),
                )
              else
                Center(
                  child: Text(
                    'Nothing here, maybe there\'s an error?',
                    style: mediumTS,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
