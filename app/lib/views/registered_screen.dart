import 'package:flutter/material.dart';
import 'dart:async';

import 'package:go_router/go_router.dart';

class RegisteredScreen extends StatelessWidget {
  const RegisteredScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('You\'re Registered'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "You're in!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'The game will start around 9:00 pm on Friday, November 22',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                // Add your onPressed code here!
                context.go('/registered/demo');
              },
              child: const Text('Demo Mode'),
            ),
          ],
        ),
      ),
    );
  }
}

// class RegisteredScreen extends StatefulWidget {
//   const RegisteredScreen({super.key});

//   @override
//   RegisteredScreenState createState() => RegisteredScreenState();
// }

// class RegisteredScreenState extends State<RegisteredScreen> {
//   late Timer _timer;
//   int _start = 10; // Countdown start value in seconds

//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }

//   void startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_start == 0) {
//         setState(() {
//           timer.cancel();
//         });
//       } else {
//         setState(() {
//           _start--;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Game Registration'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               "You're in!",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Game starts in:',
//               style: TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               '$_start seconds',
//               style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(const MaterialApp(
//     home: RegisteredScreen(),
//   ));
// }
