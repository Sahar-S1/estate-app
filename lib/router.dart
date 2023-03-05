import 'package:go_router/go_router.dart';

import 'package:estate/models/property.dart';
import 'package:estate/pages/home.dart';
import 'package:estate/pages/properties.dart';
import 'package:estate/pages/property.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'properties',
          builder: (context, state) => const PropertiesPage(),
          routes: [
            GoRoute(
              path: 'property',
              builder: (context, state) => PropertyPage(
                property: state.extra! as Property,
              ),
            ),
          ],
        ),
      ],
    ),
  ],
  debugLogDiagnostics: true,
);
