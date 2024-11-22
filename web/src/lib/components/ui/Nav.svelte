<script lang="ts">
    import Button from "./button/button.svelte";
    import buaLogo from "$lib/assets/bua-transparent.png";
</script>

<nav class="sticky top-0 w-full h-fit">
    <div class="flex justify-between bg-blue-950 p-8 shadow-lg items-center">
        <img src={buaLogo} alt="BUA Logo" height=100 width=100/>
        <div class="grid grid-cols-3 gap-2">
            <Button class="bg-[#dd0055] items-center text-blue-950 rounded-full border-4 border-[#dd0055] hover:bg-blue-950 hover:text-[#dd0055]">Info</Button>
            <Button class="bg-[#dd0055] items-center text-blue-950 rounded-full border-4 border-[#dd0055] hover:bg-blue-950 hover:text-[#dd0055]">Log Out</Button>
            <Button class="bg-[#dd0055] items-center text-blue-950 rounded-full border-4 border-[#dd0055] hover:bg-blue-950 hover:text-[#dd0055]">Support</Button>
        </div>
    </div>
</nav>
