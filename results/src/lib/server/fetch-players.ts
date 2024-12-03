let players: Map<string, Player> | undefined;

export const fetchPlayers = async () => {
    if (players) return players;

    const gSheetResponse = await fetch(`https://docs.google.com/spreadsheets/d/e/2PACX-1vTF39Uxa7gcMU5wzdw-usG6C6U2TFxXeA8-unq4EsepKxjTT6OE1fk0pa2Fh4L9BrKobB2McRA1c2oH/pub?gid=2046696029&single=true&output=tsv`);
    const sheetTSV = await gSheetResponse.text();
    const sheet = sheetTSV.split('\n').map(row => row.split('\t'));

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

    return players;
}
