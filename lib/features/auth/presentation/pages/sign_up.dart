import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letsgt/core/usecases/paddings.dart';
import 'package:letsgt/features/auth/services/auth_service.dart';

class SignUpNotifier extends ChangeNotifier {
  String _name = '';
  String _email = '';
  String _phone = '';
  String _password = '';
  String _confirmPassword = '';

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get password => _password;
  String get confirmPassword => _confirmPassword;

  set setName(String name) {
    _name = name;
  }

  set setEmail(String email) {
    _email = email;
  }

  set setPhone(String phone) {
    _phone = phone;
  }

  set setPassword(String password) {
    _password = password;
  }

  set setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
  }

  Future<void> signUp(WidgetRef ref) async {
    await MyAuthService()
        .signUpUser(name, email, password, confirmPassword, ref: ref);
  }
}

final signUpProvider = ChangeNotifierProvider<SignUpNotifier>((ref) {
  return SignUpNotifier();
});

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
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              const FlutterLogo(
                size: 35,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              const NameField(),
              const EmailField(),
              const PhoneField(),
              const PasswordField(),
              const ConfirmPasswordField(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              AppElevatedButton(
                text: 'SIGN ME UP',
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    ref.read(signUpProvider).signUp(ref);
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextButton(
                child: const Text(
                  'Already have an account?',
                  style: TextStyle(
                    color: Color(0xFF656589),
                  ),
                ),
                onPressed: () {},
              ),
            ],
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
              } else if (value != ref.read(passwordProvider.notifier).state) {
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
    super.key,
  });
  final String text;
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
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
