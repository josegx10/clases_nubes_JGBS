import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter - Formulario dinámico'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<BasicForm> _arrBasicForm = [];
  List<String> externalOptions = [
    'Test',
    'Opcion 2',
    'Opcion 3',
    'Opcion 4',
    'Opcion 5'
  ];

  void _add() {
    setState(() {
      _arrBasicForm.add(BasicForm(externalOptions));
    });
  }

  void _get() {
    for (var i = 0; i < _arrBasicForm.length; i++) {
      print("Campo de texto:");
      print(_arrBasicForm[i].name.text);
      print("Campo de select:");
      print(_arrBasicForm[i]._selectedValue);
      print("--------------------------------");
    }
  }

  void _remove(int index) {
    setState(() {
      _arrBasicForm.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: _arrBasicForm.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(children: [
              Expanded(
                  flex: 2,
                  child: DropdownButton<String>(
                      value: _arrBasicForm[index].getSelectedValue,
                      isExpanded: true,
                      items:
                          _arrBasicForm[index].getOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _arrBasicForm[index].setSelectedValue(value!);
                        });
                      })),
              Expanded(
                  flex: 2,
                  child: TextField(controller: _arrBasicForm[index].name)),
              Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: () => _remove(index),
                    icon: const Icon(Icons.delete),
                    label: const Text('Borrar'),
                  ))
            ]);
          },
        ),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(onPressed: _add, child: const Icon(Icons.add)),
          FloatingActionButton(
            onPressed: _get,
            child: const Icon(Icons.list_alt_outlined),
          ),
        ]));
  }
}

class BasicForm {
  // for TextField
  final TextEditingController _name = TextEditingController();

  // for DropdownButton
  List<String> _options = [];
  String _selectedValue = '';

  BasicForm(options) {
    _options = options;
    _selectedValue = _options[0];
  }
  // Getter
  TextEditingController get name => _name;

  // Getter and Setter - Select
  String get getSelectedValue => _selectedValue;
  void setSelectedValue(String selectedValue) {
    _selectedValue = selectedValue;
  }

  List<String> get getOptions => _options;
}
