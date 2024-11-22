<script lang="ts">
    import  { PlayerState } from "../../../types";

    export let state: PlayerState = PlayerState.active;
</script>

<div>
<div class="grid grid-cols-2 gap-8">
    {#if state === PlayerState.eliminated}
        <div class="text-center border-8 border-double p-4 py-12 border-[#ff0055]">
            <div class="text-4xl font-bold text-rose-300">53</div>
            <div class="text-2xl uppercase italicize">Kills</div>
        </div>
        <div class="text-center border-8 border-double p-4 py-12 border-[#ff0055]">
            <div class="text-4xl font-bold text-rose-300">53rd</div>
            <div class="text-2xl uppercase italicize">Place</div>
        </div>
    {:else if state === PlayerState.active}
        <div class="text-center border-8 border-double p-4 py-12 border-rose-300">
            <div class="text-4xl font-bold text-rose-300">53</div>
            <div class="text-2xl uppercase italicize">Kills</div>
        </div>
        <div class="text-center border-8 border-double p-4 py-12 border-rose-300">
            <div class="text-4xl font-bold text-rose-300">173</div>
            <div class="text-2xl uppercase italicize">Alive</div>
        </div>
    {/if}
</div>
{#if state === PlayerState.eliminated}
    <div class="text-center text-lg mt-8 uppercase underline text-[#ff0055]">killed by Maxwell Yu</div>
{/if}
</div>
