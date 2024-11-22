<script lang="ts">
    import Button from "$lib/components/ui/button/button.svelte";
    import Nav from "$lib/components/ui/Nav.svelte";
</script>

<main class="h-lvh bg-blue-950 text-white w-full">
    <div class="container w-fit h-[75vh] mx-auto flex flex-col justify-between">
        <h1 class="text-center text-7xl font-bold mt-8">You're In!</h1>
        <div class="text-center text-2xl">The game will start soon.</div>
        <div class="w-fit mx-auto">
            <Button class="bg-[#dd0055] text-blue-950 text-2xl mb-8 p-8 rounded-full border-8 border-[#dd0055] hover:bg-blue-950 hover:text-[#dd0055]">How To Play</Button>
        </div>
    </div>
</main>