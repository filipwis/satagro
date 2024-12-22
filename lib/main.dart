import 'package:flutter/material.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:satagro/core/di/di_config.dart';
import 'package:satagro/presentation/navigation/router.dart';

Future<void> main() async {
  await configureDependencies();
  runApp(
    HookedBlocConfigProvider(
      injector: () => getIt.get,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
