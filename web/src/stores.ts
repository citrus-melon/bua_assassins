import type { PlayerState, GameState } from 'types';
import type { Component } from 'svelte';
import { writable } from 'svelte/store';

export const currentPage = writable<Component>();
export const playerState = writable<PlayerState>();
export const gameState = writable<GameState>();