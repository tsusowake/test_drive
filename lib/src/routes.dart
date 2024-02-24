import 'package:go_router/go_router.dart';
import 'package:test_drive/src/screens/account.dart';
import 'package:test_drive/src/screens/app_scaffold.dart';
import 'package:test_drive/src/screens/home.dart';
import 'package:test_drive/src/screens/library.dart';

GoRouter createRouter() {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return AppScaffold(
            selectedIndex: switch (state.uri.path) {
              var p when p.startsWith('/home') => 0,
              var p when p.startsWith('/library') => 1,
              var p when p.startsWith('/account') => 2,
              _ => 0,
            },
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const Home(),
          ),
          GoRoute(
            path: '/library',
            builder: (context, state) => const Library(),
          ),
          GoRoute(
            path: '/account',
            builder: (context, state) => const Account(),
          ),
        ],
      ),
    ],
  );
}
