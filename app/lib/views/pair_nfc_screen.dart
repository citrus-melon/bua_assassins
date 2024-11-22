// import 'package:bua_assassins/models.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
// import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class PairNfcScreen extends StatefulWidget {
  const PairNfcScreen({super.key});

  @override
  State<PairNfcScreen> createState() => _PairNfcScreenState();
}

class _PairNfcScreenState extends State<PairNfcScreen> {
  bool nfcSupported = false;
  String lastUuid = 'No tag yet';

  @override
  void initState() {
    super.initState();
    doThing();
  }

  _showErrorDialog() {
    return showDialog(
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

    NfcManager.instance.startSession(
        alertMessage:
            'Bring your phone near your own NFC "target" sticker to pair it you.',
        onDiscovered: (NfcTag tag) async {
          Ndef? ndef = Ndef.from(tag);
          if (ndef == null || !ndef.isWritable) {
            _showErrorDialog();
            return;
          }

          String uuid = (const Uuid()).v4();

          NdefMessage message = NdefMessage([
            NdefRecord.createUri(
                Uri.parse('https://assassins.citrusmelon.dev/tag/$uuid')),
          ]);

          try {
            await ndef.write(message);
            setState(() {
              lastUuid = uuid;
            });
            print('Wrote $uuid');
          } catch (e) {
            _showErrorDialog();
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
                  'NFC is not supported on this device, which means you can\'t scan stickers. No worries, you can still play! Contact a game moderator for help.'),
            );
          }
          return Center(
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
                  'Bring your phone near your own NFC "target" sticker to pair it you.',
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                Text(
                  lastUuid,
                  style: const TextStyle(fontSize: 18.0),
                )
              ],
            ),
          );
        }());
  }
}
