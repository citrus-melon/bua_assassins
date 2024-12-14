import { browser } from "$app/environment";
import type { PageLoad } from "./$types";

const tryGetUserId = () => {
    if (!browser) return undefined;
    const storageItem = localStorage.getItem('sb-uvytjjldwcitkqattdeq-auth-token');
    if (!storageItem) return undefined;
    try {
        const parsed = JSON.parse(storageItem);
        return parsed?.user?.id;
    } catch {
        return undefined;
    }
}

export const load: PageLoad = async ({ data }) => {
    return {
        ...data,
        user: data.players.get(tryGetUserId())
    };
};