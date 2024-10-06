import 'package:appwrite/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendify/core/helper.dart';
import 'package:trendify/features/post/data/models/post_model.dart';
import '../../../../core/constant.dart';
import '../../../post/presentation/cubit/post_cubit.dart';
import 'post_button.dart';

class PostCard extends StatefulWidget {
  final PostWithUser model;
  final User user;
  const PostCard({
    super.key,
    required this.model,
    required this.user,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool isLiked;
  late bool isReposted;

  @override
  void initState() {
    isLiked = (widget.model.post.likes ?? []).contains(widget.user.$id);
    isReposted = (widget.model.post.reposts ?? []).contains(widget.user.$id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).splashColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Details
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: widget.model.user != null
                    ? CachedNetworkImageProvider(widget.model.user!.profilePicture.toString())
                    : const AssetImage('assets/images/logo.png') as ImageProvider,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author name
                  Text(
                    widget.model.user != null
                        ? widget.model.user!.fullName.toString()
                        : 'Trendify User',
                    style: semiboldTS.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 4),

                  // Post created at
                  Text(
                    formatDateTime(widget.model.post.createdAt ?? DateTime.now()),
                    style: regularTS.copyWith(fontSize: 12),
                  )
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Content
          Text(
            widget.model.post.text.toString(),
            style: regularTS,
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              // Like button
              GestureDetector(
                onTap: () => handleLikeButton(context),
                child: PostButton(
                  icon: isLiked ? 'assets/icons/like_active.png' : 'assets/icons/like.png',
                  active: (widget.model.post.likes ?? []).contains(widget.user.$id),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                (widget.model.post.likes ?? []).length.toString(),
                style: mediumTS,
              ),

              const SizedBox(width: 24),

              // Repost button
              GestureDetector(
                onTap: () => handleRepostButton(context),
                child: PostButton(
                  icon: 'assets/icons/repost.png',
                  size: 22,
                  active: (widget.model.post.reposts ?? []).contains(widget.user.$id),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                (widget.model.post.reposts ?? []).length.toString(),
                style: mediumTS,
              ),

              const SizedBox(width: 24),

              // Comment Button
              GestureDetector(
                onTap: () {},
                child: const PostButton(
                  icon: 'assets/icons/messages.png',
                  active: false,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                (widget.model.post.comments ?? []).length.toString(),
                style: mediumTS,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void handleLikeButton(BuildContext context) {
    if (isLiked) {
      setState(() {
        isLiked = false;
        (widget.model.post.likes ?? []).remove(widget.user.$id);
      });
      context.read<PostCubit>().unlikePost(
            postId: widget.model.post.postId.toString(),
            uid: widget.user.$id,
          );
    } else {
      setState(() {
        isLiked = true;
        (widget.model.post.likes ?? []).add(widget.user.$id);
      });
      context.read<PostCubit>().likePost(
            postId: widget.model.post.postId.toString(),
            uid: widget.user.$id,
          );
    }
  }

  void handleRepostButton(BuildContext context) {
    if (isReposted) {
      setState(() {
        isReposted = false;
        (widget.model.post.reposts ?? []).remove(widget.user.$id);
      });
      context.read<PostCubit>().unrepostPost(
            postId: widget.model.post.postId.toString(),
            uid: widget.user.$id,
          );
    } else {
      setState(() {
        isReposted = true;
        (widget.model.post.reposts ?? []).add(widget.user.$id);
      });
      context.read<PostCubit>().repostPost(
            postId: widget.model.post.postId.toString(),
            uid: widget.user.$id,
          );
    }
  }
}
