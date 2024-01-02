import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

DateTime date = DateTime.now();
DateFormat fecha = DateFormat('EEEE d MMMM', 'es');
String strDate = '';

class MedicSitePage extends StatefulWidget {
  @override
  State<MedicSitePage> createState() => _MedicSitePageState();
}

class _MedicSitePageState extends State<MedicSitePage> {
  List<dynamic> DataJson = [];
  List<dynamic> DataFecha = [];
  String CodigoFecha = date.day.toString() +
      "-" +
      date.month.toString() +
      "-" +
      date.year.toString();
  var url = "https://proyect-cm-api.vercel.app/citas";
  bool activarMover = false;
  var horas = [
    "Hora",
    "8:00",
    "8:30",
    "9:00",
    "9:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "13:00",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "17:30"
  ];
  Map<String, dynamic> modelMover = {
    'id': '',
    'nombre': '',
    'fecha': '',
    'motivo': '',
    'hora': '',
    'status': '',
    'telefono': '',
    'pago': '',
    'count': '',
    'idCount': ''
  };

  Future<List> _llamarUrl() async {
    final respuesta = await get(Uri.parse(url));

    final _respuestajson = json.decode(respuesta.body);
    setState(() {
      DataJson = _respuestajson;
      DataFecha =
          DataJson.where((element) => element['fecha'] == CodigoFecha).toList();
    });
    return _respuestajson;
  }

  Future<bool> _postCitas(
      String id,
      String nombre,
      String fecha,
      String motivo,
      String hora,
      String status,
      String telefono,
      String pago,
      String count,
      String idCount) async {
    var data = {
      'nombre': '$nombre',
      'fecha': '$fecha',
      'motivo': '$motivo',
      'hora': '$hora',
      'status': '$status',
      'telefono': '$telefono',
      'pago': pago.isEmpty ? 0 : pago,
      'count': count,
      'idCount': idCount,
    };
    var response = await post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 404) {
      return false;
    }
    _llamarUrl();

