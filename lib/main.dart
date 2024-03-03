import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

import 'features/auth/controller/auth_controller.dart';
import 'firebase_options.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Reddit Tutorial',
      theme: ref.watch(themeNotifierProvider),
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          final authState = ref.watch(authStateChangeProvider);
          final userModel = ref.watch(userProvider);

          return authState.when(
            data: (user) {
              if (user != null && userModel != null) {
                return loggedInRoute;
              } else {
                return loggedOutRoute;
              }
            },
            loading: () => loggedOutRoute,
            error: (error, stackTrace) => loggedOutRoute,
          );
        },
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
