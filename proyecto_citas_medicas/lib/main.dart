import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proyecto_citas_medicas/src/page.dart';

void main() {
  /*initializeDateFormatting('es', null).then((_) {*/
  initializeDateFormatting('es', null);
  runApp(MyApp());
  /*});*/
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto citas Medicas',
      debugShowCheckedModeBanner: false,
      home: PageList(),
    );
  }
}
