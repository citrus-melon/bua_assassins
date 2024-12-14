<script lang="ts">
    import ColorBadge from "$lib/color-badge.svelte";
    import IconBack from "~icons/tabler/chevron-left";

    const { data } = $props();
</script>

<main class="container mx-auto p-4">
    <div class="my-8">
        <nav>
            <a href="/" class="opacity-60 text-lg">
                <IconBack class="inline align-middle relative bottom-0.5" />Home
            </a>
        </nav>
        <h1 class="text-6xl text-pink font-semibold">
            {#if data.player.name}
                {data.player.name}
            {:else}
                <i class="opacity-60">Name Uncertain</i>
            {/if}
        </h1>
        <ColorBadge color={data.player.color_team} />
    </div>

    {#if data.player.rank}
    <div class="my-8 grid grid-cols-2 max-w-lg">
        {#if data.player.rank === 1}
            <div class="bg-red text-purple-950 p-4 text-center rounded-lg">
                <div class="text-5xl">
                    #{data.player.rank}
                </div>
                <p class="mt-2">
                    <strong>Winner!</strong>
                </p>
            </div>
        {:else}
            <div class="bg-purple-800 p-4 text-center rounded-lg">
                <div class="text-4xl">
                    <span class="text-red">#</span>{data.player.rank}
                </div>
                {#if data.player.died_by === "Duel"}
                <p class="mt-2">
                    <strong>Surivived until final duel</strong>
                </p>
                {:else if data.player.died_at}
                <p class="mt-2">
                    Surivived until <strong
                        ><time datetime={data.player.died_at.toISOString()}
                            >{data.player.died_at.toLocaleTimeString()}</time
                        ></strong
                    >
                </p>
                {/if}
            </div>
        {/if}
        <div class="p-4 text-center rounded-lg">
            <div class="text-4xl">
                {data.player.kills}
            </div>
            <p class="mt-2">
                Eliminations Made <strong>(#{data.killsRank})</strong>
            </p>
        </div>
    </div>
    {:else}
    <header class="my-8 bg-red text-purple-950 p-4 rounded-lg w-fit">
        <strong>Did Not Participate</strong>
        <p class="mt-2 text-lg">
            This player signed up, but did not complete the registration process.
        </p>
        <p class="mt-2 text-lg opacity-60">
            If this was due to technical issues, I'm so sorry! I tried to resolve all of them.
        </p>
    </header>
    {/if}


    {#if data.player.name_assumption}
        <section class="my-8 bg-red text-purple-950 p-4 rounded-lg w-fit">
            <strong>Identity Assumption</strong>
            <p class="mt-2 text-lg">
                An assumption was made to fill in the last name.
            </p>
            <p class="mt-2 opacity-60">
                If this is wrong, please let me know to correct it!
            </p>
        </section>
    {/if}

    {#if data.player.name_ambiguous}
        <section class="my-8 bg-red text-purple-950 p-4 rounded-lg w-fit">
            <strong>Identity Ambiguous</strong>
            <p class="mt-2 text-lg">
                It is impossible to determine who this is from their name.
            </p>
            <p class="mt-2 opacity-60">
                If you know, please let me know to correct it!
            </p>
        </section>
    {/if}

    {#if data.player.revived}
    <section class="my-8">
        <strong class="bg-red text-purple-950 px-2 inline-block rounded-full">Revived</strong>
        <p class="my-2">
            Found one of three revival coupons hidden throughout the building, earning a second chance in the game!
        </p>
    </section>
    {/if}
    
    {#if data.player.died_by === "Admin"}
        <section class="my-8">
            <strong class="text-red">Eliminated through Admin Action</strong>
            <p>This could have been due to technical issues or disqualification (eg. going to sleep).</p>
        </section>
    {:else if data.player.died_by === "Forfeit"}
        <section class="my-8">
            <strong class="text-red">Forfeited</strong>
            <p class="text-xl">
                Forfeited the game at <time datetime={data.player.died_at?.toISOString()}>{data.player.died_at?.toLocaleTimeString()}</time>.
            </p>
            <p class="opacity-60">
                Note: There's a chance that other reasons for elimination are incorrectly recorded as forfeitures.
            </p>
        </section>
    {:else if data.died_by_player}
    <section class="my-8">
        <strong class="text-red">Eliminated By</strong>
        <a href="/player/{data.died_by_player.id}">
            <p class="text-xl">{data.died_by_player.name} <ColorBadge color={data.died_by_player?.color_team}/></p>
        </a>
    </section>
    {/if}

    {#if data.player.kills}
    <section class="my-8">
        <strong class="text-red">Eliminations Made</strong>
        <ul>
            {#each data.kills as player}
                <li>
                    <a href="/player/{player.id}">
                        <span class="text-xl">
                            {#if player.name}
                                {player.name}
                            {:else}
                                <i class="opacity-60">Name Uncertain</i>
                            {/if}
                        </span>
                        <ColorBadge color={player.color_team}/>
                        <span class="align-middle opacity-60">at <time datetime={player.died_at?.toISOString()}>{player.died_at?.toLocaleTimeString()}</time></span>
                    </a>
                </li>
            {/each}
        </ul>
        {#if data.player.kills !== data.kills.length}
        <p class="opacity-60 mt-4">
            Details are not available for {data.player.kills - data.kills.length} eliminations. These could have been target forfeitures, or eliminations that required admin intervention.
        </p>
        {/if}
    </section>
    {/if}

    <footer class="opacity-60 mt-16">
        <p>Something look wrong? Contact me!</p>
    </footer>
</main>
