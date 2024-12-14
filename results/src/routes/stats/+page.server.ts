import { fetchPlayers } from "$lib/server/fetch-players";
import type { PageServerLoad } from "./$types";

export const load: PageServerLoad = async () => {
    const players = await fetchPlayers();

    return {
        playersArray: Array.from(players.values())
    };
}
