import 'package:flutter/material.dart';
import 'package:mini_proyecto_02/src/pantalla_Seleccion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Pantalla(),
    );
  }
}
