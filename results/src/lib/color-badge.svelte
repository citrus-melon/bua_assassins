<script lang="ts">
    const colorToClasses = (color: string): string | undefined => {
        switch (color) {
            case "red":
                return "text-true-red-500";
            case "orange":
                return "text-true-orange-500";
            case "yellow":
                return "text-true-yellow-500";
            case "green":
                return "text-true-green-500";
            case "blue":
                return "text-true-blue-500";
            case "purple":
                return "text-true-purple-500";
            case "black":
                return "text-neutral text-opacity-60";
            case "white":
                return "text-white";
        }
    }

    let { color = '' }: {color: String | undefined } = $props();
    const colorLowerCase = $derived(color.toLowerCase());
    const colorTitleCase = $derived(color.charAt(0).toUpperCase() + color.slice(1));
    const classes = $derived(colorToClasses(colorLowerCase));
</script>

{#if classes}
<span class="text-base inline-block px-2 rounded-full bg-purple-950 whitespace-nowrap overflow-hidden {classes} align-middle">
    ★ {colorTitleCase} Team
</span>
{/if}