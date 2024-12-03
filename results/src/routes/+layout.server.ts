import { fetchPlayers } from "$lib/server/fetch-players";
import type { LayoutServerLoad } from "./$types";

export const prerender = true;

export const load: LayoutServerLoad = async () => {
    return {
        players: await fetchPlayers()
    };
}
