import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:trendify/core/constant.dart';
import 'package:trendify/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:trendify/features/user/data/models/user_model.dart';
import 'package:trendify/features/user/presentation/cubit/user_cubit.dart';
import 'package:trendify/main_screen.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_field.dart';
import '../../../../common/widgets/loading_button.dart';

final _formKey = GlobalKey<FormState>();

class CreateUsernamePage extends StatefulWidget {
  final UserModel userModel;
  final String password;
  const CreateUsernamePage({super.key, required this.userModel, required this.password});

  @override
  State<CreateUsernamePage> createState() => _CreateUsernamePageState();
}

class _CreateUsernamePageState extends State<CreateUsernamePage> {
  final usernameController = TextEditingController();
  bool nextButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    usernameController.addListener(updateFieldState);
  }

  @override
  void dispose() {
    usernameController.removeListener(updateFieldState);
    usernameController.dispose();
    super.dispose();
  }

  void updateFieldState() {
    setState(() {
      nextButtonDisabled =
          usernameController.text.isEmpty || usernameController.text.length < 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                Navigator.of(context).push(
                  PageTransition(
                    child: MainScreen(user: state.user),
                    type: PageTransitionType.fade,
                  ),
                );
              }
            },
          ),
          BlocListener<UserCubit, UserState>(
            listener: (context, state) {
              if (state is UserError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
              if (state is UsernameExists) {
                if (state.isUsernameExists) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '@${usernameController.text} already taken, try another username.',
                      ),
                    ),
                  );
                } else {
                  context.read<AuthCubit>().register(
                        userModel: widget.userModel.copyWith(
                          username: usernameController.text,
                        ),
                        password: widget.password,
                      );
                }
              }
            },
          ),
        ],
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              );
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                toolbarHeight: 70,
              ),
              body: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(2, -0.05),
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
                        'One Step Again!',
                        style: semiboldTS.copyWith(fontSize: 28),
                      ),
                      const SizedBox(height: 12),
                      Opacity(
                        opacity: 0.85,
                        child: Text(
                          'Start with a unique username and let everyone know who are you.',
                          style: mediumTS.copyWith(height: 1.7),
                        ),
                      ),
                      // const SizedBox(height: 40),
                      // Container(
                      //   height: 240,
                      //   width: 240,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.grey.shade300, width: 10),
                      //     shape: BoxShape.circle,
                      //     image: const DecorationImage(
                      //       image: AssetImage('assets/images/logo.png'),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 40),
                      CustomField(
                        fieldTitle: 'Username',
                        hintText: 'johndoe',
                        controller: usernameController,
                        textInputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9._]')),
                        ],
                        validator: (uname) => uname.toString().length < 3
                            ? 'Username must be at least 3 characters.'
                            : null,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      const SizedBox(height: 40),
                      BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          if (state is UserLoading) {
                            return const LoadingButton();
                          }
                          return CustomButton(
                            title: 'Next',
                            disabled: nextButtonDisabled,
                            onTap: () {
                              context
                                  .read<UserCubit>()
                                  .checkUsernameExists(username: usernameController.text);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
