import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfirebase/provider/auth_provider.dart';
import 'package:myfirebase/screens/auth/signup/sign_up_screen.dart';
import 'package:myfirebase/screens/home/home_screen.dart';
import 'package:myfirebase/widgets/app_snackbar.dart';
import 'package:myfirebase/widgets/text_input_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _sandiController = TextEditingController();

  void _login() async {
    await ref.read(authProvider.notifier).loginUser(
          _emailController.text,
          _sandiController.text,
        );

    final user = ref.read(authProvider);
    if (user is AsyncData && user.value != null) {
      navigateToHome();
    } else if (user is AsyncError) {
      if (mounted) {
        AppSnackbar.error(
          context: context,
          message: user.error.toString(),
        );
      }
    }
  }

  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dummy Code',
              style: TextStyle(
                fontSize: 35,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _emailController,
                labelText: 'Email',
                icon: Icons.email,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _sandiController,
                labelText: 'Kata Sandi',
                icon: Icons.lock,
                isObscure: true,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: InkWell(
                onTap: _login,
                child: Center(
                  child: authState is AsyncLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          strokeWidth: 2,
                          strokeCap: StrokeCap.round,
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Belum mempunyai akun ? ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                InkWell(
                  onTap: () {
                    debugPrint('navigate ke register page');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
