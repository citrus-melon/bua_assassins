<script lang="ts">
  import { quadIn } from "svelte/easing";
  import { fly } from "svelte/transition";
  import { playerStore, sessionStore, gameStore } from "./state";
  import NameInputPage from "./pages/NameInputPage.svelte";
  import PairNfcPage from "./pages/PairNfcPage.svelte";
  import Nav from "$lib/components/ui/Nav.svelte";
  import WelcomePage from "./pages/WelcomePage.svelte";
  import PausedPage from "./pages/PausedPage.svelte";
  import RegisteredPage from "./pages/RegisteredPage.svelte";
  import GameConcludedPage from "./pages/GameConcludedPage.svelte";
  import EliminatedPage from "./pages/EliminatedPage.svelte";
  import InGamePage from "./pages/InGamePage.svelte";

</script>

{#if $sessionStore}
  
{:else}

{/if}

<!-- {#key $currentPage}
  <div
    out:fly={{ x: -20, duration: 200, easing: quadIn }}
    in:fly={{ x: 32, delay: 200 }}
  >
    <svelte:component this={$currentPage} />
  </div>
{/key} -->

<style>
  .wrapper {
    position: absolute;
    overflow: auto;
    padding: 1rem;
    width: 100%;
    height: 100%;
  }
</style>