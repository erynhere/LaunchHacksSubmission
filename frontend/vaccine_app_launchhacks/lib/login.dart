import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'dart:convert';
import 'dart:io';



Future<String> getJson() async {
  final String response = await rootBundle.loadString('assets/user.json');
  return response;
}

late String user_id;


class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController phonenoController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Login', style: TextStyle(color: Colors.blueGrey.shade50)),
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
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: phonenoController,
              decoration: InputDecoration(
                hintText: 'Phone Number',
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey.shade800)),
                onPressed: () async{
                  print(phonenoController.text);
                  
                  final jsonData = await getJson();
                  print("got json data into button");
                  final parsedData = json.decode(jsonData);
                  
                  print("parsed data = " + parsedData.toString());
                  
                  user_id = parsedData["user_id"];
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => home())
                  );
                },
                child: Text('Log In', style: TextStyle(color: Colors.blueGrey.shade50)),
                ),
            ),
          ],
          ),
      )
    );;
  }
}