import 'package:flutter/material.dart';
import 'package:trendify/core/constant.dart';
import 'package:trendify/main_screen.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_field.dart';

class CreateUsernamePage extends StatelessWidget {
  const CreateUsernamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(2, -0.85),
              radius: 0.7,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.2),
                Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                Theme.of(context).colorScheme.background,
              ],
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
            children: [
              Text(
                'One Step Again!',
                style: semiboldTS.copyWith(fontSize: 28),
              ),
              const SizedBox(height: 12),
              Opacity(
                opacity: 0.85,
                child: Text(
                  'Start with a unique username and a profile picture that\'s one of a kind.',
                  style: mediumTS.copyWith(height: 1.7),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                height: 240,
                width: 240,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 10),
                  shape: BoxShape.circle,
                  image: const DecorationImage(image: AssetImage('assets/images/logo.png')),
                ),
              ),
              const SizedBox(height: 40),
              CustomField(
                fieldTitle: 'Username',
                hintText: 'johndoe',
                // onTap: () {},
              ),
              const SizedBox(height: 40),
              CustomButton(
                title: 'Next',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MainScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
