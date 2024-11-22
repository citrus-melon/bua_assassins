// This file manages state, API calls, data fetching, etc.

import {createClient, type Session} from '@supabase/supabase-js';
import { readable, readonly, writable, type Readable } from 'svelte/store';
import type { Tables, Database, Enums } from './database.types';

export const supabase = createClient<Database>(
    'https://uvytjjldwcitkqattdeq.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV2eXRqamxkd2NpdGtxYXR0ZGVxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEyMDc0NDAsImV4cCI6MjA0Njc4MzQ0MH0.yLxvsX-brf2605syFIPR12okvRpuxjpEZM1cCDd6jMQ'
);

export const gameId: number = parseInt(import.meta.env.VITE_GAME_ID) || 1;

export const sessionStore = readable<Session | null>(null, set => {
    supabase.auth.getSession().then(session => {
        set(session.data.session);
    })

    const subs = supabase.auth.onAuthStateChange((event, session) => {
        set(session);
    });

    return () => {
        subs.data.subscription.unsubscribe();
    }
});

let session: Session | null = null;
sessionStore.subscribe(value => session = value);

const internalPlayerStore = writable<Tables<'players'> | null>(null);
const internalTargetStore = writable<{
    id: string;
    name: string;
    state: Enums<'player_state'>;
    game: number;
} | null>(null);

async function fetchTarget() {
    const result = await supabase.rpc('get_target_info');
    return result.data?.[0] ?? null;
}

async function fetchPlayer() {
    const userId = session?.user.id;
    if (!userId) return null;

    const result = await supabase.from('players').select('*').eq('id', userId).single();
    return result.data;
}

export async function refreshPlayer() {
    internalPlayerStore.set(await fetchPlayer());
}

export async function refreshTarget() {
    internalTargetStore.set(await fetchTarget());
}

export async function setPlayerName(name: string) {
    const userId = session?.user.id;
    if (!userId) return;

    await supabase.from('players').update({name}).eq('id', userId);
    refreshPlayer();
}

export async function setNfcTag(nfcTag: string) {
    const userId = session?.user.id;
    if (!userId) return;

    await supabase.from('players').update({'nfc_tag': nfcTag}).eq('id', userId);
    refreshPlayer();
}

export async function setPlayerState(playerState: Enums<'player_state'>) {
    const userId = session?.user.id;
    if (!userId) return;

    await supabase.from('players').update({'state': playerState}).eq('id', userId);
    refreshPlayer();
}

export async function eliminateTarget(nfcTag: string) {
    const userId = session?.user.id;
    if (!userId) return;

    const result = await supabase.rpc('eliminate_target', {target_nfc_tag: nfcTag});
    refreshPlayer();
    refreshTarget();

    return result.data;
}

export const playerStore = readonly(internalPlayerStore);

const internalGameStore = writable<Tables<'games'> | null>(null);
export const gameStore = readonly(internalGameStore);

async function fetchGame() {
    const userId = session?.user.id;
    if (!userId) return null;

    const result = await supabase.from('games').select('*').eq('id', gameId).single();
    return result.data;
}

export async function refreshGame() {
    internalGameStore.set(await fetchGame());
}