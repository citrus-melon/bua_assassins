<script lang="ts">
    import FormDescription from "$lib/components/ui/form/form-description.svelte";   
    import FormField from "$lib/components/ui/form/form-field.svelte";
    import FormFieldErrors from "$lib/components/ui/form/form-field-errors.svelte";
    import FormLabel from "$lib/components/ui/form/form-label.svelte";
    import Input from "$lib/components/ui/input/input.svelte";

</script>

<main>
    <h1>You're In!</h1>
    <form method="POST">
        <FormField name="email">
          <FormLabel>Email</FormLabel>
         <FormDescription />
            <Input type="email" />
         <FormFieldErrors />
        </FormField>
    </form>
</main>