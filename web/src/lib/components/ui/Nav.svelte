<script lang="ts">
    import Button from "./button/button.svelte";
    import buaLogo from "$lib/assets/bua-transparent.png";
</script>

<nav>
    <div class="w-full flex justify-between bg-blue-950 p-8 shadow-lg items-center">
        <img src={buaLogo} alt="BUA Logo" height=100 width=100/>
        <div class="grid grid-cols-3 gap-2">
            <Button class="bg-[#dd0055] items-center">Info</Button>
            <Button class="bg-[#dd0055] items-center">Log Out</Button>
            <Button class="bg-[#dd0055] items-center">Support</Button>
        </div>
    </div>
</nav>
