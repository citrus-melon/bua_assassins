<script lang="ts">
    import FormDescription from "$lib/components/ui/form/form-description.svelte";   
    import FormField from "$lib/components/ui/form/form-field.svelte";
    import FormFieldErrors from "$lib/components/ui/form/form-field-errors.svelte";
    import FormLabel from "$lib/components/ui/form/form-label.svelte";
    import Input from "$lib/components/ui/input/input.svelte";
    import FormButton from "$lib/components/ui/form/form-button.svelte";
    import { setPlayerName } from "../state";
    import LoadingOverlay from "$lib/components/ui/LoadingOverlay.svelte";

    let value = $state('');
    let loading = $state(false);

    let { nextPage }: { nextPage: () => void } = $props();

    const submit = async () => {
        if (value === '') {
            alert('Please enter your name');
            return;
        }
        
        loading = true;
        await setPlayerName(value);
        nextPage();
    }
</script>

<main>
    <h1>What's your name?</h1>
        <Input type="text" bind:value={value} />
        <FormButton onclick={submit}>Next</FormButton>
    {#if loading}
        <LoadingOverlay />
    {/if}
</main>