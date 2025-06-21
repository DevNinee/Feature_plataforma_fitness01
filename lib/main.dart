import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Olá, Flutter!'),
        ),
        body: const Center(
          child: Text('Seu app está rodando!'),
        ),
      ),
    );
  }
}
