import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// With RoutePage annotation, this class will generate
/// the route information and add it to the app's router.
/// This is home page
@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
