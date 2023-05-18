import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/config/routes/routes.dart';
import 'package:letsgt/core/usecases/paddings.dart';
import 'package:letsgt/features/auth/presentation/providers/sign_up_providers.dart';

@RoutePage()
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: AppPaddings.pagePadding,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  const FlutterLogo(
                    size: 35,
                  ),
                  const Column(
                    children: [
                      NameField(),
                      SignUpEmailField(),
                      PhoneField(),
                      PasswordField(),
                      ConfirmPasswordField(),
                    ],
                  ),
                  AppElevatedButton(
                    text: 'SIGN ME UP',
                    onPressed: () {
                      try {
                        if (formKey.currentState?.validate() ?? false) {
                          formKey.currentState?.save();
                          ref.read(signUpProvider).signUp(ref, context);
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in the form'),
                          ),
                        );
                      }
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Already have an account?',
                    ),
                    onPressed: () {
                      AutoRouter.of(context).replace(
                        const SignInRoute(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NameField extends ConsumerWidget {
  const NameField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: AppPaddings.fieldAndButtonPadding,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onChanged: (String value) {
              ref.read(signUpProvider).setName = value;
            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.name,
            enableSuggestions: true,
            textInputAction: TextInputAction.next,
          ),
        ),
      ),
    );
  }
}

class IsPasswordVisibleNotifier extends StateNotifier<bool> {
  IsPasswordVisibleNotifier() : super(false);

  bool get isVisible => state;

  set isVisible(bool value) {
    state = value;
  }
}

final isPasswordVisibleProvider =
    StateNotifierProvider<IsPasswordVisibleNotifier, bool>(
  (ref) => IsPasswordVisibleNotifier(),
);

class IsConfirmPasswordVisibleNotifier extends StateNotifier<bool> {
  IsConfirmPasswordVisibleNotifier() : super(false);

  bool get isVisible => state;

  set isVisible(bool value) {
    state = value;
  }
}

final isConfirmPasswordVisibleProvider =
    StateNotifierProvider<IsConfirmPasswordVisibleNotifier, bool>(
  (ref) => IsConfirmPasswordVisibleNotifier(),
);

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
                focusNode: FocusNode(skipTraversal: true),
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
              ref.read(passwordProvider.notifier).password = value;
              ref.read(signUpProvider).setPassword = value;
            },
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

class PasswordNotifier extends StateNotifier<String> {
  PasswordNotifier() : super('');

  String get password => state;

  set password(String value) {
    state = value;
  }
}

final passwordProvider = StateNotifierProvider<PasswordNotifier, String>(
  (ref) => PasswordNotifier(),
);

class ConfirmPasswordField extends ConsumerWidget {
  const ConfirmPasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(isConfirmPasswordVisibleProvider);
    return Center(
      child: Padding(
        padding: AppPaddings.fieldAndButtonPadding,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              suffixIcon: IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  ref
                      .read(isConfirmPasswordVisibleProvider.notifier)
                      .isVisible = !ref.read(isConfirmPasswordVisibleProvider);
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
                return 'Please enter your password again';
              } else if (value !=
                  ref.read(passwordProvider.notifier).password) {
                return 'Your passwords do not match';
              }
              return null;
            },
            onChanged: (String value) {
              ref.read(signUpProvider).setConfirmPassword = value;
            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.visiblePassword,
            obscureText: !isVisible,
            textInputAction: TextInputAction.done,
          ),
        ),
      ),
    );
  }
}

class SignUpEmailField extends ConsumerWidget {
  const SignUpEmailField({
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
              ref.read(signUpProvider).setEmail = value;
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

class PhoneField extends ConsumerWidget {
  const PhoneField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: AppPaddings.fieldAndButtonPadding,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              hintText: 'e.g. +1 123 456 7890',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            validator: (String? value) {
              if ((value?.isEmpty ?? true) || value == null) {
                return 'Please enter your phone number';
              } else if (value.contains(' ')) {
                return 'Your phone number cannot contain spaces';
              } else if (RegExp(r'^[0-9]*$').hasMatch(value)) {
                return 'Your phone number cannot contain letters';
              } else if (value.contains('-')) {
                return 'Your phone number cannot contain dashes';
              }
              return null;
            },
            onChanged: (String value) {
              ref.read(signUpProvider).setPhone = value;
            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.phone,
            enableSuggestions: true,
            textInputAction: TextInputAction.next,
          ),
        ),
      ),
    );
  }
}

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });
  final String text;
  final bool isLoading;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
          MediaQuery.of(context).size.width * 0.75,
          MediaQuery.of(context).size.height * 0.07,
        ),
        backgroundColor: const Color(0xFF3D3BEE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: isLoading
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(
              text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
    );
  }
}
