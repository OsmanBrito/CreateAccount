import 'package:create_account/auth_bloc.dart';
import 'package:create_account/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatelessWidget {
  final GetIt getIt = GetIt.instance;

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt<AuthBloc>();
    final state = authBloc.state;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icon.png',
                      width: 192.68,
                      height: 211.22,
                    ),
                    const SizedBox(height: 16.0),
                    _buildUserInfo('Name', state.name),
                    _buildUserInfo('Email', state.email),
                  ],
                ),
              ),
              _buildButtons(context, authBloc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(String label, String value) {
    return Text(
      '$label: $value',
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildButtons(BuildContext context, AuthBloc authBloc) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: AuthButton(
            onPressed: () {
              authBloc.emit(AuthState());
              Navigator.of(context).pop();
            },
            text: 'Clear account',
            clear: true,
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          fit: FlexFit.tight,
          child: AuthButton(
            onPressed: () {
              authBloc.emit(AuthState());
              Navigator.pop(context);
            },
            text: 'Log out',
          ),
        ),
      ],
    );
  }
}
