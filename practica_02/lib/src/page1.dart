import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.tealAccent,
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text('Practica 02'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text('Pagina 2'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.amber, onPrimary: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/Page2');
                },
              ),
              ElevatedButton(
                child: Text('Pagina 3'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red, onPrimary: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/Page3');
                },
              ),
            ],
          ),
        ));
  }
}
