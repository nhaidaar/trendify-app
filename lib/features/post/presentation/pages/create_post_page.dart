import 'package:appwrite/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendify/core/constant.dart';
import 'package:trendify/features/post/data/models/post_model.dart';
import 'package:trendify/features/post/presentation/cubit/post_cubit.dart';
import 'package:trendify/features/user/presentation/cubit/user_cubit.dart';

class CreatePostPage extends StatefulWidget {
  final User user;
  const CreatePostPage({super.key, required this.user});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final postController = TextEditingController();

  @override
  void initState() {
    context.read<UserCubit>().getUserModel(uid: widget.user.$id);
    super.initState();
  }

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        if (state is PostSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            title: Text('Create New Post', style: semiboldTS),
            actions: [
              state is PostLoading
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    )
                  : IconButton(
                      onPressed: () => context.read<PostCubit>().makePost(
                            post: PostModel(
                              uid: widget.user.$id,
                              text: postController.text,
                            ),
                          ),
                      icon: ImageIcon(
                        const AssetImage('assets/icons/send.png'),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    return CircleAvatar(
                      radius: 24,
                      backgroundImage: state is UserFetched
                          ? CachedNetworkImageProvider(state.userModel.profilePicture.toString())
                          : null,
                    );
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: postController,
                    autofocus: true,
                    minLines: 6,
                    maxLines: 18,
                    keyboardType: TextInputType.multiline,
                    style: regularTS.copyWith(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Write as ${widget.user.name}',
                      hintStyle: regularTS,
                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.only(top: 8, bottom: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
