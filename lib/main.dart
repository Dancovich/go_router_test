import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _routeConfig = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const InitialPage(),
        routes: [
          GoRoute(
            path: 'a',
            builder: (context, state) => const PageA(),
            routes: [
              GoRoute(
                path: 'b',
                builder: (context, state) => const PageB(),
                routes: [
                  GoRoute(
                    path: 'c',
                    builder: (context, state) => const PageC(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _routeConfig,
      theme: ThemeData(
        brightness: Brightness.light,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          },
        ),
      ),
    );
  }
}

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(child: Center(child: Text('Initial route'))),
          Center(
            child: ElevatedButton(
              onPressed: () => context.go('/a'),
              child: const Text('Go to A'),
            ),
          ),
        ],
      ),
    );
  }
}

class PageA extends StatelessWidget {
  const PageA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(child: Center(child: Text('Page A'))),
          Center(
            child: ElevatedButton(
              onPressed: () => context.go('/a/b'),
              child: const Text('Go to B'),
            ),
          ),
        ],
      ),
    );
  }
}

class PageB extends StatelessWidget {
  const PageB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(child: Center(child: Text('Page B'))),
          Center(
            child: ElevatedButton(
              onPressed: () => context.go('/a/b/c'),
              child: const Text('Go to C'),
            ),
          ),
        ],
      ),
    );
  }
}

class PageC extends StatelessWidget {
  const PageC({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Page C')),
    );
  }
}

class ScaffoldWithNav extends StatelessWidget {
  const ScaffoldWithNav({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(child: child);
  }
}
