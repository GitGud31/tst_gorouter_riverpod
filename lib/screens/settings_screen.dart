import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/models/auth_state_notifier.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Settings Screen'),
          Consumer(
            builder: (context, ref, child) {
              return TextButton(
                onPressed: () {
                  ref.watch(authStateNotifier.notifier).logout();
                },
                child: const Text('Logout'),
              );
            },
          ),
        ],
      ),
    );
  }
}
