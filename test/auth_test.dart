import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAmplifyAuthCognito extends Mock implements AmplifyAuthCognito {
  @override
  Future<CognitoSignInResult> signIn({
    required String username,
    SignInOptions? options,
    String? password,
  }) async {
    return const CognitoSignInResult(
      isSignedIn: true,
      nextStep: AuthNextSignInStep(
        signInStep: AuthSignInStep.done,
      ),
    );
  }

  @override
  Future<CognitoSignUpResult> signUp({
    required String username,
    required String password,
    SignUpOptions? options,
  }) async {
    return const CognitoSignUpResult(
      isSignUpComplete: true,
      nextStep: AuthNextSignUpStep(
        signUpStep: AuthSignUpStep.done,
      ),
    );
  }

  @override
  Future<CognitoSignUpResult> confirmSignUp({
    required String username,
    required String confirmationCode,
    ConfirmSignUpOptions? options,
  }) async {
    return const CognitoSignUpResult(
      isSignUpComplete: true,
      nextStep: AuthNextSignUpStep(
        signUpStep: AuthSignUpStep.done,
      ),
    );
  }

  @override
  Future<CognitoResetPasswordResult> resetPassword({
    required String username,
    ResetPasswordOptions? options,
  }) async {
    return const CognitoResetPasswordResult(
      isPasswordReset: true,
      nextStep: ResetPasswordStep(
        updateStep: AuthResetPasswordStep.done,
      ),
    );
  }

  @override
  Future<CognitoResetPasswordResult> confirmResetPassword({
    required String username,
    required String newPassword,
    required String confirmationCode,
    ConfirmResetPasswordOptions? options,
  }) async {
    return const CognitoResetPasswordResult(
      isPasswordReset: true,
      nextStep: ResetPasswordStep(
        updateStep: AuthResetPasswordStep.done,
      ),
    );
  }
}

void main() {
  group(
    'Amplify Auth',
    () {
      test('Sign In', () async {
        final mockAuth = MockAmplifyAuthCognito();
        final result = await mockAuth.signIn(
          username: 'test@test.com',
          password: 'test123.',
        );
        expect(result.isSignedIn, true);
      });
      test('Sign Up', () async {
        final mockAuth = MockAmplifyAuthCognito();
        final result = await mockAuth.signUp(
          username: 'test@test.com',
          password: 'test123.',
        );
        expect(result.isSignUpComplete, true);
      });
      test('Confirm Sign Up', () async {
        final mockAuth = MockAmplifyAuthCognito();
        final result = await mockAuth.confirmSignUp(
          username: 'test@test.com',
          confirmationCode: '123456',
        );
        expect(result.isSignUpComplete, true);
      });
      test('Reset Password', () async {
        final mockAuth = MockAmplifyAuthCognito();
        final result = await mockAuth.resetPassword(
          username: 'test@test.com',
        );
        expect(result.isPasswordReset, true);
      });
      test('Confirm Reset Password', () async {
        final mockAuth = MockAmplifyAuthCognito();
        final result = await mockAuth.confirmResetPassword(
          username: 'test@test.com',
          newPassword: 'Test123.',
          confirmationCode: '123456',
        );
        expect(result.isPasswordReset, true);
      });
    },
  );
}
