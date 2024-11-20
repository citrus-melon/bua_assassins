import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum PlayerState {
  eliminated,
  ineligible,
  pendingRegistration,
  active;

  static PlayerState? fromString(String value) {
    switch (value) {
      case 'eliminated':
        return PlayerState.eliminated;
      case 'ineligible':
        return PlayerState.ineligible;
      case 'pending_registration':
        return PlayerState.pendingRegistration;
      case 'active':
        return PlayerState.active;
      default:
        return null;
      // throw ArgumentError('Invalid player state: $value');
    }
  }
}

enum GameState {
  unpublished,
  preRegistration,
  registration,
  active,
  paused,
  completed;

  static GameState? fromString(String value) {
    switch (value) {
      case 'unpublished':
        return GameState.unpublished;
      case 'pre_registration':
        return GameState.preRegistration;
      case 'registration':
        return GameState.registration;
      case 'active':
        return GameState.active;
      case 'paused':
        return GameState.paused;
      case 'completed':
        return GameState.completed;
      default:
        return null;
      // throw ArgumentError('Invalid game state: $value');
    }
  }
}

final supabase = Supabase.instance.client;

class AppStateProvider with ChangeNotifier {
  PlayerState? _playerState;
  GameState? _gameState;
  String? _playerName;
  DateTime? _gameStartTime;

  PlayerState? get playerState => _playerState;
  String? get playerName => _playerName;
  GameState? get gameState => _gameState;
  DateTime? get gameStartTime => _gameStartTime;

  void updatePlayerState(PlayerState state) {
    _playerState = state;
  }

  Future<void> refresh() async {
    final game = await supabase.from('games').select('*').single();
    final player = await supabase
        .from('players')
        .select('*')
        .eq('id', supabase.auth.currentUser!.id)
        .single();

    _gameState = GameState.fromString(game['state']);
    _playerState = PlayerState.fromString(player['state']);
    _playerName = player['name'];
    _gameStartTime = game['starts_at'];
    notifyListeners();
  }

  Future<void> setPlayerName(String name) async {
    await supabase.from('players').update({
      'name': name,
    }).eq('id', supabase.auth.currentUser!.id);
    await refresh();
  }

  Future<void> setNfcTag(String tag) async {
    await supabase.from('players').update({
      'nfc_tag': tag,
    }).eq('id', supabase.auth.currentUser!.id);
    await refresh();
  }

  Future<void> setPlayerState(String state) async {
    await supabase.from('players').update({
      'state': state,
    }).eq('id', supabase.auth.currentUser!.id);
    await refresh();
  }
}
