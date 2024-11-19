import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the App!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your onPressed code here!
                Supabase.instance.client.auth.signInAnonymously(data: {
                  // 'type': 'player',
                  // 'game': '1',
                  // 'name': '',
                });
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
