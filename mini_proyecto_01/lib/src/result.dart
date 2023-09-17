import 'package:flutter/material.dart';
import 'package:mini_proyecto_01/src/home_page.dart';

class Result extends StatelessWidget {
  final Data data;
  Result({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Resultado IMC'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, int.parse(s.color1),
              int.parse(s.color2), int.parse(s.color3)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/${data.img}'),
              Text('Los datos son:'),
              Text('El IMC es: ${data.imc}'),
              Text('La Clasificación es: ${data.resul}'),
            ],
          ),
        ));
  }
}
