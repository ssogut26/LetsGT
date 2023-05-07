import 'package:flutter/material.dart';
import 'package:letsgt/config/routes/routes.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
      title: 'LetsGT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
