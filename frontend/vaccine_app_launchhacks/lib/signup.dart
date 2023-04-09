import 'package:flutter/material.dart';
import 'login.dart';
import 'clinic.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  final TextEditingController phonenoController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Signup', style: TextStyle(color: Colors.blueGrey.shade50)),
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
        backgroundColor: Colors.blueGrey.shade800,
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
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                    hintText: 'Childs Age',
                  ),
                ),
                TextField(
                  controller: zipcodeController,
                  decoration: InputDecoration(
                    hintText: 'Zip Code',
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: TextButton(
                    onPressed: () {

                      print(phonenoController.text);
                      print(ageController.text);
                      print(zipcodeController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Clinic())
                      );
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey.shade800)),
                    child: Text('Create Account', style: TextStyle(color: Colors.blueGrey.shade50))
                    ),
                ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => login())
                      );
                    },
                    child: Text('Already have an account? Login.', style: TextStyle(color: Colors.blueGrey.shade800))
                  ),
          ],
            ),
          ),
      );
  }
}