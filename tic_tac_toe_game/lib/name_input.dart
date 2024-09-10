import 'package:flutter/material.dart';
import 'gameplay.dart';

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