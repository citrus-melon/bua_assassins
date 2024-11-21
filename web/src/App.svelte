<script lang="ts">
  import { quadIn } from "svelte/easing";
  import { fly } from "svelte/transition";
  import { currentPage } from "./stores";
  
    if (supabase.auth.currentSession == null) {
      return '/welcome';
    } else if (appStateProvider.initialized == false) {
      return '/';
    } else if (gameState == null || gameState == GameState.unpublished) {
      return '/welcome';
    } else if (playerState == PlayerState.eliminated) {
      return '/eliminated';
    } else if (gameState == GameState.completed) {
      return '/game-concluded';
    } else if (playerState == PlayerState.ineligible) {
      return '/ineligible';
    } else if (playerState == PlayerState.pendingRegistration) {
      if (state.fullPath == '/registration/pre-registered' ||
          state.fullPath == '/registration/pair-nfc') {
        if (appStateProvider.gameState == GameState.preRegistration) {
          return '/registration/pre-registered';
        } else {
          return '/registration/pair-nfc';
        }
      } else {
        return '/registration';
      }
    } else if (gameState == GameState.paused) {
      return '/paused';
    } else if (gameState == GameState.registration) {
      print(state.fullPath);
      if (state.fullPath?.startsWith('/registered') == true) return null;
      return '/registered';
    } else if (gameState == GameState.active) {
      return '/in-game';
    } else {
      return '/undefined-state';
    }
</script>

{#key $currentPage}
  <div
    class="wrapper"
    out:fly={{ x: -20, duration: 200, easing: quadIn }}
    in:fly={{ x: 32, delay: 200 }}
  >
    <svelte:component this={$currentPage} />
  </div>
{/key}

<style>
  .wrapper {
    position: absolute;
    overflow: auto;
    padding: 1rem;
    width: 100%;
    height: 100%;
  }
</style>