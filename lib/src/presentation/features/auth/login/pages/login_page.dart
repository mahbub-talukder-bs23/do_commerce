import 'package:do_commerce/src/presentation/core/widgets/loading_indicator.dart';
import 'package:do_commerce/src/presentation/features/auth/login/widgets/password_field.dart';
import 'package:do_commerce/src/presentation/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/login_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> obsecureText = ValueNotifier<bool>(true);

  final userName = TextEditingController(text: 'sophiab');
  final passwordController = TextEditingController(text: 'sophiabpass');

  @override
  void initState() {
    super.initState();
    ref.listenManual(loginProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      } else if (next is AsyncData) {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const HomePage()));
      }
    });
  }

  @override
  void dispose() {
    userName.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onTap() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(loginProvider.notifier)
          .login(
            userName: userName.text.trim(),
            password: passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'DO COMMERCE',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Login to your account',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 66),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: userName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'User Name',
                      ),
                    ),
                    const SizedBox(height: 16),
                    PasswordField(controller: passwordController),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onTap,
                child: state.isLoading
                    ? const LoadingIndicator()
                    : const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
