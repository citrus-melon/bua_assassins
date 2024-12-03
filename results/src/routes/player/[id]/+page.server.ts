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

    return { player }
};
