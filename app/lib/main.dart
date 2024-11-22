import 'package:bua_assassins/models.dart';
import 'package:bua_assassins/views/demo_mode_screen.dart';
import 'package:bua_assassins/views/eliminated_screen.dart';
import 'package:bua_assassins/views/game_concluded_screen.dart';
import 'package:bua_assassins/views/in_game_screen.dart';
import 'package:bua_assassins/views/ineligible_screen.dart';
import 'package:bua_assassins/views/name_input_screen.dart';
import 'package:bua_assassins/views/pair_nfc_screen.dart';
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
  // WidgetsFlutterBinding.ensureInitialized();

  // await Supabase.initialize(
  //   url: 'https://uvytjjldwcitkqattdeq.supabase.co',
  //   anonKey:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV2eXRqamxkd2NpdGtxYXR0ZGVxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEyMDc0NDAsImV4cCI6MjA0Njc4MzQ0MH0.yLxvsX-brf2605syFIPR12okvRpuxjpEZM1cCDd6jMQ',
  // );

  // AppStateProvider appStateProvider = AppStateProvider();

  // Supabase.instance.client.auth.onAuthStateChange.listen((AuthState state) {
  //   router.refresh();
  // });

  // appStateProvider.addListener(() {
  //   router.refresh();
  // });

  // if (Supabase.instance.client.auth.currentSession != null) {
  //   appStateProvider.refresh();
  // }

  // runApp(
  //   MultiProvider(
  //       providers: [
  //         ChangeNotifierProvider.value(value: appStateProvider),
  //       ],
  //       child: MaterialApp.router(
  //         routerConfig: router,
  //       )),
  // );

  runApp(const MaterialApp(
    home: PairNfcScreen(),
  ));
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ),
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
        path: '/registration',
        builder: (context, state) => const NameInputScreen(),
        routes: [
          GoRoute(
            path: 'pre-registered',
            builder: (context, state) => const PreregisteredScreen(),
          ),
          GoRoute(
            path: 'pair-nfc',
            builder: (context, state) => const PairNfcScreen(),
          ),
        ]),
    GoRoute(
      path: '/paused',
      builder: (context, state) => const PausedScreen(),
    ),
    GoRoute(
        path: '/registered',
        builder: (context, state) => const RegisteredScreen(),
        routes: [
          GoRoute(
              path: 'demo', builder: (context, state) => const DemoModeScreen())
        ]),
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
    final appStateProvider =
        Provider.of<AppStateProvider>(context, listen: false);
    final playerState = appStateProvider.playerState;
    final gameState = appStateProvider.gameState;

    if (supabase.auth.currentSession == null) {
      return '/welcome';
    } else if (appStateProvider.initialized == false) {
      return '/';
    } else if (gameState == null || gameState == GameState.unpublished) {
      return '/welcome';
    } else if (playerState == PlayerState.eliminated) {
      return '/eliminated';
    } else if (gameState == GameState.completed) {
      return '/game-concluded';
    } else if (playerState == PlayerState.ineligible) {
      return '/ineligible';
    } else if (playerState == PlayerState.pendingRegistration) {
      if (state.fullPath == '/registration/pre-registered' ||
          state.fullPath == '/registration/pair-nfc') {
        if (appStateProvider.gameState == GameState.preRegistration) {
          return '/registration/pre-registered';
        } else {
          return '/registration/pair-nfc';
        }
      } else {
        return '/registration';
      }
    } else if (gameState == GameState.paused) {
      return '/paused';
    } else if (gameState == GameState.registration) {
      print(state.fullPath);
      if (state.fullPath?.startsWith('/registered') == true) return null;
      return '/registered';
    } else if (gameState == GameState.active) {
      return '/in-game';
    } else {
      return '/undefined-state';
    }
  },
);
