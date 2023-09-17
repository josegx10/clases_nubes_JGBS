import 'package:flutter/material.dart';
import 'package:mini_proyecto_01/src/splash_screen.dart';

Data s = Data(resul: '', imc: '', img: '', color1: '', color2: '', color3: '');

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ctrlPeso = new TextEditingController();
  final ctrlAltura = new TextEditingController();
  final data =
      new Data(resul: '', imc: '', img: '', color1: '', color2: '', color3: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 53, 26, 209),
        title: Text('Mini proyecto 01: IMC'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/calculo.png'),
            SizedBox(height: 20),
            TextField(
              controller: ctrlPeso,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Ingresa el peso (Kg)',
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: ctrlAltura,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Ingresa el altura (Metros)',
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 63, 35, 167),
                  onPrimary: Colors.white),
              child: Text('Enviar'),
              onPressed: () {
                setState(() {
                  var peso = double.parse(ctrlPeso.text);
                  var altura = double.parse(ctrlAltura.text);
                  double _imc = peso / (altura * altura);
                  data.imc = _imc.toStringAsFixed(2);

                  if (_imc < 18) {
                    data.resul = 'peso bajo';
                    data.img = 'peso_bajo.PNG';
                    data.color1 = '38';
                    data.color2 = '205';
                    data.color3 = '232';
                  } else if (_imc < 25) {
                    data.resul = 'normal';
                    data.img = 'normal.PNG';
                    data.color1 = '150';
                    data.color2 = '204';
                    data.color3 = '29';
                  } else if (_imc < 27) {
                    data.resul = 'obesidad';
                    data.img = 'obesidad.PNG';
                    data.color1 = '246';
                    data.color2 = '204';
                    data.color3 = '42';
                  } else if (_imc < 30) {
                    data.resul = 'obesidad grado 1';
                    data.img = 'obesidad_1.PNG';
                    data.color1 = '233';
                    data.color2 = '128';
                    data.color3 = '19';
                  } else if (_imc < 40) {
                    data.resul = 'obesidad grado 2';
                    data.img = 'obesidad_2.PNG';
                    data.color1 = '232';
                    data.color2 = '89';
                    data.color3 = '21';
                  } else {
                    data.resul = 'obesidad grado 3';
                    data.img = 'obesidad_3.PNG';
                    data.color1 = '201';
                    data.color2 = '56';
                    data.color3 = '61';
                  }
                  s = data;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SplashScreen(
                          //mandamos lo datos
                          )));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Data {
  String resul;
  String imc;
  String img;
  String color1, color2, color3;
  Data(
      {required this.resul,
      required this.imc,
      required this.img,
      required this.color1,
      required this.color2,
      required this.color3});
}
