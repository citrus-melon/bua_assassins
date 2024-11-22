<script lang="ts">
    import Nav from "$lib/components/ui/Nav.svelte";
    import Stats from "$lib/components/ui/Stats.svelte";
    import { PlayerState } from "../types";
</script>

<main class="h-lvh bg-blue-950 text-white w-full">
    <Nav />
    <div class="container w-fit h-[75vh] mx-auto flex flex-col justify-between">
        <div>
            <h1 class="text-center text-5xl font-bold my-8">You Are Dead!</h1>
            <div class="text-center text-2xl">Better luck in the future!</div>
        </div>
        <Stats state={PlayerState.eliminated}/>
        <div class="text-center text-sm">Please return your NFC tag to Mr. Stone's hallway.</div>
    </div>
</main>