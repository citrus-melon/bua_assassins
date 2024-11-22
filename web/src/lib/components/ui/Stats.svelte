<script lang="ts">
    import { playerStore } from "../../../state";
</script>

<div>
<div class="grid grid-cols-2 gap-8">
    {#if $playerStore?.state === 'eliminated'}
        <div class="text-center border-8 border-double p-4 py-12 border-primary">
            <div class="text-4xl font-bold text-accent">53</div>
            <div class="text-2xl uppercase italicize">Kills</div>
        </div>
        <div class="text-center border-8 border-double p-4 py-12 border-primary">
            <div class="text-4xl font-bold text-accent">53rd</div>
            <div class="text-2xl uppercase italicize">Place</div>
        </div>
    {:else}
        <div class="text-center border-8 border-double p-4 py-12 border-accent">
            <div class="text-4xl font-bold text-accent">53</div>
            <div class="text-2xl uppercase italicize">Kills</div>
        </div>
        <div class="text-center border-8 border-double p-4 py-12 border-accent">
            <div class="text-4xl font-bold text-accent">173</div>
            <div class="text-2xl uppercase italicize">Alive</div>
        </div>
    {/if}
</div>
<!-- {#if state === PlayerState.eliminated}
    <div class="text-center text-lg mt-8 uppercase underline text-[#ff0055]">killed by Maxwell Yu</div>
{/if} -->
</div>
