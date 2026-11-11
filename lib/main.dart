import 'package:flutter/material.dart';
import 'game_page.dart';

void main() {
  runApp(const NuttyApp());
}

class NuttyApp extends StatelessWidget {
  const NuttyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Don't Touch the Squirrel",
      theme: ThemeData(fontFamily: 'Roboto', useMaterial3: true),
      home: const GamePage(),
    );
  }
}
