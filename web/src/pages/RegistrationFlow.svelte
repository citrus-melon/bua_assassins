<script lang="ts">
    import { gameStore, playerStore, setPlayerState } from "../state";
import NameInputPage from "./NameInputPage.svelte";
    import PairNfcPage from "./PairNfcPage.svelte";
    import PreregisteredPage from "./PreregisteredPage.svelte";

    let step = $state(0);

    const thingy = async () => {
        if ($playerStore?.nfc_tag) {
            await setPlayerState('active');
        }
        step = 1;
    }
</script>

{#if step === 0}
    <NameInputPage nextPage={thingy}/>
{:else}
    {#if $gameStore?.state === "pre_registration"}
        <PreregisteredPage />
    {:else}
        <PairNfcPage />
    {/if}
{/if}