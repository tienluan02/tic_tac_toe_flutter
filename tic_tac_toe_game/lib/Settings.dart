import 'package:flutter/material.dart';

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
                // ElevatedButton(
                //   onPressed: () {},
                //     child: Text('Audio'),
                // ),
              ]
          ),
        )
    );
  }
}