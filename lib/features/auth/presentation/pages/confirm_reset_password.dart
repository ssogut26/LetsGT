import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/core/usecases/paddings.dart';
import 'package:letsgt/features/auth/presentation/pages/reset_password.dart';
import 'package:letsgt/features/auth/presentation/pages/sign_up.dart';
import 'package:letsgt/features/auth/services/auth_service.dart';

class ConfirmResetPasswordNotifier extends ChangeNotifier {
  String _code = '';
  String email = '';
  String _password = '';

  String get code => _code;
  String get password => _password;
  set setCode(String code) {
    _code = code;
  }

  set setPassword(String password) {
    _password = password;
  }

  Future<void> resendCode(String email) async {
    await MyAuthService().resendCode(email);
  }

  Future<void> confirmResetPassword(WidgetRef ref, String email) async {
    await MyAuthService().confirmResetPassword(
      username: email,
      confirmationCode: _code,
      newPassword: _password,
    );
  }
}

final resetPasswordConfirmProvider = ChangeNotifierProvider(
  (ref) => ConfirmResetPasswordNotifier(),
);

@RoutePage()
class ConfirmResetPasswordPage extends ConsumerWidget {
  const ConfirmResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(resetPasswordProvider).email;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          const FlutterLogo(
            size: 35,
          ),
          Column(
            children: [
              ResetEmailField(
                isConfirm: true,
                text: email,
              ),
              Padding(
                padding: AppPaddings.fieldAndButtonPadding,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Confirmation Code',
                    ),
                    onChanged: (value) {
                      ref.read(resetPasswordConfirmProvider.notifier).setCode =
                          value;
                    },
                  ),
                ),
              ),
              const ResetPasswordField(),
            ],
          ),
          TextButton(
            onPressed: () {
              ref.read(resetPasswordConfirmProvider.notifier).resendCode(email);
            },
            child: const Text('Resend code'),
          ),
          AppElevatedButton(
            onPressed: () {
              ref
                  .read(resetPasswordConfirmProvider.notifier)
                  .confirmResetPassword(ref, email);
            },
            text: 'Confirm',
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ],
      ),
    );
  }
}

class ResetPasswordField extends ConsumerWidget {
  const ResetPasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(isPasswordVisibleProvider);
    return Center(
      child: Padding(
        padding: AppPaddings.fieldAndButtonPadding,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  ref.read(isPasswordVisibleProvider.notifier).isVisible =
                      !ref.read(isPasswordVisibleProvider);
                },
                icon: isVisible
                    ? const Icon(Icons.visibility_outlined)
                    : const Icon(Icons.visibility_off),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            validator: (String? value) {
              if ((value?.isEmpty ?? true) || value == null) {
                return 'Please enter your password';
              } else if (value.length < 8) {
                return 'Your password must be at least 8 characters long';
              }
              return null;
            },
            onChanged: (String value) {
              ref.read(resetPasswordConfirmProvider).setPassword = value;
            },
            autofillHints: const [AutofillHints.password],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.visiblePassword,
            obscureText: !isVisible,
            textInputAction: TextInputAction.next,
          ),
        ),
      ),
    );
  }
}
