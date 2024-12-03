import { fetchPlayers } from "$lib/server/fetch-players";
import type { PageServerLoad } from "./$types";

export const load: PageServerLoad = async () => {
    return {
        players: await fetchPlayers()
    };
}
