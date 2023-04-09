/*

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class records extends StatefulWidget {
  const records({super.key});

  @override
  State<records> createState() => _recordsState();
}

class _recordsState extends State<records> {

  Map vaccines = {};
 // List<Map> vaccines = [];
  Map<String, String> responseMap = {};
  List<String> names = [];
  List<String> years = [];

  Future getRecords() async {
      
      final response = await rootBundle.loadString('assets/vax_recs.json');
      Map<String, dynamic> elements = json.decode(response);
      print("response elements:");
      print(elements);
      /*for (var obj in elements.values) {
        print("object:");
        print(obj);
        obj.forEach((name, year) {
          names.add(name);
          years.add(year);
        });
      }
*/


      
    //  print(responseMap);
      print("in get recs function");

      setState(() {
        print("in set state");
        vaccines = {"DTaP": "2023", "PCV13": "2024", "RV1": "2025"};
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
        title: Text('Vaccination Records', style: TextStyle(color: Colors.blueGrey.shade50)),
        backgroundColor:Colors.blueGrey.shade800,
      ),
      body: DataTable(
        columns: [
          DataColumn(label: Text("Name")),
          DataColumn(label: Text("Date Taken")),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text(vaccines.keys.elementAt(0))),
            DataCell(Text(vaccines.values.elementAt(0))),
          ]),
          DataRow(cells: [
            // DataCell(Text(vaccines[0].values.elementAt(0))),
            //DataCell(Text(vaccines[0].values.elementAt(1))),
            DataCell(Text(vaccines.keys.elementAt(1))),
            DataCell(Text(vaccines.values.elementAt(1))),
          ]),
          DataRow(cells: [
            DataCell(Text(vaccines.keys.elementAt(2))),
            DataCell(Text(vaccines.values.elementAt(2))),
          ]),
        ],
      ),

      /*Column(
        children: <Widget>[
          TextButton(
            onPressed: () {},
            child: Text('Name of the vaccine' + '   ' + 'mm/dd/yyyy'),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Name of the vaccine' + '   ' + 'mm/dd/yyyy'),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Name of the vaccine' + '   ' + 'mm/dd/yyyy'),
          ),
        ],
      ), */
    );
  }
}

*/