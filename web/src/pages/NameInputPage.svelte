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

    const submit = () => {
        if (value === '') {
            alert('Please enter your name');
            return;
        }
        
        loading = true;
        setPlayerName(value);
    }
</script>

<main>
    <h1>What's your name</h1>
    <form method="POST" onsubmit={submit}>
        <FormField name="name">
          <FormLabel>name</FormLabel>
         <FormDescription />
            <Input type="text" bind:value={value} />
         <FormFieldErrors />
        </FormField>
        <FormButton>Next</FormButton>
    </form>
    {#if loading}
        <LoadingOverlay />
    {/if}
</main>