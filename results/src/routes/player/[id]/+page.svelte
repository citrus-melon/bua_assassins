<script lang="ts">
    const { data } = $props();
</script>

<main>
    <h1>{data.player.name || `Name Uncertain`}</h1>
</main>