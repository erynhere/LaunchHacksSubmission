import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return VaxRecs();
  }
}

class VaxRecs extends StatefulWidget {
  const VaxRecs({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state.
  @override
  _VaxRecsState createState() => _VaxRecsState();
}

class _VaxRecsState extends State<VaxRecs> {
  Map vaccines = {};
  Map<String, String> responseMap = {};
  List<dynamic> _vaccinesList = [];

  List<Map> _books = [
    {'name': 'vaccine1', 'year': '2023'},
    {'name': 'vaccine2', 'year': '2024'},
    {'name': 'vaccine3', 'year': '2014'},
  ];

  Future getRecords() async {
    final response = await rootBundle.loadString('assets/vax_recs.json');
    Map<String, dynamic> elements = json.decode(response);
    print("response elements");
    print(elements);

    _vaccinesList = elements["vaccines"];
    print("Vaccines list");
    print(_vaccinesList);
    Map oneElement = _vaccinesList.elementAt(0);
    print(oneElement["name"] + ', ' + oneElement["dategiven"]);
    setState(() {
      print("in set state");

      // vaccines = [{"name":"DTaP","date": "2023"}, {"name":"PV2","date": "2021"}, {"name":"PVB","date": "2022"}];
    });
  }

  @override
  void initState() {
    super.initState();
    getRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade800,
          title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Vaccination Records', style: TextStyle(color: Colors.blueGrey.shade50)),
            Container(
              height: 50.0,
              width: 50.0,
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.scaleDown,
                ),
              ),
          ]
        ),
        ),
        body: ListView(
          children: [_createDataTable()],
        ),
      );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Date Given')),
    ];
  }

  /*List<DataRow> _createRows() {
    return _books
        .map((book) => DataRow(cells: [
              DataCell(Text(book['name'].toString())),
              DataCell(Text(book['year'])),
            ]))
        .toList();
  }*/
    List<DataRow> _createRows() {
    return _vaccinesList
        .map((vax) => DataRow(cells: [
              DataCell(Text(vax['name'].toString())),
              DataCell(Text(vax['dategiven'])),
            ]))
        .toList();
  }
}
