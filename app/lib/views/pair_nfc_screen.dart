import 'package:flutter/material.dart';

class PairNfcScreen extends StatelessWidget {
  const PairNfcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pair NFC Device'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.nfc,
              size: 100.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Place your NFC device near the reader',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Placeholder for NFC pairing logic
              },
              child: const Text('Start Pairing'),
            ),
          ],
        ),
      ),
    );
  }
}