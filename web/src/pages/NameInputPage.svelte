<script lang="ts">
    import Input from "$lib/components/ui/input/input.svelte";
    import FormButton from "$lib/components/ui/form/form-button.svelte";
    import { setPlayerName } from "../state";
    import LoadingOverlay from "$lib/components/ui/LoadingOverlay.svelte";

    let value = $state('');
    let loading = $state(false);

    let { nextPage }: { nextPage: () => void } = $props();

    const submit = async (e: SubmitEvent) => {
        e.preventDefault();
        loading = true;
        await setPlayerName(value);
        nextPage();
    }
</script>

<main>
    <h1 class="text-5xl font-bold my-8">What's your name?</h1>
    <p>Please enter the name others know you by. The game depends on everyone knowing who you are!</p>
    <form onsubmit={submit}>
        <Input type="text" bind:value={value} class="my-4" />
        <div class="flex justify-end">
            <FormButton disabled={value === ''}>Next</FormButton>
        </div>
    </form>
    {#if loading}
        <LoadingOverlay />
    {/if}
</main>