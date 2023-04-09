import 'package:flutter/material.dart';
import 'home.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';


Future<String> getJson() async {
  final response = await rootBundle.load('assets/clinics.json');
  return response.toString();
}




class Clinic extends StatefulWidget {
  const Clinic({super.key});

  @override
  State<Clinic> createState() => _ClinicState();
}

class _ClinicState extends State<Clinic> {

String? valueChosen;

  late List clinics;
  List clinics2 = [];

  Future getClinics() async {
    print("get clinics called");
    final String response = await rootBundle.loadString('assets/clinics.json');
    final data = await json.decode(response);
    // clinics2 = data["clinicsNearby"];
    // print("print clinics2:");
    // print(clinics2);
  //  var read_clinics = await getJson();
    /*
    var final_clinics = json.decode(read_clinics) as List;
    print("got read clinics from json file");
    
    print(final_clinics);
    */
    setState(() {
      // clinics = ["Santa Clara Hospital", "CVS Pharmacy Minute Clinic", 'Walgreens Pharmacy'];
      // print(read_clinics);
      clinics = data["clinicsNearby"];
      print("set state of clinics called");
    });
  }
  
  /*
  getClinics() {
    print("get clinics called");
    setState(() {
      clinics = ["1", "2", '3'];
      print("set state of clinics called");
    });
  }
  */

  @override
  void initState() {
    super.initState();

    clinics = [];
    getClinics();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Clinics Nearby', style: TextStyle(color: Colors.blueGrey.shade50)),
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
      body: Column(
        children: <Widget> [
          DropdownButton(
            hint: Text("Choose clinics...", style: TextStyle(fontSize: 12.0)),
            value: valueChosen,
            onChanged: (newValue) async {
              setState(() {
                valueChosen = newValue.toString();
              });
            },
            items: clinics.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            }).toList(),
            ),
            Container(
              padding: EdgeInsets.only(left: 125.0),
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey.shade800)),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => home())
                );
                },
                  child: Text('Set as Preferred Clinic', style: TextStyle(color: Colors.blueGrey.shade50, fontSize: 12.0)),
                ),
            ),
        ],
      ),
    );
  }
}
