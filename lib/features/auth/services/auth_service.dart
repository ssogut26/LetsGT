import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

abstract class AmplifyAuthService {
  String? requestToken;
  Future<void> signInUser(
    String username,
    String password,
  );
  Future<void> signUpUser(
    String name,
    String email,
    String? phoneNumber,
    String password,
    String confirmPassword,
  );
  Future<void> confirmSignUp(
    String email,
    String code,
    BuildContext context,
    AuthenticatorState authState,
  );
  Future<void> resendCode(String email, BuildContext context);
  Future<void> signOut();
  Future<void> resetPassword();
}

class AuthService implements AmplifyAuthService {
  factory AuthService() => _instance;
  AuthService._();
  static final AuthService _instance = AuthService._();

  @override
  String? requestToken;

  @override
  Future<void> confirmSignUp(
    String email,
    String code,
    BuildContext context,
    AuthenticatorState authState,
  ) {
    // TODO: implement confirmSignUp
    throw UnimplementedError();
  }

  @override
  Future<void> resendCode(String email, BuildContext context) {
    // TODO: implement resendCode
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword() {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signInUser(String username, String password) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      await _handleSignInResult(result);
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }

  Future<void> _handleSignInResult(SignInResult result) async {
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
      // case AuthSignInStep.resetPassword:
      //   final resetResult = await Amplify.Auth.resetPassword(
      //     username: username,
      //   );
      //   await _handleResetPasswordResult(resetResult);
      //   break;
      // case AuthSignInStep.confirmSignUp:
      //   // Resend the sign up code to the registered device.
      //   final resendResult = await Amplify.Auth.resendSignUpCode(
      //     username: username,
      //   );
      //   _handleCodeDelivery(resendResult.codeDeliveryDetails);
      //   break;
      case AuthSignInStep.done:
        safePrint('Sign in is complete');
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
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUpUser(
    String name,
    String email,
    String? phoneNumber,
    String password,
    String confirmPassword,
  ) async {
    try {
      final userAttributes = {
        AuthUserAttributeKey.email: email,
        if (phoneNumber != null) AuthUserAttributeKey.phoneNumber: phoneNumber,
        // additional attributes as needed
      };
      final result = await Amplify.Auth.signUp(
        username: name,
        password: password,
        options: SignUpOptions(
          userAttributes: userAttributes,
        ),
      );
      await _handleSignUpResult(result);
    } on AuthException catch (e) {
      safePrint('Error signing up user: ${e.message}');
    }
  }

  Future<void> _handleSignUpResult(SignUpResult result) async {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignUpStep.done:
        safePrint('Sign up is complete');
        break;
    }
  }

  Future<void> confirmUser({
    required String username,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
      // Check if further confirmations are needed or if
      // the sign up is complete.
      await _handleSignUpResult(result);
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.message}');
    }
  }
}
