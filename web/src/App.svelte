<script lang="ts">
  import { quadIn } from "svelte/easing";
  import { fly } from "svelte/transition";
  import { playerStore, sessionStore, gameStore } from "./state";
  import Nav from "$lib/components/ui/Nav.svelte";
  import WelcomePage from "./pages/WelcomePage.svelte";
  import PausedPage from "./pages/PausedPage.svelte";
  import RegisteredPage from "./pages/RegisteredPage.svelte";
  import GameConcludedPage from "./pages/GameConcludedPage.svelte";
  import EliminatedPage from "./pages/EliminatedPage.svelte";
  import InGamePage from "./pages/InGamePage.svelte";
    import IneligiblePage from "./pages/IneligiblePage.svelte";
    import UndefinedStatePage from "./pages/UndefinedStatePage.svelte";
    import RegistrationFlow from "./pages/RegistrationFlow.svelte";

</script>

<div class="p-4">
{#if !$sessionStore || !$gameStore || !$playerStore || $gameStore.state === "unpublished"}
  <WelcomePage />
{:else}
  <Nav />
  {#if $playerStore.state === "eliminated"}
    <EliminatedPage />
  {:else if $gameStore.state === "completed"}
    <GameConcludedPage />
  {:else if $playerStore.state === "ineligible"}
    <IneligiblePage />
  {:else if $playerStore.state === "pending_registration"}
    <RegistrationFlow />
  {:else if $gameStore.state === "paused"}
    <PausedPage />
  {:else if $gameStore.state === "registration"}
    <RegisteredPage />
  {:else if $gameStore.state === "active"}
    <InGamePage />
  {:else}
    <UndefinedStatePage />
  {/if}
{/if}
</div>

<!-- {#key $currentPage}
  <div
    out:fly={{ x: -20, duration: 200, easing: quadIn }}
    in:fly={{ x: 32, delay: 200 }}
  >
    <svelte:component this={$currentPage} />
  </div>
{/key} -->