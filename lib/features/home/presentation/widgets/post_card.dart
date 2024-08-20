import 'package:flutter/material.dart';
import '../../../../core/constant.dart';

class PostCard extends StatefulWidget {
  final String name, time, post;
  final int like, reply;
  const PostCard({
    super.key,
    required this.name,
    required this.time,
    required this.post,
    required this.like,
    required this.reply,
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
                    widget.name,
                    style: semiboldTS.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.time,
                    style: regularTS.copyWith(fontSize: 12),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.post,
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
                isLiked ? (widget.like + 1).toString() : widget.like.toString(),
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
                widget.reply.toString(),
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
