import 'package:flutter/material.dart';
import 'package:mini_proyecto_01/src/result.dart';
import 'package:mini_proyecto_01/src/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        Duration(milliseconds: 5000),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => Result(data: s)))));
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
              Image.asset('assets/images/pesos_global.jpg'),
              SizedBox(height: 50),
              CircularProgressIndicator(),
            ],
          ),
        ));
  }
}
