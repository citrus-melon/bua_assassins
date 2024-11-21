<script lang="ts">
    import Nav from './lib/components/Nav.svelte';
    import { currentPage } from './stores';
    import WelcomeScreen from './pages/WelcomeScreen.svelte';

    const routeHash = () => {
        $currentPage = WelcomeScreen;
    }
    routeHash();
    window.addEventListener('hashchange', routeHash);

</script>

{#key $currentPage}
    <Nav />
    <svelte:component this={$currentPage} />
{/key}