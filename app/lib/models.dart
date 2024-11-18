import 'package:flutter/material.dart';

enum PlayerState {
  loggedOut,
  eliminated,
  ineligible,
  pendingRegistration,
  active,
}

enum GameState {
  unpublished,
  preRegistration,
  registration,
  active,
  paused,
  completed,
}

class AppState {
  final PlayerState playerState;
  final GameState? gameState;

  AppState({required this.playerState, this.gameState});
}

class AppStateProvider with ChangeNotifier {
  PlayerState _playerState = PlayerState.active;
  GameState? _gameState = GameState.registration;

  PlayerState get playerState => _playerState;
  GameState? get gameState => _gameState;

  void updatePlayerState(PlayerState state) {
    _playerState = state;
    notifyListeners();
  }

  void updateGameState(GameState? state) {
    _gameState = state;
    notifyListeners();
  }
}
