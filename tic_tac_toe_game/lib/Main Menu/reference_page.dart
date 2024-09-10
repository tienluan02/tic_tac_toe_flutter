import 'package:flutter/material.dart';

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