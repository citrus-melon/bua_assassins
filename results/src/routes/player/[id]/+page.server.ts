import { fetchPlayers } from "$lib/server/fetch-players";
import { error } from "@sveltejs/kit";
import type { PageServerLoad } from "./$types";
import type { EntryGenerator } from "./$types";

export const entries: EntryGenerator = async () => {
    const players = await fetchPlayers();

    return Array.from(players.values()).map(player => ({
        id: player.id
    }))
}

export const load: PageServerLoad = async ({ params }) => {
    const players = await fetchPlayers();
    const player = players.get(params.id);

    if (!player) {
        error(404, "Player not found");
    }

    const killsRank = Array.from(players.values()).sort((a, b) => b.kills - a.kills).findIndex(p => p.id === player.id) + 1;

    const kills = Array.from(players.values()).filter(p => p.died_by === player.id);

    const died_by_player = player.died_by ? players.get(player.died_by) : undefined;

    return { player, died_by_player, killsRank, kills }
};
