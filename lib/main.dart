import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trendify/features/home/presentation/cubit/home_cubit.dart';
import 'package:trendify/splash_screen.dart';

import 'core/theme.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/auth_usecase.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/usecases/home_usecase.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/usecases/user_usecase.dart';
import 'features/user/presentation/cubit/user_cubit.dart';
import 'main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Appwrite config
  await dotenv.load();
  Client client = Client();
  client
      .setEndpoint(dotenv.get('ENDPOINT', fallback: "https://cloud.appwrite.io/v1"))
      .setProject(dotenv.get('PROJECT_ID', fallback: "nhai-trendify"))
      .setSelfSigned(status: true);

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final Client client;
  const MyApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(AuthUsecase(AuthRepositoryImpl(client: client))),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(UserUsecase(UserRepositoryImpl(client: client))),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(HomeUsecase(HomeRepositoryImpl(client: client))),
        ),
      ],
      child: MaterialApp(
        title: 'Trendify',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: BlocProvider(
          create: (context) => AuthCubit(
            AuthUsecase(
              AuthRepositoryImpl(client: client),
            ),
          )..checkSession(),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return const MainScreen();
              } else if (state is Unauthenticated) {
                return const LoginPage();
              }
              return const SplashScreen();
            },
          ),
        ),
      ),
    );
  }
}
