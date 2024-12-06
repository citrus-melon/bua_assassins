<script lang="ts">
    import ColorBadge from "$lib/color-badge.svelte";

    const { data } = $props();
</script>

<main class="container mx-auto p-4">
    <div class="my-8">
        <h1 class="text-6xl text-pink font-semibold">
            {data.player.name || `Name Uncertain`}
        </h1>
        {#if data.player.color_team}
            <ColorBadge color={data.player.color_team} />
        {/if}
    </div>

    <div class="grid grid-cols-2 max-w-lg">
        <div class="bg-purple-800 p-4 text-center rounded-lg">
            <div class="text-4xl">
                <span class="text-red">#</span>{data.player.rank}
            </div>
            <p class="mt-2">
                Surivived until <strong
                    ><time datetime={data.player.died_at?.toISOString()}
                        >{data.player.died_at?.toLocaleTimeString()}</time
                    ></strong
                >
            </p>
        </div>
        <div class="p-4 text-center rounded-lg">
            <div class="text-4xl">
                {data.player.kills}
            </div>
            <p class="mt-2">
                Eliminations Made <strong>(#{data.killsRank})</strong>
            </p>
        </div>
    </div>

    <strong>Eliminated by</strong>
    {data.died_by_player?.name}
</main>
