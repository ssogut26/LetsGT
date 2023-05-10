import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/config/routes/routes.dart';
import 'package:letsgt/core/usecases/paddings.dart';
import 'package:letsgt/features/auth/presentation/pages/sign_up.dart';
import 'package:letsgt/features/auth/presentation/providers/sign_in_providers.dart';

@RoutePage()
class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: AppPaddings.pagePadding,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const FlutterLogo(
                size: 35,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const EmailField(),
              const PasswordField(),
              AppElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ref.read(signInProvider.notifier).signIn(ref, context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in the form'),
                      ),
                    );
                  }
                },
                text: 'Sign In',
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?'),
              ),
              TextButton(
                child: const Text('Already have an account?'),
                onPressed: () {
                  AutoRouter.of(context).push(const SignUpRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailField extends ConsumerWidget {
  const EmailField({
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
              ref.read(signInProvider).setEmail = value;
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

class PasswordField extends ConsumerWidget {
  const PasswordField({
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
              ref.read(signInProvider).setPassword = value;
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
