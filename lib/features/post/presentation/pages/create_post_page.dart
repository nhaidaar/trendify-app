import 'package:flutter/material.dart';
import 'package:trendify/common/widgets/custom_button.dart';
import 'package:trendify/core/constant.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text('Create New Post', style: semiboldTS),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(radius: 24),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                minLines: 6,
                maxLines: 6,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Write as Naufal Haidar',
                  hintStyle: regularTS,
                  alignLabelWithHint: true,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: CustomButton(
          title: 'Post',
          onTap: () {},
        ),
      ),
    );
  }
}
