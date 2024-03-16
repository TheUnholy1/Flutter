import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Alcantara Program 1',
            style: TextStyle(
              fontSize: 20, //FontSize
              fontWeight: FontWeight.bold, //FontWeight
              letterSpacing: 2, //Letter Spacing
              fontFamily: 'Pacifico', //Font Family
            ),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.camera),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          margin: const EdgeInsets.all(5),
          constraints: const BoxConstraints.tightFor(width: 600, height: 800),
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 116, 177, 228), width: 30),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black, spreadRadius: 10, offset: Offset(5, 5)),
            ],
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(0),
              constraints:
                  const BoxConstraints.tightFor(width: 800, height: 800),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 199, 134, 129),
                  width: 5,
                ),
                borderRadius: BorderRadius.circular(7),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black,
                      spreadRadius: 1,
                      offset: Offset(5, 5)),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.all(20),
                constraints:
                    const BoxConstraints.tightFor(width: 600, height: 800),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 5),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.blue,
                        spreadRadius: 1,
                        offset: Offset(5, 5)),
                  ],
                ),
                child:
                    Image.asset('/images/alcantara-jaspher-image2.jpg', fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ),
    );
  }
}