import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class PairNfcScreen extends StatefulWidget {
  const PairNfcScreen({super.key});

  @override
  State<PairNfcScreen> createState() => _PairNfcScreenState();
}

class _PairNfcScreenState extends State<PairNfcScreen> {
  bool nfcSupported = false;

  @override
  void initState() {
    super.initState();
    doThing();
  }

  _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Sticker not recognized. Please try again.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> doThing() async {
    nfcSupported = await NfcManager.instance.isAvailable();
    setState(() {});

    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      Ndef? ndef = Ndef.from(tag);
      if (ndef == null) {
        _showErrorDialog();
        return;
      }
    });
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pair NFC Device'),
        ),
        body: () {
          if (!nfcSupported) {
            return const Center(
              child: Text(
                  'NFC is not supported on this device. No worries, you can still play! Contact a game moderator for help.'),
            );
          }
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.nfc,
                  size: 100.0,
                  color: Colors.blue,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Place your NFC device near the reader',
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }());
  }
}
