import 'package:create_account/auth_bloc.dart';
import 'package:create_account/screens/home_screen.dart';
import 'package:create_account/utils/snack_bar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeScreen extends StatelessWidget {
  final GetIt getIt = GetIt.instance;

  PinCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt<AuthBloc>();

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          bloc: authBloc,
          builder: (context, state) {
            return _buildContent(context, authBloc, state);
          },
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, AuthBloc authBloc, AuthState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 54.0),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 24.0),
          _buildPinCodeTextField(context, authBloc),
          const Spacer(),
          _buildConfirmButton(context, state),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, size: 24.0),
        ),
        const SizedBox(height: 26.0),
        const Text(
          'Create passcode',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Make it 💪 – Refrain from sequences (123456) and repeated numbers (111234)',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Color(0xff8A8A99),
          ),
        ),
      ],
    );
  }

  Widget _buildPinCodeTextField(BuildContext context, AuthBloc authBloc) {
    return PinCodeTextField(
      enableActiveFill: true,
      appContext: context,
      length: 6,
      onChanged: (value) => authBloc.validatePincode(value),
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.circle,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 46,
        fieldWidth: 48,
        selectedFillColor: const Color(0xffDADADA),
        activeFillColor: const Color(0xffDADADA),
        inactiveFillColor: const Color(0xffF2F2F5),
        selectedColor: Colors.black,
        inactiveColor: Colors.transparent,
        activeColor: Colors.black,
      ),
    );
  }

  Widget _buildConfirmButton(
    BuildContext context,
    AuthState state,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        onPressed: () {
          if (state.pincodeError == null && state.pincode.isNotEmpty) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          } else {
            SnackBarUtils.showCustomSnackBar(context);
          }
        },
        child: const Text('Confirm'),
      ),
    );
  }
}
