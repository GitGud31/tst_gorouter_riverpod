import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/models/auth_state_notifier.dart';

import 'auth_screens.dart';
import 'home_screen.dart';

/*

  - root: '/' initial route that will either redirect to AuthScreen or HomeScreen.

  - auth: '/auth/:pid'
    - signin: '/auth/signin'
    - signup: '/auth/signup'
  {login, signup, initial} passed as params

  - home: '/home/:pid'
    - feed: '/home/feed'
    - categories: '/home/categories'
    - favorites: '/home/favorites'
    - settings: '/home/settings'

    {feed, categories, favorites, settings} passed as params
 */

class RootScreen extends ConsumerWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/',
      refreshListenable: ref.watch(authStateNotifier),
      redirect: (state) {
        final _isAuthenticated =
            ref.watch(authStateNotifier.notifier).isAuthenticated;
        final _goingToAuth = (state.location == '/auth/initial' ||
            state.location == '/auth/login' ||
            state.location == '/auth/signup');

        // the user is not authenticated and not headed to /auth/:pid, they need to authenticate.
        if (!_isAuthenticated && !_goingToAuth) return '/auth/initial';

        // the user is authenticated and headed to /auth/:pid, no need to authenticate again.
        if (_isAuthenticated && _goingToAuth) return '/home/feed';

        // no need to redirect at all.
        return null;
      },
      routes: [
        GoRoute(
            name: 'root',
            path: '/',
            redirect: (state) {
              final _isAuthenticated =
                  ref.watch(authStateNotifier.notifier).isAuthenticated;

              if (_isAuthenticated) return '/home/feed';
              return '/auth/initial';
            }),
        GoRoute(
          name: 'auth',
          path: '/auth/:pid',
          builder: (_, state) {
            final pageId = state.params['pid'] ?? 'initial';
            return AuthScreen(key: state.pageKey, index: pageId);
          },
        ),
        GoRoute(
          name: 'home',
          path: '/home/:pid',
          builder: (_, state) {
            final pageId = state.params['pid'] ?? 'feed';
            return HomeScreen(key: state.pageKey, index: pageId);
          },
        ),
      ],
      errorBuilder: (_, state) => ErrorScreen(state.error!),
    );
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(this.error, {Key? key}) : super(key: key);
  final Exception error;

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_router.location),
            SelectableText(error.toString()),
            TextButton(
              onPressed: () => context.goNamed('auth'),
              child: const Text('Auth'),
            ),
          ],
        ),
      ),
    );
  }
}