    return true;
  }

  Future<void> _putCitas(
      String id,
      String nombre,
      String fecha,
      String motivo,
      String hora,
      String status,
      String telefono,
      String pago,
      String count,
      String idCount) async {
    var data = {
      'nombre': '$nombre',
      'fecha': '$fecha',
      'motivo': '$motivo',
      'hora': '$hora',
      'status': '$status',
      'telefono': '$telefono',
      'pago': pago.isEmpty ? 0 : pago,
      'count': '$count',
      'idCount': '$idCount',
    };
    await put(
      Uri.parse(url + '/' + id),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    data['pago'] = '0';
    await put(
      Uri.parse(url + '/all/' + id),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    _llamarUrl();
  }

  Future<void> _deleteCitas(String id) async {
    await delete(
      Uri.parse(url + '/' + id),
    );
    await delete(
      Uri.parse(url + '/all/' + id),
    );

    _llamarUrl();
  }

  Future<void> guardarMover(
      String id,
      String nombre,
      String fecha,
      String motivo,
      String hora,
      String status,
      String telefono,
      String pago,
      String count,
      String idCount) async {
    //arrayMover = horas.sublist(index, count - 1);
    modelMover['id'] = id;
    modelMover['nombre'] = nombre;
    modelMover['fecha'] = fecha;
    modelMover['motivo'] = motivo;
    modelMover['hora'] = hora;
    modelMover['status'] = status;
    modelMover['telefono'] = telefono;
    modelMover['pago'] = pago;
    modelMover['count'] = count;
    modelMover['idCount'] = idCount;
    activarMover = true;
  }

  Future<bool> _moverCitas(int index) async {
    for (int t = 1; t < int.parse(modelMover['count']); t++) {
      final respuesta = await get(
          Uri.parse(url + '/' + CodigoFecha + '/' + horas[index + t]));
      if (respuesta.statusCode == 404) {
        return false;
      }
    }
    _putCitas(
        modelMover['id'],
        modelMover['nombre'],
        CodigoFecha,
        modelMover['motivo'],
        horas[index],
        'pendiente',
        modelMover['telefono'],
        modelMover['pago'],
        modelMover['count'],
        '0');
    await delete(
      Uri.parse(url + '/all/' + modelMover['id']),
    );
    for (int y = 1; y < int.parse(modelMover['count']); y++) {
      _postCitas(
          '',
          modelMover['nombre'],
          CodigoFecha,
          modelMover['motivo'],
          horas[index + y],
          'pendiente',
          modelMover['telefono'],
          '0',
          '0',
          modelMover['id']);
    }

    activarMover = false;

    return true;
  }

  @override
  void initState() {
    // TODO: implement initState

    _llamarUrl();
    super.initState();
  }

  void addDate() {
    setState(() {
      date = date.add(Duration(days: 1));
      CodigoFecha = date.day.toString() +
          "-" +
          date.month.toString() +
          "-" +
          date.year.toString();
      DataFecha =
          DataJson.where((element) => element['fecha'] == CodigoFecha).toList();
    });
  }

  void subDate() {
    setState(() {
      date = date.subtract(Duration(days: 1));
      CodigoFecha = date.day.toString() +
          "-" +
          date.month.toString() +
          "-" +
          date.year.toString();
      DataFecha =
          DataJson.where((element) => element['fecha'] == CodigoFecha).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AppBar(
        title: Text('${fecha.format(date)}'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: subDate,
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  date = DateTime.now();
                  CodigoFecha = date.day.toString() +
                      "-" +
                      date.month.toString() +
                      "-" +
                      date.year.toString();
                  DataFecha = DataJson.where(
                      (element) => element['fecha'] == CodigoFecha).toList();
                });
              },
              icon: Icon(Icons.today)),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: addDate,
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.only(top: 60),
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.only(left: 16, top: 5),
          child: Center(
            child: ListView.builder(
                itemCount: horas.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      RowContainer(index),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
      SizedBox(height: 20),
    ]);
  }

  Widget RowContainer(i) {
    if (i == 0) {
      return Container(
        height: 30,
        child: Row(children: [
          Container(
            width: MediaQuery.of(context).size.width / 10.1,
            child: Center(
              child: Text('${horas[i]} ', style: TextStyle(fontSize: 20)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 4.1 - 20,
            child: Center(
              child: Text('Nombre', style: TextStyle(fontSize: 20)),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 4.1 - 20,
            child: Center(
              child: Text('Motivo', style: TextStyle(fontSize: 20)),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 15.1,
            child: Center(
              child: Text('Telefono', style: TextStyle(fontSize: 20)),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 15.1,
            child: Center(
              child: Text('Pago', style: TextStyle(fontSize: 20)),
            ),
          ),
          SizedBox(
            width: 0,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 5.1,
            child: Center(
              child: Text('Acciones', style: TextStyle(fontSize: 20)),
            ),
          ),
        ]),
      );
    }

    String nom = "",
        motivo = "",
        telefono = "",
        pago = "",
        id = "",
        count = "",
        idcount = "";

    List<dynamic> DataHora =
        DataFecha.where((element) => element['hora'] == horas[i]).toList();
    if (DataHora.length > 0) {
      nom = DataHora[0]['nombre'].toString();
      motivo = DataHora[0]['motivo'].toString();
      telefono = DataHora[0]['telefono'].toString();
      pago = DataHora[0]['pago'].toString();
      id = DataHora[0]['id'].toString();
      count = DataHora[0]['count'].toString();
      idcount = DataHora[0]['idCount'].toString();
    }
    TextEditingController nomCtrl = TextEditingController(text: nom);
    TextEditingController motivoCtrl = TextEditingController(text: motivo);
    TextEditingController telefonoCtrl = TextEditingController(text: telefono);
    TextEditingController pagoCtrl = TextEditingController(
        text: pago == 'null' || pago == '0.00' ? '' : pago);
    bool azul = false;
    Color col = Colors.grey.shade100;
    return GestureDetector(
        onTap: () {
          azul = !azul;
          if (azul) {
            col = Colors.blue;
          } else {
            col = Colors.white;
          }
        },
        child: Container(
          margin: EdgeInsets.only(right: 20),
          color: col,
          child: Row(children: [
            Container(
              width: MediaQuery.of(context).size.width / 10.1,
              child: Center(
                child: Text('${horas[i]} ', style: TextStyle(fontSize: 18)),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4.1 - 20,
              child: Center(
                child: TextField(
                    controller: nomCtrl, style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4.1 - 20,
              child: Center(
                child: TextField(
                    controller: motivoCtrl, style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 15.1,
              child: Center(
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    maxLength: 10,
                    controller: telefonoCtrl,
                    style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 15.1,
              child: Center(
                child: TextField(
                    controller: pagoCtrl, style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(
              width: 0,
            ),
            Container(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 5.1,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (nom == '' && !activarMover)
                        ElevatedButton(
                          onPressed: () async {
                            if (nomCtrl.text.length > 0 &&
                                telefonoCtrl.text.length > 0) {
                              bool ya = await _postCitas(
                                  '',
                                  nomCtrl.text,
                                  CodigoFecha,
                                  motivoCtrl.text,
                                  horas[i],
                                  'pendiente',
                                  telefonoCtrl.text,
                                  pagoCtrl.text,
                                  '1',
                                  '0');
                              if (ya)
                                _showSuccessSnackBar(
                                    'Cita guardada correctamente',
                                    Colors.green);
                            } else {
                              _showSuccessSnackBar(
                                  'Error: Falto datos para guardar la cita',
                                  Colors.red);
                            }
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
                      if (nom == '' && activarMover)
                        ElevatedButton(
                          onPressed: () async {
                            bool ya = await _moverCitas(i);
                            if (ya)
                              _showSuccessSnackBar(
                                  'Cita movida correctamente', Colors.green);
                            else
                              _showSuccessSnackBar(
                                  'Error: La cita no se pudo mover',
                                  Colors.red);
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
                      if (nom != '' && int.parse(count) > 0)
                        ElevatedButton(
                            onPressed: () {
                              guardarMover(
                                  id,
                                  nomCtrl.text,
                                  CodigoFecha,
                                  motivoCtrl.text,
                                  horas[i],
                                  'pendiente',
                                  telefonoCtrl.text,
                                  pagoCtrl.text,
                                  count,
                                  idcount);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              primary: Colors.blue, // Color de fondo
                              textStyle: TextStyle(
                                color: Colors.white, // Color del texto
                              ),
                            ),
                            child: Icon(
                              Icons.open_with,
                            )),
                      if (nom != '' && int.parse(count) > 0)
                        ElevatedButton(
                            onPressed: () {
                              _putCitas(
                                  id,
                                  nomCtrl.text,
                                  CodigoFecha,
                                  motivoCtrl.text,
                                  horas[i],
                                  'pendiente',
                                  telefonoCtrl.text,
                                  pagoCtrl.text,
                                  count,
                                  idcount);
                              _showSuccessSnackBar(
                                  'Cambio de datos de cita correctamente',
                                  Colors.green);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              primary: Colors.green, // Color de fondo
                              textStyle: TextStyle(
                                color: Colors.white, // Color del texto
                              ),
                            ),
                            child: Icon(
                              Icons.add,
                            )),
                      if (nom != '' && int.parse(count) > 0)
                        ElevatedButton(
                            onPressed: () {
                              _deleteCitas(id);
                              _showSuccessSnackBar(
                                  'Cita eliminada correctamente', Colors.green);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              primary: Colors.red, // Color de fondo
                              textStyle: TextStyle(
                                color: Colors.white, // Color del texto
                              ),
                            ),
                            child: Icon(
                              Icons.cancel,
                            )),
                      if (nom != '' && int.parse(count) > 0)
                        ElevatedButton(
                            onPressed: () async {
                              bool ya = await _postCitas(
                                  '',
                                  nomCtrl.text,
                                  CodigoFecha,
                                  motivoCtrl.text,
                                  horas[i + int.parse(count)],
                                  'pendiente',
                                  telefonoCtrl.text,
                                  pagoCtrl.text,
                                  '0',
                                  id);
                              if (ya)
                                _putCitas(
                                    id,
                                    nomCtrl.text,
                                    CodigoFecha,
                                    motivoCtrl.text,
                                    horas[i],
                                    'pendiente',
                                    telefonoCtrl.text,
                                    pagoCtrl.text,
                                    '${int.parse(count) + 1}',
                                    '0');

                              if (ya)
                                _showSuccessSnackBar(
                                    'Hora agregada a la cita', Colors.green);
                              else
                                _showSuccessSnackBar(
                                    'Error: No se pude agregar hora a la cita',
                                    Colors.red);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              primary: Colors.black, // Color de fondo
                              textStyle: TextStyle(
                                color: Colors.white, // Color del texto
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_downward,
                            )),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

  void _showSuccessSnackBar(String message, Color col) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: col,
      ),
    );
  }
}
