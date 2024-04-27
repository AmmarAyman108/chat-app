import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logic/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter_application_1/business_logic/cubits/login_cubit/login_cubit.dart';
import 'package:flutter_application_1/business_logic/cubits/register_cubit/register_cubit.dart';
import 'package:flutter_application_1/business_logic/cubits/send_message/send_message_cubit.dart';
import 'package:flutter_application_1/business_logic/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/presentation/views/home_view.dart';
import 'package:flutter_application_1/presentation/views/login_view.dart';
import 'package:flutter_application_1/presentation/views/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeCubit(),
          ),
          BlocProvider(
            create: (context) => SendMessageCubit(),
          ),
          BlocProvider(
            create: (context) => LoginCubit(),
          ),
          BlocProvider(
            create: (context) => RegisterCubit(),
          ),
          BlocProvider(create: (context) => ChatCubit()),
        ],
        child: MaterialApp(
          theme: theme,
          darkTheme: darkTheme,
          routes: {
            LoginView.id: (context) => const LoginView(),
            RegisterView.id: (context) => const RegisterView(),
          },
          home: FirebaseAuth.instance.currentUser == null
              ? const LoginView()
              : HomeView(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
