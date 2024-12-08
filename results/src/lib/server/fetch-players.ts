let players: Map<string, Player> | undefined;

export const fetchPlayers = async () => {
    if (players) return players;

    const gSheetResponse = await fetch(`https://docs.google.com/spreadsheets/d/e/2PACX-1vTF39Uxa7gcMU5wzdw-usG6C6U2TFxXeA8-unq4EsepKxjTT6OE1fk0pa2Fh4L9BrKobB2McRA1c2oH/pub?gid=2046696029&single=true&output=tsv`);
    const sheetTSV = await gSheetResponse.text();
    const sheet = sheetTSV.split('\r\n').map(row => row.split('\t'));

    players = new Map<string, Player>();

    for (const row of sheet.slice(1)) {
        const [id, name, color_team, state, kills, nfc_tag, died_at, died_by, duel_rank, revived, name_ambiguous, name_assumption] = row;
        players.set(id, {
            id,
            name,
            color_team,
            state: state as PlayerState,
            kills: parseInt(kills) || 0,
            nfc_tag,
            died_at: died_at ? new Date(died_at) : undefined,
            died_by,
            duel_rank: parseInt(duel_rank) || undefined,
            revived: revived === 'TRUE',
            name_ambiguous: name_ambiguous === 'TRUE',
            name_assumption: name_assumption === 'TRUE',
        });
    }

    let i_rank = 0;

    for (const player of Array.from(players.values()).sort((a, b) => // sort by duel_rank, then died_at
        (a.duel_rank ?? Infinity) - (b.duel_rank ?? Infinity)
            || (b.died_at?.getTime() ?? 0) - (a.died_at?.getTime() ?? 0)
    )) {
        if (player.duel_rank) {
            player.rank = player.duel_rank;
            if (player.rank > i_rank) i_rank = player.rank;
        } else if (player.died_at) {
            player.rank = ++i_rank;
        }
    }

    return players;
}
