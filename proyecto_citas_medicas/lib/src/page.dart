import 'package:flutter/material.dart';
import 'package:proyecto_citas_medicas/src/calendar.dart';
import 'package:proyecto_citas_medicas/src/report_Page.dart';
import 'medic_page.dart';
import 'pacient_page.dart';

var list = 0;

class PageList extends StatefulWidget {
  @override
  State<PageList> createState() => _PageListState();
}

class _PageListState extends State<PageList>
    with SingleTickerProviderStateMixin {
  var titulo = "Consultorio dental";
  late TabController _tabController;
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(CambiarTitulo);
  }

  void CambiarTitulo() {
    setState(() {
      if (_tabController.index == 0) {
        titulo = "Consultorio dental";
      } else if (_tabController.index == 2) {
        titulo = "Pacientes";
      } else if (_tabController.index == 1) {
        titulo = "Reportes";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('$titulo'),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(icon: Icon(Icons.event_note)),
                Tab(icon: Icon(Icons.description)),
                Tab(icon: Icon(Icons.person_add)),
                Tab(icon: Icon(Icons.edit_calendar))
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              MedicSitePage(),
              reportPage(),
              PacientPage(),
              CalendarPage()
            ],
          )),
    );
  }
}
