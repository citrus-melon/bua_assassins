<script lang="ts">
    import Button from "$lib/components/ui/button/button.svelte";
    import buaLogo from "$lib/assets/bua-transparent.png";
    import Nav from "$lib/components/ui/Nav.svelte";
    import { gameId, refreshGame, refreshPlayer, supabase } from "../state";
    import LoadingOverlay from "$lib/components/ui/LoadingOverlay.svelte";

    let loading = $state(false);

    const join = async () => {
        loading = true;
        await supabase.auth.signInAnonymously({ options: { data: {
            'type': 'player',
            'game': gameId,
            'name': '',
        }}})
        refreshGame();
        refreshPlayer();
    }
</script>

<div class="container w-fit h-[75vh] mx-auto flex flex-col justify-between">
    <div>
        <img src={buaLogo} alt="BUA Logo" height=500 width=500 class="mx-auto mt-8"/>
        <h1 class="text-center text-7xl font-bold">Assassins</h1>
    </div>
    <div class="text-center text-2xl">Each player is assigned a target</div>
    <div class="w-fit mx-auto">
        <Button onclick={join} class="bg-[#dd0055] text-blue-950 text-2xl mb-8 p-8 rounded-full border-8 border-[#dd0055] hover:bg-blue-950 hover:text-[#dd0055]">Join</Button>
    </div>
</div>

{#if loading}
    <LoadingOverlay />
{/if}