import 'package:flutter/material.dart';

import 'package:routemaster/routemaster.dart';

import 'features/auth/screens/home_screen.dart';
import 'features/auth/screens/login_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: HomeScreen()),
  },
);
