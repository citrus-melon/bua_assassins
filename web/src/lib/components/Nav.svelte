<script lang="ts">
    export let text="Back";
    export let showBackButton = true;

</script>

<div class="flex justify-between items-center p-4 bg-gray-800 text-white">
    <div>
        <h1 class="text-2xl font-bold">SvelteKit</h1>
    </div>
    {#if showBackButton}
        <button on:click={()=>({})} class="text-white">{text}</button>
    {/if}
</div>