import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

enum _CurrentPage { login, signup, initial }

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  final String index;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late _CurrentPage _currentPage;
  final List<Widget> _screens = [
    const LoginScreen(),
    const SignupScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentPage = _CurrentPage.initial;
  }

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter.of(context);

    _onTap(BuildContext context, String path, String param) {
      setState(() {
        (param == 'login')
            ? _currentPage = _CurrentPage.login
            : _currentPage = _CurrentPage.signup;
      });
      context.goNamed(path, params: {'pid': param});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_router.location),
      ),
      body: Builder(builder: (context) {
        if (_currentPage == _CurrentPage.login) {
          return _screens[_CurrentPage.login.index];
        }
        if (_currentPage == _CurrentPage.signup) {
          return _screens[_CurrentPage.signup.index];
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _onTap(context, 'auth', 'login'),
                child: const Text('Go to Login'),
              ),
              ElevatedButton(
                onPressed: () => _onTap(context, 'auth', 'signup'),
                child: const Text('Go to Register'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
