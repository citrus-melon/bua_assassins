<script lang="ts">
    import { gameStore } from "../state";
import NameInputPage from "./NameInputPage.svelte";
    import PairNfcPage from "./PairNfcPage.svelte";
    import PreregisteredPage from "./PreregisteredPage.svelte";

    let step = $state(0);
</script>

{#if step === 0}
    <NameInputPage />
{:else}
    {#if $gameStore?.state === "pre_registration"}
        <PreregisteredPage />
    {:else}
        <PairNfcPage />
    {/if}
{/if}