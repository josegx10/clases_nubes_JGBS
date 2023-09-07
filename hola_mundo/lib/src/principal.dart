import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _valor = 0;
  void _incrementar() {
    setState(() {
      _valor++;
    });
  }

  void _decrementar() {
    setState(() {
      _valor--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi primera app en Flutter'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [FlutterLogo(), Text('Numero de click'), Text('$_valor')],
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: _incrementar,
          backgroundColor: Colors.purple,
          child: Icon(Icons.add),
        ),
        FloatingActionButton(
          onPressed: _decrementar,
          backgroundColor: Colors.purple,
          child: Icon(Icons.remove),
        ),
      ]),
    );
  }
}
