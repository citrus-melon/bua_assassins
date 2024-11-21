import 'package:bua_assassins/models.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';

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
          if (ndef == null) {
            _showErrorDialog();
            return;
          }

          final ndefMessage = ndef.cachedMessage;
          if (ndefMessage == null || ndefMessage.records.isEmpty) {
            _showErrorDialog();
            return;
          }

          final ndefRecord = ndefMessage.records.first;
          final payload = ndefRecord.payload;
          final uri =
              Uri.parse("https://${String.fromCharCodes(payload.skip(1))}");
          print(uri.toString());
          if (uri.host == 'assassins.citrusmelon.dev' &&
              uri.pathSegments.length == 2 &&
              uri.pathSegments.first == 'tag') {
            final uuid = uri.pathSegments[1];
            // Do something with the UUID
            print('UUID: $uuid');

            await Provider.of<AppStateProvider>(context, listen: false)
                .setNfcTag(uuid);
            await Provider.of<AppStateProvider>(context, listen: false)
                .setPlayerState('active');
          } else {
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
                  'Bring your phone near your own NFC "target" sticker to pair it you.',
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }());
  }
}
