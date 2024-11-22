<script lang="ts">
  import { fade } from "svelte/transition";
  import { quadOut } from "svelte/easing";
</script>

<div class="overlay" transition:fade={{duration: 200, easing: quadOut}}>
  <span class="loader"></span>
  <span class="visually-hidden">Loading</span>
</div>

<style>
  .overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 2;
    background-color: var(--background);
    opacity: 80%;
    display: grid;
    place-items: center;
  }

  .loader {
    width: 48px;
    height: 48px;
    border: 5px solid var(--accent);
    border-bottom-color: transparent;
    border-radius: 50%;
    display: inline-block;
    box-sizing: border-box;
    animation: rotation 1s linear infinite;
  }

  @keyframes rotation {
    0% {
      transform: rotate(0deg);
    }
    100% {
      transform: rotate(360deg);
    }
  }
</style>