<script lang="ts">
    import Button from "$lib/components/ui/button/button.svelte";
    import Stats from "$lib/components/ui/Stats.svelte";
    import { setPlayerState } from "../state";

    const save = () => {
        setPlayerState('active');
    }
    const kill = () => {
        setPlayerState('eliminated');
    }
</script>

<div class="container w-fit h-[75vh] mx-auto flex flex-col justify-between">
    <div>
        <h1 class="text-center text-5xl font-bold my-8">Was Your Death Witnessed?</h1>
    </div>
    <div class="grid grid-cols-2 gap-4">
        <Button class="text-2xl rounded-full p-8" on:click={save}>Yes</Button>
        <Button class="text-2xl rounded-full p-8" on:click={kill}>No</Button>
    </div>
</div>