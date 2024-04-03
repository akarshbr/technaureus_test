import 'package:clean_code_demo/presentation/bottom_navigation_screen/controller/bottom_navigation_controller.dart';
import 'package:clean_code_demo/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => BottomNavigationController())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationScreen(),
    );
  }
}
