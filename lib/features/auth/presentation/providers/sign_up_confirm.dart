import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/features/auth/services/auth_service.dart';

class SignUpConfirmNotifier extends ChangeNotifier {
  String _code = '';
  String email = '';

  String get code => _code;

  set setCode(String code) {
    _code = code;
  }

  Future<void> resendCode(String email) async {
    await MyAuthService().resendCode(email);
  }

  Future<void> confirm(WidgetRef ref, String email) async {
    await MyAuthService().confirmSignUp(
      email,
      code,
      ref: ref,
    );
  }
}

final signUpConfirmProvider = ChangeNotifierProvider(
  (ref) => SignUpConfirmNotifier(),
);
