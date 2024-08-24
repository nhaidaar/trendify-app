import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:trendify/common/widgets/custom_button.dart';
import 'package:trendify/common/widgets/custom_field.dart';
import 'package:trendify/core/constant.dart';
import 'package:trendify/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:trendify/features/auth/presentation/pages/register_page.dart';
import 'package:trendify/main_screen.dart';

import '../../../../common/widgets/loading_button.dart';

final _formKey = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();
  bool passwordHidden = true;
  bool areFieldsEmpty = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(updateFieldState);
    passwordController.addListener(updateFieldState);
  }

  @override
  void dispose() {
    emailController.removeListener(updateFieldState);
    passwordController.removeListener(updateFieldState);
    emailController.dispose();
    passwordController.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  void updateFieldState() {
    setState(() {
      areFieldsEmpty = emailController.text.isEmpty || passwordController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is Authenticated) {
            Navigator.of(context).pushAndRemoveUntil(
              PageTransition(
                child: const MainScreen(),
                type: PageTransitionType.fade,
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-2, -0.85),
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
                    const SizedBox(height: 80),
                    Text(
                      'Trendify',
                      style: boldTS.copyWith(fontSize: 42),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 80),
                    CustomFieldOnly(
                      hintText: 'Username or email address',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
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
                    Text(
                      'Forgot password?',
                      style: semiboldTS,
                      textAlign: TextAlign.end,
                    ),
                    const SizedBox(height: 40),
                    state is AuthLoading
                        ? const LoadingButton()
                        : CustomButton(
                            title: 'Login',
                            disabled: areFieldsEmpty,
                            onTap: () {
                              context.read<AuthCubit>().login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                            },
                          ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageTransition(
                            child: const RegisterPage(),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have account? ',
                            style: mediumTS,
                          ),
                          Text(
                            'Sign up',
                            style: semiboldTS.copyWith(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
