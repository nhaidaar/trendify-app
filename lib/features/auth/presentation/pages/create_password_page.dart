import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:trendify/core/constant.dart';
import 'package:trendify/features/auth/presentation/pages/create_username_page.dart';
import 'package:trendify/features/user/data/models/user_model.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_field.dart';

final _formKey = GlobalKey<FormState>();

class CreatePasswordPage extends StatefulWidget {
  final UserModel userModel;
  const CreatePasswordPage({super.key, required this.userModel});

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  bool passwordHidden = true;
  bool confirmPasswordHidden = true;
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool areFieldsEmpty = true;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(updateFieldState);
    confirmPasswordController.addListener(updateFieldState);
  }

  @override
  void dispose() {
    passwordController.removeListener(updateFieldState);
    confirmPasswordController.removeListener(updateFieldState);
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void updateFieldState() {
    setState(() {
      areFieldsEmpty =
          passwordController.text.isEmpty || confirmPasswordController.text.isEmpty;
    });
  }

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
          child: Form(
            key: _formKey,
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
                  focusNode: passwordFocus,
                  controller: passwordController,
                  isPassword: true,
                  obscureText: passwordHidden,
                  onTap: () {
                    setState(() => passwordHidden = !passwordHidden);
                  },
                ),
                const SizedBox(height: 16),
                CustomFieldOnly(
                  hintText: 'Confirm Password',
                  focusNode: confirmPasswordFocus,
                  controller: confirmPasswordController,
                  isPassword: true,
                  obscureText: confirmPasswordHidden,
                  onTap: () {
                    setState(() => confirmPasswordHidden = !confirmPasswordHidden);
                  },
                  validator: (confirmPassword) {
                    return confirmPassword != passwordController.text
                        ? 'Confirm password doesn\'t match!'
                        : null;
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  // onTap: () {},
                ),
                const SizedBox(height: 40),
                CustomButton(
                  title: 'Next',
                  disabled: areFieldsEmpty ||
                      passwordController.text != confirmPasswordController.text,
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: CreateUsernamePage(
                          userModel: widget.userModel,
                          password: passwordController.text,
                        ),
                        type: PageTransitionType.rightToLeft,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
