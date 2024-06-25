import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/alcantara-jaspher-image1.jpeg'),
                radius: 100,
              ),
              Text(
                'Jaspher Alcantara',
                style: TextStyle(
                    fontFamily: 'Samantha',
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'BSIT Student',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontFamily: 'Samantha'),
              ),
              Divider(
                height: 2.0,
                color: Colors.amber,
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('091232456789'),
                tileColor: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('alcantarajaspher@gmail.com'),
                tileColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
