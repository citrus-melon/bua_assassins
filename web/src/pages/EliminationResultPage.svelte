<script>

    import Button from "$lib/components/ui/button/button.svelte";
import { nfcOperation, playerStore } from "../state";

    const exit = () => {
        nfcOperation.set(null);
    }

</script>
<div>
    {#if !$nfcOperation || $nfcOperation === "pending" || !$nfcOperation.result}
    {:else if $nfcOperation?.success === true}
        <h1 class="text-accent text-6xl my-8">Congrats!</h1>
        <p>You killed your target!</p>
    {:else}
        {#if $nfcOperation.result.id === $playerStore?.id}
            <h1 class="text-5xl my-8">That's you!</h1>
            <p>Are you trying to check if your tag is working? Well, it is!.</p>
        {:else}
            <h1 class="text-5xl my-8">That's not your target!</h1>
            <p>That's {$nfcOperation.result.name}</p>!
        {/if}
    {/if}
    <Button onclick={exit} class="text-2xl mb-8 rounded-full">Continue Playing</Button>
</div>