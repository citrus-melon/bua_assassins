<script lang="ts">
    import Button from "$lib/components/ui/button/button.svelte";
    import buaLogo from "$lib/assets/bua-transparent.png";

</script>

<main class="container w-fit mx-auto h-[100%]">
    <img src={buaLogo} alt="BUA Logo" height=500 width=500 class="mx-auto"/>
    <h1 class="text-center text-7xl font-bold mb-8">Assassins</h1>
    <div class="text-center text-2xl">Each player is assigned a target</div>
    <div class="w-fit mx-auto">
        <Button class="bg-[#dd0055] text-2xl mt-8">Join</Button>
    </div>
</main>