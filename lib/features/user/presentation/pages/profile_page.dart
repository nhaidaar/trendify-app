import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:trendify/features/user/presentation/pages/profile_view_page.dart';

import '../../../../core/constant.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          Text(
            'Profile',
            style: semiboldTS.copyWith(fontSize: 28),
          ),
          const SizedBox(height: 16),
          const CircleAvatar(
            radius: 48,
            backgroundColor: Colors.blue,
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              Text(
                'Naufal Haidar',
                style: semiboldTS.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(
                '@nhaidaar',
                style: semiboldTS.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Incididunt ipsum nostrud esse consectetur fugiat nisi aliqua ut officia sit nostrud.',
                style: mediumTS,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 40),
              ...List.generate(
                4,
                (index) => ProfileMenu(
                  title: 'Menu ${index + 1}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final String title;
  const ProfileMenu({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageTransition(
                child: const ProfileViewPage(),
                type: PageTransitionType.rightToLeft,
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).splashColor,
              ),
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: mediumTS.copyWith(fontSize: 18),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios_outlined)
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
