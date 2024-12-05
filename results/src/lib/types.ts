enum PlayerState {
    Active = 'active',
    Eliminated = 'eliminated',
    IncompleteRegistration = 'incomplete_registration',
    NoParticipation = 'no_participation',
}

interface Player {
    id: string;
    name?: string;
    color_team?: string;
    state: PlayerState;
    kills: number;
    nfc_tag?: string;
    died_at?: Date;
    died_by?: string;
    duel_rank?: number;
    revived: boolean;
    name_ambiguous: boolean;
    name_assumption: boolean;

    rank?: number;
}
