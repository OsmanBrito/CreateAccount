import 'package:create_account/auth_bloc.dart';
import 'package:create_account/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<AuthBloc>(
    AuthBloc(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
              (states) => const Color(0xff5E38F4),
            ),
          ),
        ),
      ),
      home: BlocProvider(
        create: (_) => getIt<AuthBloc>(),
        child: LoginScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
