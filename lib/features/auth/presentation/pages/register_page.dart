import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:trendify/core/constant.dart';
import 'package:trendify/features/auth/presentation/pages/create_password_page.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 70,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(-2, 0.85),
              radius: 0.7,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.2),
                Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                Theme.of(context).colorScheme.background,
              ],
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Hey, Welcome!',
                style: semiboldTS.copyWith(fontSize: 28),
              ),
              const SizedBox(height: 12),
              Opacity(
                opacity: 0.85,
                child: Text(
                  'Let me know how we can reach you. It shouldn\'t take a long time.',
                  style: mediumTS.copyWith(height: 1.7),
                ),
              ),
              const SizedBox(height: 40),
              CustomField(
                fieldTitle: 'Full Name',
                hintText: 'John Doe',
                controller: nameController,
                // onTap: () {},
              ),
              const SizedBox(height: 16),
              CustomField(
                fieldTitle: 'Email Address',
                hintText: 'johndoe@gmail.com',
                controller: emailController,
                // onTap: () {},
              ),
              const SizedBox(height: 8),
              Opacity(
                opacity: 0.5,
                child: Text(
                  '* Your email won\'t be visible on your profile.',
                  style: mediumTS.copyWith(height: 1.7),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                title: 'Next',
                onTap: () {
                  Navigator.of(context).push(
                    PageTransition(
                      child: const CreatePasswordPage(),
                      type: PageTransitionType.rightToLeft,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
