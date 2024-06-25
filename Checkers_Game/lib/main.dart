import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Checkers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late Animation<double> _animation1;
  late AnimationController _controller2;
  late Animation<double> _animation2;
  late AnimationController _controller3;
  late Animation<double> _animation3;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation1 = CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeInOut,
    );

    _controller2 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation2 = CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeInOut,
    );

    _controller3 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation3 = CurvedAnimation(
      parent: _controller3,
      curve: Curves.easeInOut,
    );

    _startAnimations();
  }

  void _startAnimations() {
    _controller1.forward().then((value) {
      Future.delayed(const Duration(seconds: 1), () {
        _controller1.reverse().then((value) {
          _controller2.forward().then((value) {
            Future.delayed(const Duration(seconds: 1), () {
              _controller2.reverse().then((value) {
                _controller3.forward();
                _startLoading();
              });
            });
          });
        });
      });
    });
  }

  void _startLoading() {
    Future.delayed(const Duration(seconds: 10), () {
      for (int i = 1; i <= 100; i++) {
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            _progress = i / 100;
          });
        });
      }
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 26, 26, 26),
      body: Stack(
        children: [
          // Image 1 (cct.png) with opacity and scale animation
          Center(
            child: FadeTransition(
              opacity: _animation1,
              child: ScaleTransition(
                scale: Tween<double>(begin: 1.5, end: 1.0)
                    .animate(_animation1), // Scale down from 1.5 to 1.0
                child: Image.asset(
                  'assets/images/cct.png',
                  fit: BoxFit.cover,
                  height: 300, // Adjust height as needed
                  width: 300, // Adjust width as needed
                ),
              ),
            ),
          ),
          // Image 2 (scs.png) with opacity and scale animation
          Center(
            child: FadeTransition(
              opacity: _animation2,
              child: ScaleTransition(
                scale: Tween<double>(begin: 1.5, end: 1.0)
                    .animate(_animation2), // Scale down from 1.5 to 1.0
                child: Image.asset(
                  'assets/images/scs.png',
                  fit: BoxFit.cover,
                  height: 300, // Adjust height as needed
                  width: 300, // Adjust width as needed
                ),
              ),
            ),
          ),
          // Image 3 (icon.png) with opacity and scale animation
          Center(
            child: FadeTransition(
              opacity: _animation3,
              child: ScaleTransition(
                scale: Tween<double>(begin: 1.5, end: 1.0)
                    .animate(_animation3), // Scale down from 1.5 to 1.0
                child: Image.asset(
                  'assets/images/icon.png',
                  fit: BoxFit.cover,
                  height: 300, // Adjust height as needed
                  width: 300, // Adjust width as needed
                ),
              ),
            ),
          ),
          // Progress Indicator
          Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              value: _progress,
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isLoading = false;
  double loadingProgress = 0.0;
  final AudioCache _audioCache = AudioCache(prefix: 'assets/sounds/');
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> startGame() async {
    await _playSound('click.mp3');
    setState(() {
      isLoading = true;
      loadingProgress = 0.0;
    });

    // Simulate a longer loading process
    await Future.delayed(const Duration(seconds: 2));

    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      setState(() {
        loadingProgress = i / 100;
      });
    }

    setState(() {
      isLoading = false;
    });

    // Navigate to CheckersGame after loading
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CheckersGame()),
    );
  }

  Future<void> goToAboutUs() async {
    await _playSound('click.mp3');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutUsPage()),
    );
  }

  Future<void> _playSound(String fileName) async {
    await _audioCache.play(fileName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/checkersbg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Small
          // Small Image at the Top
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 85.0),
              child: Image.asset(
                "assets/images/icon.png",
                width: 400,
                height: 400,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Centered Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height:
                        200), // Adjust spacing between background image and buttons
                ElevatedButton(
                  onPressed: startGame,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 238, 172, 41),
                    padding: EdgeInsets.all(16),
                    minimumSize: Size(200, 50),
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Start Game'),
                ),
                const SizedBox(height: 20), // Adjust spacing between buttons
                ElevatedButton(
                  onPressed: goToAboutUs,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 238, 172, 41),
                    padding: EdgeInsets.all(16),
                    minimumSize: Size(200, 50),
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('About Us'),
                ),
              ],
            ),
          ),

          // Video Game Style Loading Screen
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black
                    .withOpacity(0.8), // Semi-transparent black background
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Custom loading animation or graphics can be placed here
                      ScaleTransition(
                        scale: _animation,
                        child: Image.asset(
                          "assets/images/load.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Example of adding a themed loading text
                      Text(
                        'Loading...',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'GameFont'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CheckersGame extends StatefulWidget {
  const CheckersGame({super.key});

  @override
  _CheckersGameState createState() => _CheckersGameState();
}

class _CheckersGameState extends State<CheckersGame> {
  List<List<int>> board = List.generate(8, (i) => List.generate(8, (j) => 0));
  int? selectedRow;
  int? selectedCol;
  int currentPlayer = 2; // 1 for player 1, 2 for player 2
  final AudioCache _audioCache = AudioCache(prefix: 'assets/sounds/');

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
        if (row < 3 && (row + col) % 2 == 1) {
          board[row][col] = 1;
        } else if (row > 4 && (row + col) % 2 == 1) {
          board[row][col] = 2;
        }
      }
    }
  }

  void _selectSquare(int row, int col) {
    setState(() {
      if (selectedRow == null) {
        if (board[row][col] == currentPlayer ||
            board[row][col] == -currentPlayer) {
          selectedRow = row;
          selectedCol = col;
        }
      } else {
        if ((row + col) % 2 == 1 && board[row][col] == 0) {
          if (_isValidMove(selectedRow!, selectedCol!, row, col)) {
            _movePiece(selectedRow!, selectedCol!, row, col);
            selectedRow = null;
            selectedCol = null;
          } else {
            selectedRow = null;
            selectedCol = null;
          }
        } else {
          selectedRow = null;
          selectedCol = null;
        }
      }

      // Check for mandatory captures
      bool mandatoryCaptureAvailable =
          _checkForMandatoryCaptures(currentPlayer);
      if (mandatoryCaptureAvailable &&
          selectedRow != null &&
          selectedCol != null) {
        // If a capture is available for the current selected piece, enforce it
        if (!_hasValidCapture(selectedRow!, selectedCol!)) {
          // Reset selection if the piece cannot make a capture
          selectedRow = null;
          selectedCol = null;
        }
      }
    });
  }

  bool _checkForMandatoryCaptures(int player) {
    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
        if (board[row][col] == player) {
          if (_hasValidCapture(row, col)) {
            return true;
          }
        }
      }
    }
    return false;
  }

  bool _hasValidCapture(int row, int col) {
    int piece = board[row][col];
    int direction = piece == 1 ? 1 : (piece == 2 ? -1 : 0);

    for (int r = -2; r <= 2; r += 4) {
      for (int c = -2; c <= 2; c += 4) {
        if (row + r >= 0 &&
            row + r < 8 &&
            col + c >= 0 &&
            col + c < 8 &&
            board[row + r][col + c] == 0) {
          int middleRow = row + r ~/ 2;
          int middleCol = col + c ~/ 2;
          if (middleRow >= 0 &&
              middleRow < 8 &&
              middleCol >= 0 &&
              middleCol < 8 &&
              board[middleRow][middleCol] != 0 &&
              board[middleRow][middleCol] != piece &&
              board[middleRow][middleCol] != -piece) {
            return true;
          }
        }
      }
    }
    return false;
  }

  bool _isValidMove(int fromRow, int fromCol, int toRow, int toCol) {
    int piece = board[fromRow][fromCol];
    int direction = piece == 1
        ? 1
        : (piece == 2 ? -1 : 0); // Regular pieces move in one direction

    // Check for capturing move
    if ((fromRow - toRow).abs() == 2 && (fromCol - toCol).abs() == 2) {
      int middleRow = (fromRow + toRow) ~/ 2;
      int middleCol = (fromCol + toCol) ~/ 2;
      if (board[middleRow][middleCol] != 0 &&
          board[middleRow][middleCol] != piece &&
          board[middleRow][middleCol] != -piece) {
        return true; // Valid capturing move
      } else {
        return false; // Must capture if capture is available
      }
    }

    // If there's a capture available, ensure it's the only valid move
    if (_hasValidCapture(fromRow, fromCol)) {
      return false;
    }

    // Regular move logic
    if ((toRow - fromRow).abs() == 1 &&
        (fromCol - toCol).abs() == 1 &&
        (toRow - fromRow) * direction > 0) {
      return true; // Normal forward move
    }
    // King move logic (can move in any direction along empty adjoining dark squares)

    if (piece == -1 || piece == -2) {
      if ((toRow - fromRow).abs() == 1 && (toCol - fromCol).abs() == 1) {
        return true; // King can move diagonally in any direction
      }
    }
    return false;
  }

  void _movePiece(int fromRow, int fromCol, int toRow, int toCol) {
    setState(() {
      board[toRow][toCol] = board[fromRow][fromCol];
      board[fromRow][fromCol] = 0;

      // Promote to king if piece reaches the opposite end
      if (toRow == 0 && board[toRow][toCol] == 2) {
        board[toRow][toCol] = -2;
      } else if (toRow == 7 && board[toRow][toCol] == 1) {
        board[toRow][toCol] = -1;
      }

      // Remove the captured piece if any
      int rowDirection = (toRow - fromRow) ~/ (toRow - fromRow).abs();
      int colDirection = (toCol - fromCol) ~/ (toCol - fromCol).abs();
      int row = fromRow + rowDirection;
      int col = fromCol + colDirection;

      bool captured = false;

      while (row != toRow && col != toCol) {
        if (board[row][col] != 0 && board[row][col] != board[toRow][toCol]) {
          board[row][col] = 0;
          captured = true;
          break;
        }
        row += rowDirection;
        col += colDirection;
      }

      _playMoveSound();

      // If a piece was captured and multiple captures are possible, remain the current player's turn
      if (!captured || !_checkForMultipleCaptures(toRow, toCol)) {
        _switchTurn();
      }
    });
  }

  bool _checkForMultipleCaptures(int row, int col) {
    for (int r = -2; r <= 2; r += 4) {
      for (int c = -2; c <= 2; c += 4) {
        if (row + r >= 0 &&
            row + r < 8 &&
            col + c >= 0 &&
            col + c < 8 &&
            board[row + r][col + c] == 0) {
          int middleRow = row + r ~/ 2;
          int middleCol = col + c ~/ 2;
          if (middleRow >= 0 &&
              middleRow < 8 &&
              middleCol >= 0 &&
              middleCol < 8 &&
              board[middleRow][middleCol] != 0 &&
              board[middleRow][middleCol] != board[row][col]) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void _switchTurn() {
    // Check if the opponent has no available pieces before switching turn
    int opponent = currentPlayer == 1 ? 2 : 1;
    if (!_checkForAvailablePieces(opponent)) {
      // Display a dialog with options, showing the current player as the winner
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing by tapping outside
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'Player ${opponent} wins!'), // Display the opponent as the winner
            content: Text('What would you like to do next?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  _resetBoard(); // Reset the board for a new game
                },
                child: Text('Play Again'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pop(); // Return to main menu
                },
                child: Text('Exit'),
              ),
            ],
          );
        },
      );
      return; // Exit the function to prevent switching turns
    }

    // If the opponent has pieces, switch the turn
    setState(() {
      currentPlayer = currentPlayer == 1 ? 2 : 1;
    });
  }

  bool _checkForAvailablePieces(int player) {
    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
        if (board[row][col] == player || board[row][col] == -player) {
          return true; // Found at least one piece belonging to the player
        }
      }
    }
    return false; // No pieces found for the player
  }

  void _resetBoard() {
    setState(() {
      // Clear the board and initialize it again
      board = List.generate(8, (i) => List.generate(8, (j) => 0));
      _initializeBoard();

      // Reset other game variables as needed
      currentPlayer = 1;
      selectedRow = null;
      selectedCol = null;
    });
  }

  Future<void> _playMoveSound() async {
    await _audioCache.play('move.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              'Checkers Game',
              style: TextStyle(color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: currentPlayer == 1 ? Colors.black : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8), // Spacing between the circle and the text
                Text(
                  currentPlayer == 1 ? 'Player 2\'s Turn' : 'Player 1\'s Turn',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 238, 172, 41),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"),
              fit: BoxFit.cover,
            ),
            border:
                Border.all(color: Color.fromARGB(255, 238, 172, 41), width: 4),
          ),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ 8;
                int col = index % 8;
                return _buildSquare(row, col);
              },
              itemCount: 64,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSquare(int row, int col) {
    bool isDarkSquare = (row + col) % 2 == 1;
    Color squareColor = isDarkSquare ? Colors.black : Colors.white24;
    Widget? piece;

    bool canCapture = false; // Default to false

    if (board[row][col] == 1) {
      canCapture = _hasValidCapture(row, col);
      piece = _buildPiece(Color.fromARGB(255, 69, 69, 69), false, canCapture);
    } else if (board[row][col] == 2) {
      canCapture = _hasValidCapture(row, col);
      piece = _buildPiece(Color.fromARGB(255, 255, 68, 0), false, canCapture);
    } else if (board[row][col] == -1) {
      piece = _buildPiece(Color.fromARGB(255, 69, 69, 69), true, canCapture);
    } else if (board[row][col] == -2) {
      piece = _buildPiece(Color.fromARGB(255, 255, 68, 0), true, canCapture);
    }

    bool isSelected = row == selectedRow && col == selectedCol;
    bool isValidMove = selectedRow != null &&
        selectedCol != null &&
        _isValidMove(selectedRow!, selectedCol!, row, col) &&
        board[row][col] == 0; // Ensure target square is empty

    return GestureDetector(
      onTap: () {
        _selectSquare(row, col);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue
              : isValidMove
                  ? Color.fromARGB(255, 2, 247, 10)
                  : squareColor,
        ),
        child: Center(child: piece),
      ),
    );
  }

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
      child: isKing
          ? Icon(Icons.star, color: Colors.yellow, size: 24) // King piece
          : null,
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  final List<Map<String, String>> items = const [
    {'image': 'assets/images/1x1.jpeg', 'title': 'Jaspher Alcantara'},
    {'image': 'assets/images/ivan.jpg', 'title': 'Isaac Ivan Martinez'},
    {'image': 'assets/images/naz.jpg', 'title': 'Naziancino Payad'},
    {'image': 'assets/images/joseph.jpeg', 'title': 'Joseph Jopia'},
    // Add more items here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 238, 172, 41),
      ),
      body: Center(
        child: ListWheelScrollView.useDelegate(
          itemExtent: 280, // Adjust for image height
          diameterRatio: 1.5,
          perspective: 0.003,
          useMagnifier: true,
          magnification: 1.2,
          physics: const FixedExtentScrollPhysics(),
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              if (index < 0 || index >= items.length) {
                return null;
              }
              final item = items[index];
              return Card(
                elevation: 5,
                color: Color.fromARGB(255, 238, 172, 41),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      item['image']!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: items.length,
          ),
        ),
      ),
    );
  }
}
