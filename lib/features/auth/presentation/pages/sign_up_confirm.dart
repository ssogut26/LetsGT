import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/features/auth/presentation/pages/sign_up.dart';
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

@RoutePage()
class SignUpConfirmPage extends ConsumerWidget {
  const SignUpConfirmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.read(signUpProvider.notifier).email;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Sign Up'),
      ),
      body: Column(
        children: [
          EmailField(
            isConfirm: true,
            text: email,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Confirmation Code',
              ),
              onChanged: (value) {
                ref.read(signUpConfirmProvider.notifier).setCode = value;
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextButton(
            onPressed: () {
              ref.read(signUpConfirmProvider.notifier).resendCode(email);
            },
            child: const Text('Resend code'),
          ),
          const SizedBox(
            height: 5,
          ),
          AppElevatedButton(
            onPressed: () {
              ref.read(signUpConfirmProvider.notifier).confirm(ref, email);
            },
            text: 'Confirm',
          ),
        ],
      ),
    );
  }
}
