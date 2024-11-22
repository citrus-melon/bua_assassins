<script lang="ts">
    import Button from "$lib/components/ui/button/button.svelte";
    import Nav from "$lib/components/ui/Nav.svelte";
    import Stats from "$lib/components/ui/Stats.svelte";
</script>

<main class="h-lvh bg-blue-950 text-white w-full">
    <Nav />
    <div class="container w-fit h-[75vh] mx-auto flex flex-col justify-between">
        <h1 class="text-center text-7xl font-bold mt-8">Kill your target!</h1>
        <Stats />
        <div class="w-3/4 mx-auto grid grid-cols-1 gap-4">
            <Button class="bg-sky-300 text-blue-950 text-2xl p-8 border-8 border-sky-300 hover:bg-blue-950 hover:text-sky-300 uppercase">Rescue</Button>
            <Button class="bg-[#dd0055] text-blue-950 text-2xl p-8 border-8 border-[#dd0055] hover:bg-blue-950 hover:text-[#dd0055] uppercase">Kill</Button>
        </div>
    </div>
</main>