import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/features/auth/presentation/pages/sign_up.dart';
import 'package:letsgt/features/auth/presentation/providers/sign_up_confirm.dart';
import 'package:letsgt/features/auth/presentation/providers/sign_up_providers.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom == 0
                ? MediaQuery.of(context).size.height * 0.1
                : MediaQuery.of(context).size.height * 0.01,
          ),
          const FlutterLogo(
            size: 35,
          ),
          Column(
            children: [
              SignUpEmailField(
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
            ],
          ),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  ref.read(signUpConfirmProvider.notifier).resendCode(email);
                },
                child: const Text('Resend code'),
              ),
              AppElevatedButton(
                isLoading: ref.watch(signUpConfirmProvider).isLoading,
                onPressed: () {
                  ref.read(signUpConfirmProvider.notifier).confirm(ref, email);
                },
                text: 'Confirm',
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom == 0
                ? MediaQuery.of(context).size.height * 0.1
                : MediaQuery.of(context).size.height * 0.01,
          ),
        ],
      ),
    );
  }
}
