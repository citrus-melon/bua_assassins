import { error } from "@sveltejs/kit";
import type { PageLoad } from "./$types";

export const load: PageLoad = async ({ params, parent }) => {
    const { players } = await parent();
    const player = players.get(params.id);

    if (!player) {
        error(404, "Player not found");
    }

    return { player }
};