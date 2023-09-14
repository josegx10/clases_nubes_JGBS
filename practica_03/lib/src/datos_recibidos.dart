import 'package:flutter/material.dart';
import 'package:practica_03/src/home_page.dart';

class DatosPage extends StatelessWidget {
  final Data data;
  DatosPage({required this.data}); //el nuevo flutter requiere que sea asi
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Datos Recibidos'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Los datos son:'),
              Text('Nombre: ${data.texto}'),
              Text('Sexo: ${data.sexo}')
            ],
          ),
        ));
  }
}
