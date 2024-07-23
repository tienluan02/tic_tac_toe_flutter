import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tic Tac Toe',
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NameInputPage()),
                );
              },
              child: const Text('Start Game'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReferencesPage()),
                );
              },
              child: const Text('References'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingPage(),
                  )
                );
              },
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class NameInputPage extends StatefulWidget {
  const NameInputPage({super.key});

  @override
  State<NameInputPage> createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  final TextEditingController _player1Controller = TextEditingController();
  final TextEditingController _player2Controller = TextEditingController();

  void _startGame(BuildContext context) {
    String player1 = _player1Controller.text.isEmpty ? 'Player 1' : _player1Controller.text;
    String player2 = _player2Controller.text.isEmpty ? 'Player 2' : _player2Controller.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(player1: player1, player2: player2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _player1Controller,
              decoration: const InputDecoration(labelText: 'Player 1 Name'),
            ),
            TextField(
              controller: _player2Controller,
              decoration: const InputDecoration(labelText: 'Player 2 Name'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _startGame(context),
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}

class ReferencesPage extends StatelessWidget {
  const ReferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('References'),
      ),
      body: const Center(
        child: Text(
          'References go here.',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Column(
          children: [
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () => _startGame(context),
                child: Text('Audio'),
            ),
            ]
            ),
        )
    );
  }
}


class MyHomePage extends StatefulWidget {
  final String player1;
  final String player2;

  const MyHomePage({super.key, required this.player1, required this.player2});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  String _winner = '';
  List<int> _xPositions = [];
  List<int> _oPositions = [];
  int? _blinkingIndex;
  Timer? _blinkTimer;
  bool _isBlinking = false;

  @override
  void dispose() {
    _blinkTimer?.cancel();
    super.dispose();
  }

  void _handleTap(int index) {
    if (_board[index] == '' && _winner == '') {
      setState(() {
        if (_currentPlayer == 'X') {
          if (_xPositions.length == 3) {
            int firstX = _xPositions.removeAt(0);
            _board[firstX] = '';
          }
          if (_xPositions.length == 2) {
            if (_oPositions.length == 3) {
            _startBlinking(_oPositions.first);
            }
          }
          _board[index] = 'X';
          _xPositions.add(index);
          _currentPlayer = 'O';
        } else {
          if (_oPositions.length == 3) {
            int firstO = _oPositions.removeAt(0);
            _board[firstO] = '';
          }
          if (_oPositions.length == 2) {
            if (_xPositions.length == 3) {
              _startBlinking(_xPositions.first);
            }
          }
          _board[index] = 'O';
          _oPositions.add(index);
          _currentPlayer = 'X';
        }
        _winner = _checkWinner();
      });
    }
  }

  void _startBlinking(int index) {
    _blinkTimer?.cancel();
    _blinkingIndex = index;
    _isBlinking = true;
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _isBlinking = !_isBlinking;
      });
    });
  }

  String _checkWinner() {
    const List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (List<int> combo in winningCombinations) {
      if (_board[combo[0]] != '' &&
          _board[combo[0]] == _board[combo[1]] &&
          _board[combo[1]] == _board[combo[2]]) {
        return _board[combo[0]];
      }
    }

    return '';
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
      _winner = '';
      _xPositions.clear();
      _oPositions.clear();
      _blinkingIndex = null;
      _isBlinking = false;
      _blinkTimer?.cancel();
    });
  }

  Widget _buildCell(int index) {
    bool isBlinking = _blinkingIndex == index && _isBlinking;
    return GestureDetector(
      onTap: () => _handleTap(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            _board[index],
            style: TextStyle(
                fontSize: 32.0,
                color: isBlinking ? Colors.grey : Colors.black
            ),
        ),
      ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _winner == ''
                ? 'Current Player: ${_currentPlayer == 'X' ? widget.player1 : widget.player2}'
                : '',
            style: const TextStyle(fontSize: 24.0),
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return _buildCell(index);
            },
          ),
          if (_winner != '')
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _winner == 'Draw'
                    ? 'It\'s a Draw!'
                    : '${_winner == 'X' ? widget.player1 : widget.player2} Wins!',
                style: const TextStyle(fontSize: 24.0),
              ),
            ),
          ElevatedButton(
            onPressed: _resetGame,
            child: const Text('Reset Game'),
          ),
        ],
      ),
    );
  }
}
