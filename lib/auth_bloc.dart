import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(AuthState());

  /// Validates input [name] and updates state.
  /// Criteria: length >= 2, only letters, no spaces.
  void validateName(String name) {
    if (name.length >= 2 &&
        RegExp(r'^[a-zA-Z]+$').hasMatch(name) &&
        !name.contains(' ')) {
      emit(
        state.copyWith(
          name: name,
          nameError: null,
        ),
      );
    } else {
      emit(state.copyWith(name: name, nameError: 'Invalid name'));
    }
  }

  /// Validates and updates state for input [email]: length > 4, proper format.
  void validateEmail(String email) {
    if (email.length > 4 &&
        RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z]+\.[a-zA-Z]+$').hasMatch(email)) {
      emit(
        state.copyWith(email: email),
      );
    } else {
      emit(
        state.copyWith(email: email, emailError: 'Invalid email'),
      );
    }
  }

  /// Validates the provided [pincode] and updates state accordingly.
  ///
  /// Ensures that the [pincode]:
  /// - Contains exactly 6 digits.
  /// - Digits should not repeat themselves more than 2 times
  /// - Avoids simple sequences (e.g., "123456").
  void validatePincode(String pincode) {
    if (pincode.length == 6 &&
        RegExp(r'^\d{6}$').hasMatch(pincode) &&
        !_hasConsecutiveRepeats(pincode) &&
        !_isSimpleSequence(pincode)) {
      emit(
        state.copyWith(pincode: pincode),
      );
    } else {
      emit(state.copyWith(pincode: pincode, pincodeError: 'Invalid pincode'));
    }
  }

  /// Checks if the provided [code] represents a simple numeric sequence.
  /// Returns true if the [code] forms either an increasing or decreasing sequence.
  bool _isSimpleSequence(String code) {
    final intCode = int.tryParse(code);
    if (intCode == null) {
      return false;
    }
    final List<int> digits =
        code.runes.map((rune) => int.parse(String.fromCharCode(rune))).toList();

    bool isIncreasingSequence = true;
    bool isDecreasingSequence = true;

    for (int i = 0; i < digits.length - 1; i++) {
      if (digits[i] != digits[i + 1] - 1) {
        isIncreasingSequence = false;
      }
      if (digits[i] != digits[i + 1] + 1) {
        isDecreasingSequence = false;
      }
    }

    return isIncreasingSequence || isDecreasingSequence;
  }

  /// Checks for consecutive repeated characters in the provided [code].
  /// Returns true if [code] has a sequence of the same character
  /// repeated three or more times.
  bool _hasConsecutiveRepeats(String code) {
    for (int i = 0; i <= code.length - 1; i++) {
      final repeated = code.split('').where((element) => element == code[i]);
      if (repeated.length > 2) {
        return true;
      }
    }
    return false;
  }
}

class AuthState {
  final String name;
  final String? nameError;
  final String email;
  final String? emailError;
  final String pincode;
  final String? pincodeError;

  AuthState({
    this.name = '',
    this.nameError,
    this.email = '',
    this.emailError,
    this.pincode = '',
    this.pincodeError,
  });

  AuthState copyWith({
    String? name,
    String? nameError,
    String? email,
    String? emailError,
    String? pincode,
    String? pincodeError,
  }) {
    return AuthState(
      name: name ?? this.name,
      nameError: nameError,
      email: email ?? this.email,
      emailError: emailError,
      pincode: pincode ?? this.pincode,
      pincodeError: pincodeError,
    );
  }
}
