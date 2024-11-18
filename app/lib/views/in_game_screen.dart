import 'package:flutter/material.dart';

class InGameScreen extends StatelessWidget {
  const InGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('In Game Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Add your "kill" logic here
              },
              child: const Text('Kill'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Add your logic to show the name of the target here
              },
              child: const Text('Show Target Name'),
            ),
          ],
        ),
      ),
    );
  }
}
