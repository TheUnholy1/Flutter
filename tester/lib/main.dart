import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piece Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PieceTestPage(),
    );
  }
}

class PieceTestPage extends StatelessWidget {
  Widget _buildPiece(Color color, bool isKing, bool canCapture) {
    Color pieceColor = canCapture ? color.withOpacity(0.8) : color;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: pieceColor,
        border: canCapture
            ? Border.all(color: Colors.yellow, width: 4)
            : null, // Highlight with yellow border if can capture
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 94, 83, 193).withOpacity(0.3),
            offset: const Offset(-3, -3),
            blurRadius: 3,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: const Offset(-3, -3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Center(
        child: isKing
            ? Icon(Icons.star, color: Colors.yellow, size: 24) // King piece
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Piece Example')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Normal Piece'),
          _buildPiece(Colors.red, false, false),
          SizedBox(height: 20),
          Text('Capturable Piece'),
          _buildPiece(Colors.red, false, true),
          SizedBox(height: 20),
          Text('King Piece'),
          _buildPiece(Colors.red, true, false),
          SizedBox(height: 20),
          Text('Capturable King Piece'),
          _buildPiece(Colors.red, true, true),
        ],
      ),
    );
  }
}
