import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class DemoModeScreen extends StatefulWidget {
  const DemoModeScreen({super.key});

  @override
  State<DemoModeScreen> createState() => _DemoModeScreenState();
}

class _DemoModeScreenState extends State<DemoModeScreen> {
  bool nfcSupported = false;

  @override
  void initState() {
    super.initState();
    doThing();
  }

  _showSuccessDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Good job!'),
          content: const Text(
              'Once the game starts, you can scan your target\'s NFC sticker just like that to eliminate them.'),
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
            "Bring your phone near anyone's NFC sticker to practice eliminating people during gameplay.",
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
            _showSuccessDialog();
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
          title: const Text('Sticker Scanning Demo'),
        ),
        body: () {
          if (!nfcSupported) {
            return const Center(
              child: Text(
                  'NFC is not supported on this device, which means you can\'t scan stickers to eliminate people. No worries, you can still play! You\'ll just tap your target on their shoulder, show them your screen, and ask them to resign.'),
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
                  'Bring your phone near anyone\'s NFC sticker to practice eliminating people during gameplay.',
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }());
  }
}
