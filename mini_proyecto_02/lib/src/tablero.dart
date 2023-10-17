import 'dart:math';
import 'package:mini_proyecto_02/src/splash_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

int numCarta = 0;
late Database database;

class tablero extends StatefulWidget {
  const tablero({super.key});

  @override
  State<tablero> createState() => _tableroState();
}

class _tableroState extends State<tablero> {
  int comparar = -1;
  int cont = 0;
  int ronda = 0;
  int total = 0;
  List<int> resultados = List.filled(numCarta, -1);
  String resul = '';
  List<String> img = [
    'arch',
    'debian',
    'deepin',
    'fedora',
    'kali',
    'manjaro',
    'mint',
    'mx',
    'popos',
    'redhat',
    'ubuntu',
    'zorin'
  ];
  List<bool> isFlipped = List.filled(numCarta * 2, false);
  List<String> indImg = List.filled(numCarta * 2, '');
  List<int> numImg = List.filled(numCarta * 2, 0);
  @override
  void initState() {
    List<int> num = List.filled(numCarta * 2, 0);
    super.initState();
    _insertDB();
    for (int i = 0; i < numCarta * 2; i++) {
      int d = (((i) / 2)).round() - (i % 2);
      indImg[i] = img[d];
      numImg[i] = d;
      num[i] = i;
    }
    num.shuffle(Random());
    for (int i = 0; i < numCarta * 2; i++) {
      String auxImg = indImg[i];
      int auxNum = numImg[i];

      indImg[i] = indImg[num[i]];
      numImg[i] = numImg[num[i]];

      indImg[num[i]] = auxImg;
      numImg[num[i]] = auxNum;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Total: $total Puntaje: $cont record: ${resul != '-1' ? resul : 'null'}'),
          centerTitle: true,
        ),
        body: GridView.builder(
          itemCount: numCarta * 2,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (BuildContext context, int index) {
            // Calculate the row and column for the item

            return GridTile(
              child: GestureDetector(
                onTap: () {
                  // Handle tap to flip the card
                  setState(() {
                    print('comparar: $comparar cont: $cont ronda: $ronda');
                    if (!resultados.contains(numImg[index])) {
                      isFlipped[index] = true;

                      ronda++;
                      if (ronda % 2 == 0) {
                        _pausarPorUnMomento(index);
                        cont++;
                      } else {
                        comparar = index;
                      }
                    }
                  });
                },
                child: Container(
                  width: 200.0,
                  height: 300.0,
                  alignment: Alignment.center,
                  child: isFlipped[index]
                      ? Image.asset(
                          'assets/img/${indImg[index]}.png') // Reemplaza con la ruta de tu imagen
                      : Image.asset(
                          'assets/img/linux.png'), // Reemplaza con la ruta de tu imagen
                ),
              ),
            );
          },
        ));
  }

  Future<void> _pausarPorUnMomento(int i) async {
    print('Iniciando...');

    if (numImg[comparar] == numImg[i]) {
      resultados[total] = numImg[i];
      total++;
      if (total == numCarta) {
        print('Ya gano con un total de intentos de $cont');
        if (cont < int.parse(resul) || resul == '-1') {
          _updateDB();
        } else {
          print('No le gano al record');
        }
        Future.delayed(
            Duration(milliseconds: 3000),
            () => Navigator.push(context,
                MaterialPageRoute(builder: ((context) => SplashScreen()))));
      }
    } else {
      await Future.delayed(Duration(seconds: 1)); // Pausa por 2 segundos
      isFlipped[i] = false;
      isFlipped[comparar] = false;
    }
    print('Pausa terminada.');

    // Continuar con el código después de la pausa
  }

  void _insertDB() async {
    List<Map> d = await database.rawQuery(
        'SELECT name,result FROM mayor WHERE name = ?', ['$numCarta']);
    if (d.length == 0) {
      await database.transaction((txn) async {
        int reg2 = await txn.rawInsert(
            'INSERT INTO mayor (name, result) VALUES (?,?)',
            ['$numCarta', '-1']);
        print('Insert $reg2');
      });
    } else {
      print('el resultado ya esta registrado');
      resul = d[0]['result'];
    }
  }

  void _showDB() async {
    List<Map> show = await database.rawQuery('SELECT name,result FROM mayor');
    print(show[0]['result']);
  }

  void _updateDB() async {
    int upt = await database.rawUpdate(
        'UPDATE mayor SET result = ? WHERE name = ?', ['$cont', '$numCarta']);
    print('Update: $upt');
  }
}
