<script lang="ts">
    import Nav from "$lib/components/ui/Nav.svelte";
    import Stats from "$lib/components/ui/Stats.svelte";
</script>

<main class="h-lvh bg-blue-950 text-white w-full">
    <Nav />
    <div class="container w-fit h-[75vh] mx-auto flex flex-col justify-between">
        <h1 class="text-center text-7xl font-bold mt-8">VICTORY!</h1>
        <Stats />
        <div class="text-center text-sm">Please return your NFC tag to Mr. Stone's hallway.</div>
    </div>
</main>