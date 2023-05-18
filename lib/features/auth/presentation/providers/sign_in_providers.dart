import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/features/auth/services/auth_service.dart';

class SignInNotifier extends ChangeNotifier {
  String _email = '';
  String _password = '';
  bool isLoading = false;

  String get email => _email;
  String get password => _password;

  set setEmail(String email) {
    _email = email;
  }

  set setPassword(String password) {
    _password = password;
  }

  Future<void> signIn(WidgetRef ref, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await MyAuthService()
        .signInUser(
      _email,
      _password,
      ref: ref,
      context: context,
    )
        .whenComplete(() {
      isLoading = false;
      notifyListeners();
    });
  }
}

final signInProvider = ChangeNotifierProvider(
  (ref) => SignInNotifier(),
);
