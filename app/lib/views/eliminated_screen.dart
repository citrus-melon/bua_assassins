import 'package:flutter/material.dart';

class EliminatedScreen extends StatelessWidget {
  const EliminatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Over'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have been eliminated!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Stats:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              'Kills: 0',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'Survival Time: 0 mins',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'Rank: 0',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Return to Main Menu'),
            ),
          ],
        ),
      ),
    );
  }
}