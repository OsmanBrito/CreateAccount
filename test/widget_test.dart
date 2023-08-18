import 'package:bloc_test/bloc_test.dart';
import 'package:create_account/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;

    setUp(() {
      authBloc = AuthBloc();
    });

    tearDown(() {
      authBloc.close();
    });

    blocTest<AuthBloc, AuthState>(
      'validateName emits correct state for valid name',
      build: () => authBloc,
      act: (bloc) => bloc.validateName('John'),
      expect: () => [AuthState(name: 'John', nameError: null)],
    );

    blocTest<AuthBloc, AuthState>(
      'validateName emits correct state for invalid name',
      build: () => authBloc,
      act: (bloc) => bloc.validateName('J0hn'), // Invalid due to numeric character
      expect: () => [AuthState(name: 'J0hn', nameError: 'Invalid name')],
    );

    blocTest<AuthBloc, AuthState>(
      'validateName emits correct state for invalid name',
      build: () => authBloc,
      act: (bloc) => bloc.validateName('Jhon Surname'), // Invalid due to numeric character
      expect: () => [AuthState(name: 'Jhon Surname', nameError: 'Invalid name')],
    );

    blocTest<AuthBloc, AuthState>(
      'validateEmail emits correct state for valid email',
      build: () => authBloc,
      act: (bloc) => bloc.validateEmail('test@example.com'),
      expect: () => [AuthState(email: 'test@example.com')],
    );

    blocTest<AuthBloc, AuthState>(
      'validateEmail emits correct state for invalid email',
      build: () => authBloc,
      act: (bloc) => bloc.validateEmail('invalidemail'), // Invalid email format
      expect: () => [AuthState(email: 'invalidemail', emailError: 'Invalid email')],
    );

    blocTest<AuthBloc, AuthState>(
      'validatePincode emits correct state for valid pincode',
      build: () => authBloc,
      act: (bloc) => bloc.validatePincode('764823'),
      expect: () => [AuthState(pincode: '764823',)],
    );

    blocTest<AuthBloc, AuthState>(
      'validatePincode emits correct state for invalid pincode',
      build: () => authBloc,
      act: (bloc) => bloc.validatePincode('315353'), // Consecutive repeated digits
      expect: () => [AuthState(pincode: '315353', pincodeError: 'Invalid pincode')],
    );

    blocTest<AuthBloc, AuthState>(
      'validatePincode emits correct state for invalid pincode',
      build: () => authBloc,
      act: (bloc) => bloc.validatePincode('222334'), // Consecutive repeated digits
      expect: () => [AuthState(pincode: '222334', pincodeError: 'Invalid pincode')],
    );

    blocTest<AuthBloc, AuthState>(
      'validatePincode emits correct state for invalid pincode',
      build: () => authBloc,
      act: (bloc) => bloc.validatePincode('111234'), // Consecutive repeated digits
      expect: () => [AuthState(pincode: '111234', pincodeError: 'Invalid pincode')],
    );

    blocTest<AuthBloc, AuthState>(
      'validatePincode emits correct state for invalid pincode',
      build: () => authBloc,
      act: (bloc) => bloc.validatePincode('234567'), // Consecutive repeated digits
      expect: () => [AuthState(pincode: '234567', pincodeError: 'Invalid pincode')],
    );

    blocTest<AuthBloc, AuthState>(
      'validatePincode emits correct state for simple sequence',
      build: () => authBloc,
      act: (bloc) => bloc.validatePincode('123456'), // Simple sequence
      expect: () => [AuthState(pincode: '123456', pincodeError: 'Invalid pincode')],
    );

    blocTest<AuthBloc, AuthState>(
      'validatePincode emits correct state for invalid pincode',
      build: () => authBloc,
      act: (bloc) => bloc.validatePincode('987654'), // Consecutive repeated digits
      expect: () => [AuthState(pincode: '987654', pincodeError: 'Invalid pincode')],
    );
  });
}