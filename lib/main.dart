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
      ),
      GoRoute(
        path: '/a',
        builder: (context, state) => const PageA(),
      ),
      GoRoute(
        path: '/b',
        builder: (context, state) => const PageB(),
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              debugPrint('Building shell around subroute');
              return ScaffoldWithNav(child: child);
            },
            routes: [
              GoRoute(
                path: 'c',
                builder: (context, state) => const PageC(),
              ),
              GoRoute(
                path: 'd',
                builder: (context, state) => const PageD(),
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
              onPressed: () => context.go('/b'),
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
              onPressed: () => context.go('/b/c'),
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
    return Scaffold(
      body: Column(
        children: [
          const Expanded(child: Center(child: Text('Page C'))),
          Center(
            child: ElevatedButton(
              onPressed: () => context.go('/b/d'),
              child: const Text('Go to D'),
            ),
          ),
        ],
      ),
    );
  }
}

class PageD extends StatelessWidget {
  const PageD({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(child: Center(child: Text('Page D'))),
          Center(
            child: ElevatedButton(
              onPressed: () => context.go('/b/c'),
              child: const Text('Go to C'),
            ),
          ),
        ],
      ),
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
