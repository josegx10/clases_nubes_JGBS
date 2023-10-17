import 'package:flutter/material.dart';
import 'package:mini_proyecto_02/src/pantalla_Seleccion.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        Duration(milliseconds: 3000),
        () => Navigator.push(
            context, MaterialPageRoute(builder: ((context) => Pantalla()))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/img/linux.jpg'),
              SizedBox(height: 50),
              Text('Ya haz ganado'),
              SizedBox(height: 50),
              CircularProgressIndicator(),
            ],
          ),
        ));
  }
}
