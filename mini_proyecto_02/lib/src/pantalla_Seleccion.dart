import 'package:flutter/material.dart';
import 'package:mini_proyecto_02/src/tablero.dart';
import 'package:sqflite/sqflite.dart';

class Pantalla extends StatefulWidget {
  const Pantalla({super.key});

  @override
  State<Pantalla> createState() => _PantallaState();
}

class _PantallaState extends State<Pantalla> {
  late String _path;
  @override
  void initState() {
    super.initState();
    _createDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eliga una opcion'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                numCarta = 8;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => tablero(
                        //mandamos lo datos
                        )));
              },
              child: Text('8'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue, onPrimary: Colors.white),
            ),
            ElevatedButton(
              onPressed: () {
                numCarta = 10;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => tablero(
                        //mandamos lo datos
                        )));
              },
              child: Text('10'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue, onPrimary: Colors.white),
            ),
            ElevatedButton(
              onPressed: () {
                numCarta = 12;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => tablero(
                        //mandamos lo datos
                        )));
              },
              child: Text('12'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue, onPrimary: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _createDB() async {
    var dbpath = await getDatabasesPath();

    _path = '{$dbpath}my_db.db';

    database = await openDatabase(_path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE mayor (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT, result TEXT)');
    });
  }
}
