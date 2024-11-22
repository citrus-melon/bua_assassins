<script lang="ts">
    import Button from "$lib/components/ui/button/button.svelte";
    import { showTutorialStore } from "../state";
</script>

<div class="container w-fit h-[75vh] mx-auto flex flex-col justify-between">
    <h1 class="text-center text-7xl font-bold mt-8">You're In!</h1>
    <div class="text-center text-2xl">We'll let you know when the game is about to start. Check back closer to game time for more instructions.</div>
    <div class="w-fit mx-auto">
        <Button class="text-2xl mb-8 p-8 rounded-full" on:click={() => showTutorialStore.set(true)}>How To Play</Button>
    </div>
</div>