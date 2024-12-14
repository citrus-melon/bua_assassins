<script lang="ts">
    import AliveOverTime from "$lib/charts/alive-over-time.svelte";
    import ColorBadge from "$lib/color-badge.svelte";
    import SearchBar from "$lib/search-bar.svelte";
    const { data } = $props();

    const playersArray = Array.from(data.players.values());

    const averageDiedAt = () => {
        const playersWithDiedAt = playersArray.filter(p => p.died_at);
        const total = playersWithDiedAt.reduce((a, b) => a + b.died_at!.getTime(), 0);
        return new Date(total / playersWithDiedAt.length);
    }
</script>

<main class="container mx-auto p-4">
    <section class="grid grid-cols-1 md:grid-cols-2 min-h-[75vh] place-items-center">
        <h1 class="text-center md:text-start my-4">
            <span class="block text-pink text-2xl font-bold">BUA Assassins 2024</span>
            <span class="block text-red text-8xl font-bold">Results</span>
        </h1>
        <div class="grid grid-cols-2 gap-4">
            <a class="bg-red rounded-lg text-purple-950 p-4 col-span-2 text-center" href="/player/df465bfb-ba27-45dd-869f-b8f3aacc7a61">
                <strong class="text-xl">1st Place</strong>
                <p class="text-5xl">Xander</p>
                <ColorBadge color="black" />
            </a>
            <a class="bg-purple-800 rounded-lg p-4" href="/player/5b78bd53-03d3-4cdf-a76c-5c35b9498865">
                <strong>2nd Place</strong>
                <div class="text-center">
                    <p class="text-3xl">Nathan Capellan</p>
                    <ColorBadge color="black" />
                </div>
            </a>
            <div>
                <strong>Most Eliminations Made</strong>
                <ul>
                    <li class="flex justify-between text-xl overflow-auto"><a href="/player/4cce97c3-234a-4059-86c6-fd65c0a5b410" class="hover:text-pink hover:underline">Quinn<ColorBadge color="blue" /></a> <span class="opacity-60 whitespace-nowrap">9 elims</span></li>
                    <li class="flex justify-between text-xl overflow-auto"><a href="/player/65139b4d-7685-4d27-b6b6-37a5499fc1b9" class="hover:text-pink hover:underline">Sam Friedman<ColorBadge color="black" /></a><span class="opacity-60 whitespace-nowrap">9 elims</span></li>
                </ul>
            </div>
            <div class="col-span-2 justify-self-center w-3/4">
                <SearchBar players={playersArray} />
            </div>
            <p class="col-span-2 text-center mt-4 text-pink">Thank you everyone for playing!</p>
        </div>
    </section>
    <section class="my-16 grid grid-cols-1 md:grid-cols-2">
        <div class="md:col-start-2 text-center">
            <h2 class="text-4xl font-bold text-pink">Some Stats</h2>
            <ul class="flex gap-x-[5%] gap-y-4 justify-center my-8 md:my-16 flex-wrap">
                <li>
                    <div class="text-4xl">{playersArray.filter(p => p.rank).length}</div>
                    <strong>Players participated</strong>
                </li>
                <li>
                    <strong>Average survival</strong>
                    <div class="text-4xl">{averageDiedAt().toLocaleTimeString()}</div>
                </li>
                <li>
                    <div class="text-4xl">408</div>
                    <strong>Taps recorded</strong>
                </li>
            </ul>
            <div class="flex gap-4 flex-wrap justify-center my-8">
                <a href="/stats" class="bg-red rounded-lg p-2 hover:bg-pink text-purple-950">
                    More Stats
                </a>
                <a class="bg-purple-800 rounded-lg p-2 hover:bg-pink hover:text-purple-800" href="https://docs.google.com/spreadsheets/d/1qVH7eN5vljXPw7NaNXZ9Gdd2V4X18npyOsYE1p-vPmk/edit?usp=sharing">
                    Raw spreadsheet
                </a>
            </div>
        </div>
        <div class="md:row-start-1">
            <figure>
                <figcaption class="text-center font-bold">Players Surviving Over Time</figcaption>
                <AliveOverTime players={playersArray} />
            </figure>
        </div>
    </section>
    <section class="my-16 grid grid-cols-1 md:grid-cols-2 justify-items-center">
        <div class="text-center my-8 md:my-16">
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
                    {#each playersArray.sort((a, b) => (a.rank ?? Infinity) - (b.rank ?? Infinity)) as player }
                    <tr class="link-whole-tr odd:bg-purple-800 odd:bg-opacity-30">
                            <td class="p-2 text-right">{player.rank}</td>
                            <td class="p-2"><a href='/player/{player.id}' class="hover:underline hover:text-pink">
                                {#if player.name}
                                    {player.name}
                                {:else}
                                    <i class="opacity-60">Name Uncertain</i>
                                {/if}
                            </a></td>
                            <td class="p-2"><ColorBadge color={player.color_team} /></td>
                            <td class="p-2">{player.kills}</td>
                            <td class="p-2">
                                {#if player.died_by === "Duel"}
                                    Final Duel
                                {:else}
                                    {player.died_at?.toLocaleTimeString()}
                                {/if}
                            </td>
                        </tr>
                    {/each}
                </tbody>
            </table>
        </div>
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