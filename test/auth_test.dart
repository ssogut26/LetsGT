import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
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
}

void main() {
  group('Amplify Auth', () {
    test('Sign In', () async {
      final mockAuth = MockAmplifyAuthCognito();

      final result = await mockAuth.signIn(
        username: 'ssogutdev@gmail.com',
        password: 'Test123.s',
      );

      expect(result.isSignedIn, true);
      await Amplify.addPlugin(mockAuth);
      final res = await Amplify.Auth.signIn(
        username: 'ssogutdev@gmail.com',
        password: 'Test123.',
      );

      expect(res.isSignedIn, true);
    });
  });
}
