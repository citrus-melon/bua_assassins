<script lang="ts">
    const { players }: { players: Player[] } = $props();
    let search = $state('');
    let selectionIndex = $state(0);
    let filteredPlayers: Player[] = $state([]);

    const onInput = () => {
        if (!search) {
            filteredPlayers = [];
            return;
        }

        selectionIndex = 0;

        const searchValue = search.toLowerCase();
        filteredPlayers = players.filter((player) =>
            player.name?.toLowerCase().includes(searchValue)
        );
    };

    const onKeyDown = (event: KeyboardEvent) => {
        if (filteredPlayers.length === 0) {
            return;
        }

        if (event.key === 'ArrowDown') {
            selectionIndex = (selectionIndex + 1) % filteredPlayers.length;
        } else if (event.key === 'ArrowUp') {
            selectionIndex--;
            if (selectionIndex < 0) selectionIndex = filteredPlayers.length - 1;
        } else if (event.key === 'Enter') {
            window.location.href = `/player/${filteredPlayers[selectionIndex].id}`;
        }
    }
</script>

<div class="relative">
    <input
        type="text"
        class="w-full p-2 rounded-lg border-purple-800 border bg-transparent focus:bg-purple-800 outline-none placeholder-opacity-40 placeholder-white"
        placeholder="Search for your own results..."
        bind:value={search}
        oninput={onInput}
        onkeydown={onKeyDown}
    />
    <ul class="absolute top-full mt-4 rounded-lg bg-purple-800 z-20 w-full">
        {#each filteredPlayers as player, i}
        <li class="p-2 {selectionIndex === i ? `text-red font-bold`: ''}">
            <a href={`/player/${player.id}`}>{player.name}</a>
        </li>
        {/each}
    </ul>
</div>