import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class upcoming extends StatefulWidget {
  const upcoming({super.key});

  @override
  State<upcoming> createState() => _upcomingState();
}

class _upcomingState extends State<upcoming> {

  List<dynamic> _vaccinesList = [];

  Future getUpcoming() async {
    final response = await rootBundle.loadString('assets/vax_soon.json');
    Map<String, dynamic> elements = json.decode(response);
    print("response elements");
    print(elements);

    _vaccinesList = elements["vaccines"];
    print("Vaccines list");
    print(_vaccinesList);
    Map oneElement = _vaccinesList.elementAt(0);
    print(oneElement["name"] + ', ' + oneElement["year"]);
    setState(() {
      print("in set state");

      // vaccines = [{"name":"DTaP","date": "2023"}, {"name":"PV2","date": "2021"}, {"name":"PVB","date": "2022"}];
    });
  }

  @override
  void initState() {
    super.initState();
    getUpcoming();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Vaccinations Due Soon', style: TextStyle(color: Colors.blueGrey.shade50)),
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
        backgroundColor:Colors.blueGrey.shade800,
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
      DataColumn(label: Text('Year')),
    ];
  }

      List<DataRow> _createRows() {
    return _vaccinesList
        .map((vax) => DataRow(cells: [
              DataCell(Text(vax['name'].toString())),
              DataCell(Text(vax['year'])),
            ]))
        .toList();
  }

}