import { fetchPlayers } from "$lib/server/fetch-players";
import type { EntryGenerator } from "./$types";

export const entries: EntryGenerator = async () => {
    const players = await fetchPlayers();

    return Array.from(players.values()).map(player => ({
        id: player.id
    }))
}
