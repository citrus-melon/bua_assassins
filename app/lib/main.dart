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
import 'package:go_router/go_router.dart';
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
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/eliminated',
      builder: (context, state) => const EliminatedScreen(),
    ),
    GoRoute(
      path: '/game-concluded',
      builder: (context, state) => const GameConcludedScreen(),
    ),
    GoRoute(
      path: '/ineligible',
      builder: (context, state) => const IneligibleScreen(),
    ),
    GoRoute(
      path: '/name-input',
      builder: (context, state) => const NameInputScreen(),
    ),
    GoRoute(
      path: '/paused',
      builder: (context, state) => const PausedScreen(),
    ),
    GoRoute(
      path: '/registered',
      builder: (context, state) => const RegisteredScreen(),
    ),
    GoRoute(
      path: '/in-game',
      builder: (context, state) => const InGameScreen(),
    ),
    GoRoute(
      path: '/undefined-state',
      builder: (context, state) => const UndefinedStateScreen(),
    ),
  ],
  redirect: (context, state) {
    final supabase = Supabase.instance.client;
    final session = supabase.auth.currentSession;
    final appStateProvider =
        Provider.of<AppStateProvider>(context, listen: false);
    final playerState = appStateProvider._playerState;
    final gameState = appStateProvider._gameState;

    if (session == null) {
      return '/welcome';
    } else if (gameState == null || gameState == GameState.unpublished) {
      return '/welcome';
    } else if (playerState == PlayerState.eliminated) {
      return '/eliminated';
    } else if (gameState == GameState.completed) {
      return '/game-concluded';
    } else if (playerState == PlayerState.ineligible) {
      return '/ineligible';
    } else if (playerState == PlayerState.pendingRegistration) {
      return '/name-input';
    } else if (gameState == GameState.paused) {
      return '/paused';
    } else if (gameState == GameState.registration) {
      return '/registered';
    } else if (gameState == GameState.active) {
      return '/in-game';
    } else {
      return '/undefined-state';
    }
  },
);
