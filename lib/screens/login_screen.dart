import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/models/auth_state_notifier.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(
        builder: (context, ref, child) {
          return TextButton(
            onPressed: () {
              ref.watch(authStateNotifier.notifier).authenticate();
            },
            child: const Text('Login'),
          );
        },
      ),
    );
  }
}
