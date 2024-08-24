import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:trendify/core/constant.dart';
import 'package:trendify/features/user/presentation/cubit/user_cubit.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_field.dart';
import '../../../../common/widgets/loading_button.dart';
import '../../../user/data/models/user_model.dart';

import 'create_password_page.dart';

final _formKey = GlobalKey<FormState>();

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  bool areFieldsEmpty = true;

  @override
  void initState() {
    super.initState();
    nameController.addListener(updateFieldState);
    emailController.addListener(updateFieldState);
  }

  @override
  void dispose() {
    nameController.removeListener(updateFieldState);
    emailController.removeListener(updateFieldState);
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void updateFieldState() {
    setState(() {
      areFieldsEmpty = nameController.text.isEmpty || emailController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is EmailExists) {
            if (state.isEmailExists) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Your email address already registered.')),
              );
            } else {
              Navigator.of(context).push(
                PageTransition(
                  child: CreatePasswordPage(
                    userModel: UserModel(
                      fullName: nameController.text,
                      email: emailController.text,
                    ),
                  ),
                  type: PageTransitionType.rightToLeft,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
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
              child: Form(
                key: _formKey,
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
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 16),
                    CustomField(
                      fieldTitle: 'Email Address',
                      hintText: 'johndoe@gmail.com',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
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
                    state is UserLoading
                        ? const LoadingButton()
                        : CustomButton(
                            title: 'Next',
                            disabled: areFieldsEmpty,
                            onTap: () {
                              context
                                  .read<UserCubit>()
                                  .checkEmailExists(email: emailController.text);
                            },
                          ),
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
