import 'package:bua_assassins/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  NameInputScreenState createState() => NameInputScreenState();
}

class NameInputScreenState extends State<NameInputScreen> {
  String _playerName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter your name')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Enter your name:'),
            TextField(
              onChanged: (name) {
                setState(() {
                  _playerName = name;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<AppStateProvider>(context, listen: false)
                    .setPlayerName(_playerName);
                // context
                //     .read<AppStateProvider>()
                //     .setPlayerState(PlayerState.registered);
                context.go('/registration/pair-nfc');
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
 
//  The  NameInputScreen  widget is a simple form that allows the player to enter their name. When the player submits their name, the  setPlayerName  method is called to update the player's name in the app state. The  setPlayerState  method is then called to transition the player to the  registered  state. 
//  The  NameInputScreen  widget is displayed when the player is in the  pendingRegistration  state and the game is in the  preRegistration  state. After the player enters their name and submits it, the player is transitioned to the  registered  state and the  PairNfcScreen  widget is displayed. 
//  PairNfcScreen 
//  The  PairNfcScreen  widget is displayed when the player is in the  registered  state and the game is in the  preRegistration  state. This screen prompts the player to pair their NFC tag with the app.