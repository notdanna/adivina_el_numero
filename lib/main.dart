
import 'package:flutter/material.dart';
import 'game_screen.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adivina el número',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const PantallaJuego(),
    );
  }
}