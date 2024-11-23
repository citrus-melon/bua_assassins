<script lang="ts">
    import { Button } from "$lib/components/ui/button";
    import Stats from "$lib/components/ui/Stats.svelte";
    import { isTargetShown } from "../state";
</script>

<div class="container w-fit h-[75vh] mx-auto flex flex-col justify-between">
    <h1 class="text-center text-7xl font-bold mt-8">Kill your target!</h1>
    <Stats />
    <Button onclick={() => $isTargetShown = true} class="text-2xl mb-8 rounded-full">Show Target</Button>
</div>