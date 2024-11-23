<script lang="ts">
  import { quadIn } from "svelte/easing";
  import { fly } from "svelte/transition";
  import { isTargetShown, playerStore, sessionStore, gameStore, nfcOperation, showTutorialStore } from "./state";
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
  import HowToPlayPage from "./pages/HowToPlayPage.svelte";
    import LoadingOverlay from "$lib/components/ui/LoadingOverlay.svelte";
    import EliminationResultPage from "./pages/EliminationResultPage.svelte";
    import ViewTargetPage from "./pages/ViewTargetPage.svelte";
    import HalfDeadPage from "./pages/HalfDeadPage.svelte";

</script>

<div class="p-4">
<div class="p-2 bg-input rounded-md">Announcement: Maxwell will be in the lobby for questions and tech support from now until 9 pm!</div>
{#if !$sessionStore || !$gameStore || !$playerStore || $gameStore.state === "unpublished"}
  <WelcomePage />
{:else if $nfcOperation === 'pending'}
  <LoadingOverlay />
{:else}
  <Nav />
  {#if $showTutorialStore === true}
    <HowToPlayPage />
  {:else if $isTargetShown}
    <ViewTargetPage />
  {:else if $playerStore.state === "half_eliminated"}
    <HalfDeadPage />
  {:else if $playerStore.state === "eliminated"}
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
  {:else if $nfcOperation}
    <EliminationResultPage />
  {:else if $gameStore.state === "active"}
    <InGamePage />
  {:else}
    <UndefinedStatePage />
  {/if}
  {/if}
  <p>User id: {$playerStore?.id}</p>
</div>

<!-- {#key $currentPage}
  <div
    out:fly={{ x: -20, duration: 200, easing: quadIn }}
    in:fly={{ x: 32, delay: 200 }}
  >
    <svelte:component this={$currentPage} />
  </div>
{/key} -->