import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/app.dart';
import 'package:letsgt/config/routes/routes.dart';

abstract class AmplifyAuthService {
  String? requestToken;
  Future<void> signInUser(
    String username,
    String password,
  );
  Future<void> signUpUser(
    String name,
    String email,
    String password,
    String confirmPassword, {
    String? phoneNumber,
  });
  Future<void> confirmSignUp(
    String username,
    String confirmationCode,
  );
  Future<void> confirmResetPassword({
    required String username,
    required String newPassword,
    required String confirmationCode,
  });
  Future<void> resendCode(String email);
  Future<void> signOut();
  Future<void> resetPassword();
}

class MyAuthService implements AmplifyAuthService {
  factory MyAuthService() => _instance;
  MyAuthService._();
  static final MyAuthService _instance = MyAuthService._();

  @override
  String? requestToken;

  @override
  Future<void> confirmSignUp(
    String username,
    String confirmationCode, {
    WidgetRef? ref,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
      // Check if further confirmations are needed or if
      // the sign up is complete.
      await _handleSignUpResult(result, ref);
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.message}');
    }
  }

  @override
  Future<void> resendCode(String email) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: email);
    } on AuthException catch (e) {
      safePrint('Error resending code: ${e.message}');
    }
  }

  @override
  Future<void> resetPassword({String? username}) async {
    try {
      final result = await Amplify.Auth.resetPassword(
        username: username ?? '',
      );
      return _handleResetPasswordResult(result);
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}');
    }
  }

  @override
  Future<void> confirmResetPassword({
    required String username,
    required String newPassword,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmResetPassword(
        username: username,
        newPassword: newPassword,
        confirmationCode: confirmationCode,
      );
      safePrint('Password reset complete: ${result.isPasswordReset}');
    } on AuthException catch (e) {
      safePrint('Error resetting password: ${e.message}');
    }
  }

  @override
  Future<void> signInUser(
    String username,
    String password, {
    WidgetRef? ref,
  }) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      await _handleSignInResult(result, ref);
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }

  Future<void> resendSingUpCode({String? username}) async {
    final resendResult = await Amplify.Auth.resendSignUpCode(
      username: username ?? '',
    );
    _handleCodeDelivery(resendResult.codeDeliveryDetails);
  }

  Future<void> _handleSignInResult(SignInResult result, WidgetRef? ref) async {
    switch (result.nextStep.signInStep) {
      case AuthSignInStep.confirmSignInWithSmsMfaCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignInStep.confirmSignInWithNewPassword:
        safePrint('Enter a new password to continue signing in');
        break;
      case AuthSignInStep.confirmSignInWithCustomChallenge:
        final parameters = result.nextStep.additionalInfo;
        final prompt = parameters['prompt']!;
        safePrint(prompt);
        break;
      // I will add later
      case AuthSignInStep.resetPassword:
        await resetPassword();
        break;
      case AuthSignInStep.confirmSignUp:
        // Resend the sign up code to the registered device.
        await resendSingUpCode();
        break;
      case AuthSignInStep.done:
        await ref?.read(appRouterProvider).replace(const HomeRoute());
        safePrint('Sign in is complete');
        break;
    }
  }

  Future<void> _handleResetPasswordResult(ResetPasswordResult result) async {
    switch (result.nextStep.updateStep) {
      case AuthResetPasswordStep.confirmResetPasswordWithCode:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthResetPasswordStep.done:
        safePrint('Successfully reset password');
        break;
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}. '
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }

  @override
  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      safePrint('Error signing out: ${e.message}');
    }
  }

  @override
  Future<void> signUpUser(
    String name,
    String email,
    String password,
    String confirmPassword, {
    String? phoneNumber,
    WidgetRef? ref,
  }) async {
    try {
      final userAttributes = {
        AuthUserAttributeKey.email: email,
        if (phoneNumber != null) AuthUserAttributeKey.phoneNumber: phoneNumber,
        AuthUserAttributeKey.name: name,
      };
      final result = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: SignUpOptions(
          userAttributes: userAttributes,
        ),
      );
      await _handleSignUpResult(result, ref);
    } on AuthException catch (e) {
      safePrint('Error signing up user: ${e.message}');
    }
  }

  Future<void> _handleSignUpResult(SignUpResult result, WidgetRef? ref) async {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        await ref?.read(appRouterProvider).push(const SignUpConfirmRoute());
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignUpStep.done:
        try {
          await ref?.read(appRouterProvider).push(const SignInRoute());
        } on AuthException catch (e) {
          if (e.message ==
              'User cannot be confirmed. Current status is CONFIRMED') {
            await ref?.read(appRouterProvider).push(const HomeRoute());
          }
          safePrint(e.message);
        }
        safePrint('Sign up is complete');
        break;
    }
  }

  Future<void> confirmUser({
    required String username,
    required String confirmationCode,
    WidgetRef? ref,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
      // Check if further confirmations are needed or if
      // the sign up is complete.
      await _handleSignUpResult(result, ref);
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.message}');
    }
  }
}
