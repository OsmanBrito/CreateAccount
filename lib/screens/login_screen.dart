import 'package:create_account/auth_bloc.dart';
import 'package:create_account/screens/pincode_screen.dart';
import 'package:create_account/utils/snack_bar_utils.dart';
import 'package:create_account/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginScreen extends StatelessWidget {
  final GetIt getIt = GetIt.instance;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt<AuthBloc>();
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          bloc: authBloc,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 24.0,
                top: 120.0,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create account',
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 24.0),
                        _buildFormField(
                          label: 'Name',
                          onChanged: (value) => authBloc.validateName(value),
                          errorText: state.nameError,
                        ),
                        const SizedBox(height: 20.0),
                        _buildFormField(
                          label: 'Email',
                          onChanged: (value) => authBloc.validateEmail(value),
                          keyboardType: TextInputType.emailAddress,
                          errorText: state.emailError,
                        ),
                      ],
                    ),
                  ),
                  AuthButton(
                    text: 'Next',
                    onPressed: () {
                      if (state.email.isEmpty || state.name.isEmpty) {
                        SnackBarUtils.showCustomSnackBar(context);
                      } else if (state.nameError == null &&
                          state.emailError == null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PinCodeScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required void Function(String) onChanged,
    String? errorText,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8.0),
        TextField(
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            fillColor: const Color(0xfff2f2f5),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            errorText: errorText,
          ),
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
