<script lang="ts">
    import AliveOverTimeTeam from "$lib/charts/alive-over-time-team.svelte";
    import AliveOverTime from "$lib/charts/alive-over-time.svelte";
    import AvgAliveTeam from "$lib/charts/avg-alive-team.svelte";
    import EliminationsTeam from "$lib/charts/eliminations-team.svelte";
    import ElimsByHour from "$lib/charts/elims-by-hour.svelte";
    import IconBack from "~icons/tabler/chevron-left";

    const { data } = $props();
</script>

<main class="container mx-auto p-">
<header class="my-8">
    <nav class="my-4">
        <a href="/" class="text-red">
            <IconBack class="inline align-middle relative bottom-0.5" />BUA Assassins 2024 Results
        </a>
    </nav>
    <h1 class="text-5xl font-bold text-pink">Pretty Graphs</h1>
</header>
<div class="grid grid-cols-1 sm:grid-cols-2 gap-8 mb-32">
    <figure>
        <figcaption class="text-center font-bold">Overall Survival Over Time</figcaption>
        <AliveOverTime players={data.playersArray} />
    </figure>
    <figure>
        <figcaption class="text-center font-bold">Survival by STAR Team</figcaption>
        <AliveOverTimeTeam players={data.playersArray} />
    </figure>
    <figure>
        <figcaption class="text-center font-bold">Eliminations Made per STAR Team</figcaption>
        <EliminationsTeam players={data.playersArray} />
    </figure>
    <figure>
        <figcaption class="text-center font-bold">Eliminations Over Time</figcaption>
        <ElimsByHour players={data.playersArray} />
    </figure>
    <figure>
        <figcaption class="text-center font-bold">Average Survival per STAR Team</figcaption>
        <AvgAliveTeam players={data.playersArray} />
    </figure>
    <div class="place-content-center">
        <footer class="text-center">
            <p class="my-4"><strong>You seem to like data!</strong></p>
            <p class="my-4"><a class="bg-purple-800 rounded-lg p-2 hover:bg-pink hover:text-purple-800" href="https://docs.google.com/spreadsheets/d/1qVH7eN5vljXPw7NaNXZ9Gdd2V4X18npyOsYE1p-vPmk/edit?usp=sharing">
                Full/Raw Spreadsheet
            </a></p>
            <p class="my-8 text-center text-pink">Let me know if you have any fun data analysis/visualization ideas!</p>
        </footer>
    </div>
</div>
</main>