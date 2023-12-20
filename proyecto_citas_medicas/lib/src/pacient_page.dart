import 'package:flutter/material.dart';
import 'package:proyecto_citas_medicas/src/page.dart';

class PacientPage extends StatefulWidget {
  @override
  State<PacientPage> createState() => _PacientPageState();
}

class _PacientPageState extends State<PacientPage> {
  @override
  void initState() {
    // TODO: implement initState
    list = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Pacientes page'),
    );
  }
}
