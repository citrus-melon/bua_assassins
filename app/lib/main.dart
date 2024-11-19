import 'package:bua_assassins/models.dart';
import 'package:bua_assassins/views/eliminated_screen.dart';
import 'package:bua_assassins/views/game_concluded_screen.dart';
import 'package:bua_assassins/views/in_game_screen.dart';
import 'package:bua_assassins/views/ineligible_screen.dart';
import 'package:bua_assassins/views/name_input_screen.dart';
import 'package:bua_assassins/views/paused_screen.dart';
import 'package:bua_assassins/views/preregistered_screen.dart';
import 'package:bua_assassins/views/registered_screen.dart';
import 'package:bua_assassins/views/undefined_state_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'views/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://uvytjjldwcitkqattdeq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV2eXRqamxkd2NpdGtxYXR0ZGVxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEyMDc0NDAsImV4cCI6MjA0Njc4MzQ0MH0.yLxvsX-brf2605syFIPR12okvRpuxjpEZM1cCDd6jMQ',
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppStateProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Placeholder();
          } else if (snapshot.hasData && snapshot.data?.session != null) {
            return const AppNavigator();
          } else {
            return const WelcomeScreen();
          }
        });
  }
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, stateProvider, child) {
        final playerState = stateProvider.playerState;
        final gameState = stateProvider.gameState;

        if (gameState == null || gameState == GameState.unpublished) {
          return const WelcomeScreen();
        } else if (playerState == PlayerState.eliminated) {
          return const EliminatedScreen();
        } else if (gameState == GameState.completed) {
          return const GameConcludedScreen();
        } else if (playerState == PlayerState.ineligible) {
          return const IneligibleScreen();
        } else if (playerState == PlayerState.pendingRegistration) {
          return const NameInputScreen();
          // if (gameState == GameState.preRegistration) {
          //   return const PreregisteredScreen();
          // } else {
          //   return const NameInputScreen(); // Navigate to PairNfcScreen after name input
          // }
        } else if (gameState == GameState.paused) {
          return const PausedScreen();
        } else if (gameState == GameState.registration) {
          return const RegisteredScreen();
        } else if (gameState == GameState.active) {
          return const InGameScreen();
        } else {
          return const UndefinedStateScreen();
        }
      },
    );
  }
}
