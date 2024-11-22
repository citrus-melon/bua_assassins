<script lang="ts">
    import { Button } from "$lib/components/ui/button";
    import { isTargetShown, targetStore } from "../state";
</script>

<div class="container w-fit h-[75vh] mx-auto flex flex-col justify-between">
    <h1 class="text-center text-5xl font-bold">Your Target</h1>
    <div class="text-center text-2xl">Do NOT show ANYONE this screen!</div>
    <div class="w-fit mx-auto text-4xl py-8">
        {$targetStore?.name}
    </div>
    <Button onclick={() => $isTargetShown = false} class="text-2xl mb-8 rounded-full">Back</Button>
</div>