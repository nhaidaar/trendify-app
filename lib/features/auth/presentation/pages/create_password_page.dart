import 'package:flutter/material.dart';
import 'package:trendify/core/constant.dart';
import 'package:trendify/features/auth/presentation/pages/create_username_page.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_field.dart';

class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({super.key});

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
              center: const Alignment(2, 0.85),
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
                'Create Password',
                style: semiboldTS.copyWith(fontSize: 28),
              ),
              const SizedBox(height: 12),
              Opacity(
                opacity: 0.85,
                child: Text(
                  'Your password is your secret weapon. Make it epic!',
                  style: mediumTS.copyWith(height: 1.7),
                ),
              ),
              const SizedBox(height: 40),
              CustomFieldOnly(
                hintText: 'Password',
                controller: passwordController,
                // onTap: () {},
              ),
              const SizedBox(height: 16),
              CustomFieldOnly(
                hintText: 'Confirm password',
                controller: confirmPasswordController,
                // onTap: () {},
              ),
              const SizedBox(height: 40),
              CustomButton(
                title: 'Next',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CreateUsernamePage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
