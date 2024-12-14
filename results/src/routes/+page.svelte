<script>
    import AliveOverTime from "$lib/charts/alive-over-time.svelte";
    import ColorBadge from "$lib/color-badge.svelte";
    import SearchBar from "$lib/search-bar.svelte";
    const { data } = $props();

</script>

<main class="container mx-auto p-4">
    <section class="grid grid-cols-1 md:grid-cols-2 min-h-[75vh] place-items-center">
        <h1 class="text-center md:text-start my-4">
            <span class="block text-pink text-2xl font-bold">BUA Assassins 2024</span>
            <span class="block text-red text-8xl font-bold">Results</span>
        </h1>
        <div class="grid grid-cols-2 gap-4">
            <div class="bg-red rounded-lg text-purple-950 p-4 col-span-2 text-center">
                <strong class="text-xl">1st Place</strong>
                <p class="text-5xl">Xander</p>
                <ColorBadge color="black" />
            </div>
            <div class="bg-purple-800 rounded-lg p-4">
                <strong>2nd Place</strong>
                <div class="text-center">
                    <p class="text-3xl">Nathan Capellan</p>
                    <ColorBadge color="black" />
                </div>
            </div>
            <div>
                <strong>Most Eliminations Made</strong>
                <ul>
                    <li class="flex justify-between text-xl overflow-auto"><span>Quinn<ColorBadge color="blue" /></span> <span class="opacity-60 whitespace-nowrap">9 elims</span></li>
                    <li class="flex justify-between text-xl overflow-auto"><span>Sam Friedman<ColorBadge color="black" /></span><span class="opacity-60 whitespace-nowrap">9 elims</span></li>
                </ul>
            </div>
            <div class="col-span-2 justify-self-center w-3/4">
                <SearchBar players={Array.from(data.players.values())} />
            </div>
            <p class="col-span-2 text-center mt-4 text-pink">Thank you everyone for playing!</p>
        </div>
    </section>
    <section class="mt-8">
        <AliveOverTime players={Array.from(data.players.values())} />
    </section>
    <section class="mt-8 grid grid-cols-1 md:grid-cols-2 justify-items-center">
        <div class="text-center my-4">
            <h2 class="text-4xl font-bold text-pink">Full Results</h2>
            <p class="text-lg">Click on any player for more detailed info!</p>
        </div>
        <div class="h-screen overflow-auto w-fit rounded-lg border-purple-800 border border-opacity-30 max-w-full">
            <table>
            <thead class="text-left text-red sticky top-0 bg-purple-950 z-10">
                    <tr>
                        <th class="p-2">Place</th>
                        <th class="p-2">Player</th>
                        <th class="p-2">STAR Team</th>
                        <th class="p-2">Elims</th>
                        <th class="p-2">Died At</th>
                    </tr>
                </thead>
                <tbody>
                    {#each Array.from(data.players.values()).sort((a, b) => (a.rank ?? Infinity) - (b.rank ?? Infinity)) as player }
                    <tr class="link-whole-tr odd:bg-purple-800 odd:bg-opacity-30">
                            <td class="p-2 text-right">{player.rank}</td>
                            <td class="p-2"><a href='/player/{player.id}'>
                                {#if player.name}
                                    {player.name}
                                {:else}
                                    <i class="opacity-60">Name Uncertain</i>
                                {/if}
                            </a></td>
                            <td class="p-2"><ColorBadge color={player.color_team} /></td>
                            <td class="p-2">{player.kills}</td>
                            <td class="p-2">{player.died_at?.toLocaleTimeString()}</td>
                        </tr>
                    {/each}
                </tbody>
            </table>
        </div>
    </section>
    <section class="mx-auto w-fit my-16">
        <a class="bg-purple-800 rounded-lg p-2 underline decoration-pink hover:bg-pink hover:text-purple-800" href="https://docs.google.com/spreadsheets/d/1qVH7eN5vljXPw7NaNXZ9Gdd2V4X18npyOsYE1p-vPmk/edit?usp=sharing">
            Like data? Get the raw spreadsheet here!
        </a>
    </section>

    <footer class="opacity-60 my-16 text-center">
        <p>Something look wrong? Contact me!</p>
        <p class="mt-4">Let me know if you're interested in joining a team to help improve this project!</p>
    </footer>
</main>

<style>
    main::after { /* Decorative background shape */
        content: "";
        clip-path: polygon(0 0, 100% 10%, 80% 80%, 0 100%);
        position: absolute;
        top: 10vh;
        left: 0;
        width: 40%;
        height: 60vh;
        z-index: -1;
        background: white;
        opacity: 8%;
    }

    .link-whole-tr {
        position: relative;
    }
    
    .link-whole-tr a::after {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
    }
</style>