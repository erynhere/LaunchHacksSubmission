import 'package:flutter/material.dart';
import 'records.dart';
import 'upcoming.dart';
import 'test.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Home', style: TextStyle(color: Colors.blueGrey.shade50)),
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
        children: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VaxRecs())
              );
            },
            child: Text('My Vaccine Records', style: TextStyle(color: Colors.blueGrey.shade800)),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => upcoming())
              );
            },
            child: Text('Vaccines Due Soon', style: TextStyle(color: Colors.blueGrey.shade800)),
          ),
        ],
      ),
    );
  }
}