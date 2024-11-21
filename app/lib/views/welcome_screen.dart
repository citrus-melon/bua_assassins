import 'package:bua_assassins/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BUA Assassins'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to BUA Assasssins!',
              style: TextStyle(fontSize: 24),
            ),
            const Text(
              'Each player will receive and wear a “target” sticker. When the game begins, each player will be assigned another player as a target. Whenever a player eliminates their target by scanning their sticker, they get the victim\'s target. Players will track down and eliminate their targets until only two players remain. Good luck!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Add your onPressed code here!
                await Supabase.instance.client.auth.signInAnonymously(data: {
                  'type': 'player',
                  'game': '1',
                  'name': '',
                });
                if (!context.mounted) return;
                Provider.of<AppStateProvider>(context, listen: false).refresh();
              },
              child: const Text('Join Game'),
            ),
          ],
        ),
      ),
    );
  }
}
