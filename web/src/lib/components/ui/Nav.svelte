<script lang="ts">
    import Button from "./button/button.svelte";
    import buaLogo from "$lib/assets/bua-transparent.png";
    import { refreshGame, refreshPlayer, supabase } from "../../../state";

    const logout = () => {
        supabase.auth.signOut();
    }
</script>

<nav class="sticky top-0 w-full h-fit">
    <div class="flex justify-between shadow-lg items-center">
        <img src={buaLogo} alt="BUA Logo" class="h-4"/>
        <div class="grid grid-cols-2 gap-2">
            <Button onclick={() => {refreshPlayer(); refreshGame()}} class="rounded-full">Refresh</Button>
            <Button onclick={logout} class="rounded-full">Log Out</Button>
            <!-- <Button class="bg-[#dd0055] items-center text-blue-950 rounded-full border-4 border-[#dd0055] hover:bg-blue-950 hover:text-[#dd0055]">Support</Button> -->
        </div>
    </div>
</nav>
