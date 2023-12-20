import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class reportPage extends StatefulWidget {
  @override
  State<reportPage> createState() => _reportPageState();
}

class _reportPageState extends State<reportPage> {
  DateFormat fecha = DateFormat('EEEE d MMMM', 'es');
  List<dynamic> DataJson = [];
  List<dynamic> DataFecha = [];
  var url = "https://proyect-cm-api.vercel.app/citass";
  Future<void> _llamarUrl(String CodigoFecha) async {
    final respuesta = await get(Uri.parse(url));

    final _respuestajson = json.decode(respuesta.body);
    setState(() {
      DataJson = _respuestajson;
      DataFecha =
          DataJson.where((element) => element['fecha'] == CodigoFecha).toList();
    });
  }

  @override
  void initState() {
    DateTime dateReport = DateTime.now().add(Duration(days: 1));
    String CodigoFecha = dateReport.day.toString() +
        "-" +
        dateReport.month.toString() +
        "-" +
        dateReport.year.toString();
    _llamarUrl(CodigoFecha);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          child: ListView.builder(
              itemCount: DataFecha.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                    child: Column(
                  children: [
                    if (index == 0)
                      RowContainer(index)
                    else if (int.parse(
                                DataFecha[index - 1]['count'].toString()) >
                            0 &&
                        index > 0)
                      RowContainer(index)
                  ],
                ));
              })),
    ]);
  }

  Widget RowContainer(i) {
    if (i == 0) {
      return Container(
        height: 30,
        child: Row(children: [
          Container(
            width: MediaQuery.of(context).size.width / 3.1,
            child: Center(
              child: Text('Nombre', style: TextStyle(fontSize: 20)),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3.1,
            child: Center(
              child: Text('Telefono', style: TextStyle(fontSize: 20)),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3.1,
            child: Center(
              child: Text('Acciones', style: TextStyle(fontSize: 20)),
            ),
          ),
        ]),
      );
    }

    return Container(
      height: 30,
      child: Row(children: [
        Container(
          width: MediaQuery.of(context).size.width / 3.1,
          child: Center(
            child: Text('${DataFecha[i - 1]['nombre']}',
                style: TextStyle(fontSize: 18)),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3.1,
          child: Center(
            child: Text('${DataFecha[i - 1]['telefono']}',
                style: TextStyle(fontSize: 18)),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 3.1,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await launchUrl(Uri.parse(
                          'whatsapp://send?phone=+52${DataFecha[i - 1]['telefono']}&text=${Uri.encodeComponent("Hola desde flutter")}'));
                    },
                    child: Icon(Icons.add),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      primary: Colors.green, // Color de fondo
                      textStyle: TextStyle(
                        color: Colors.white, // Color del texto
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
