import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/config/routes/routes.dart';
import 'package:letsgt/core/usecases/paddings.dart';
import 'package:letsgt/features/auth/presentation/pages/confirm_reset_password.dart';
import 'package:letsgt/features/auth/presentation/pages/sign_up.dart';
import 'package:letsgt/features/auth/services/auth_service.dart';

class ResetPasswordNotifier extends ChangeNotifier {
  String _email = '';
  bool isLoading = false;

  String get email => _email;

  set setEmail(String email) {
    _email = email;
  }

  Future<void> forgotPassword(WidgetRef ref, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await MyAuthService()
        .resetPassword(
      username: _email,
      ref: ref,
      context: context,
    )
        .whenComplete(
      () {
        isLoading = false;
        notifyListeners();
      },
    );
  }
}

final resetPasswordProvider = ChangeNotifierProvider(
  (ref) => ResetPasswordNotifier(),
);

@RoutePage()
class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetPassword = ref.watch(resetPasswordProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            resizableHeightBox(
              context,
              keyboardClosedHeight: 0.2,
            ),
            const FlutterLogo(
              size: 35,
            ),
            resizableHeightBox(context),
            const Column(
              children: [
                Text('Forgot Password'),
                Text('Enter your email to reset your password'),
              ],
            ),
            resizableHeightBox(context),
            Column(
              children: [
                ResetEmailField(
                  isConfirm: false,
                  text: resetPassword.email,
                ),
                resizableHeightBox(context),
                AppElevatedButton(
                  isLoading: resetPassword.isLoading,
                  text: 'SEND',
                  onPressed: () {
                    ref
                        .read(resetPasswordProvider.notifier)
                        .forgotPassword(ref, context);
                  },
                ),
              ],
            ),
            resizableHeightBox(context),
            TextButton(
              onPressed: () {
                AutoRouter.of(context).replace(const SignInRoute());
              },
              child: const Text('Back to Sign In'),
            ),
            resizableHeightBox(
              context,
              keyboardClosedHeight: 0.05,
            ),
          ],
        ),
      ),
    );
  }
}

class ResetEmailField extends ConsumerWidget {
  const ResetEmailField({
    super.key,
    this.isConfirm,
    this.text,
  });

  final bool? isConfirm;
  final String? text;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: AppPaddings.fieldAndButtonPadding,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: (isConfirm ?? false) ? text : 'Email',
              enabled: !(isConfirm ?? false),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            validator: (String? value) {
              if ((value?.isEmpty ?? true) || value == null) {
                return 'Please enter your email';
              } else if (!value.contains('@')) {
                return 'Your email is missing an @';
              } else if (!value.contains('.')) {
                return 'Your email is missing a dot';
              } else if (value.contains(' ')) {
                return 'Your email cannot contain spaces';
              }
              return null;
            },
            onChanged: (String value) {
              ref.read(resetPasswordProvider).setEmail = value;
            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.emailAddress,
            enableSuggestions: true,
            textInputAction: TextInputAction.next,
          ),
        ),
      ),
    );
  }
}
