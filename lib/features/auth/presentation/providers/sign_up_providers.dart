import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/features/auth/services/auth_service.dart';

class SignUpNotifier extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _phone = '';
  String _password = '';
  String _confirmPassword = '';

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get password => _password;
  String get confirmPassword => _confirmPassword;

  set setName(String name) {
    _name = name;
  }

  set setEmail(String email) {
    _email = email;
  }

  set setPhone(String phone) {
    _phone = phone;
  }

  set setPassword(String password) {
    _password = password;
  }

  set setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
  }

  Future<void> signUp(WidgetRef ref, BuildContext context) async {
    await MyAuthService().signUpUser(
      name,
      email,
      password,
      confirmPassword,
      ref: ref,
      context: context,
    );
  }
}

final signUpProvider = ChangeNotifierProvider<SignUpNotifier>((ref) {
  return SignUpNotifier();
});
