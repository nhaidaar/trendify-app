import 'package:flutter/material.dart';
import 'package:trendify/features/post/data/models/post_model.dart';
import '../../../../core/constant.dart';

class PostCard extends StatefulWidget {
  final PostModel model;
  const PostCard({
    super.key,
    required this.model,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;

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
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blue,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.uid.toString(),
                    style: semiboldTS.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.model.createdAt.toString(),
                    style: regularTS.copyWith(fontSize: 12),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.model.text.toString(),
            style: regularTS,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => isLiked = !isLiked),
                child: ImageIcon(
                  AssetImage(
                    isLiked ? 'assets/icons/like_active.png' : 'assets/icons/like.png',
                  ),
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                isLiked
                    ? ((widget.model.likes ?? []).length + 1).toString()
                    : (widget.model.likes ?? []).length.toString(),
                style: mediumTS,
              ),
              const SizedBox(width: 24),
              Ink(
                child: ImageIcon(
                  const AssetImage('assets/icons/messages.png'),
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                (widget.model.comments ?? []).length.toString(),
                style: mediumTS,
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }
}
