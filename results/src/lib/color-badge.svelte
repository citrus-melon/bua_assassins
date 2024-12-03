<script lang="ts">
    let { color }: {color: String} = $props();
    color = color.toLowerCase();
    const colorTitleCase = color.charAt(0).toUpperCase() + color.slice(1);
    let classes: string | undefined;
    switch (color) {
        case "black":
            classes = "text-neutral text-opacity-60";
            break;
        case "white":
            classes = "text-white";
            break;
        case "blue":
            classes = "text-true-blue-500";
            break;
    }
</script>

{#if classes}
<div class="text-base inline-block px-2 rounded-full bg-purple-950 whitespace-nowrap overflow-hidden {classes} align-middle">

    ★ {colorTitleCase} Team
</div>
{/if}