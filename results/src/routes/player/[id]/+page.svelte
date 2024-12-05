<script lang="ts">
    import ColorBadge from "$lib/color-badge.svelte";

    const { data } = $props();
</script>

<main class="container mx-auto p-4">
    <div class="my-8">
        <h1 class="text-6xl text-pink font-semibold">{data.player.name || `Name Uncertain`}</h1>
        {#if data.player.color_team}
            <p> <ColorBadge color={data.player.color_team} /> </p>
        {/if}
    </div>
    {data.player.died_at}
    {data.player.died_by}
    
</main>