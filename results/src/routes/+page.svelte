<script>
    import ColorBadge from "$lib/color-badge.svelte";

</script>
<main class="container mx-auto p-4">
    <div class="grid grid-cols-1 md:grid-cols-2 min-h-[75vh] place-items-center">
        <h1 class="text-center md:text-start my-4">
            <span class="block text-pink text-2xl font-bold">BUA Assassins 2024</span>
            <span class="block text-red text-8xl font-bold">Results</span>
        </h1>
        <div class="grid grid-cols-2 gap-4">
            <div class="bg-red rounded-lg text-purple-950 p-4 col-span-2 text-center">
                <strong class="text-xl">1st Place</strong>
                <p class="text-5xl">Xander</p>
                <ColorBadge color="black" />
            </div>
            <div class="bg-purple-800 rounded-lg p-4">
                <strong>2nd Place</strong>
                <p class="text-3xl text-center overflow-auto">Nathan Capellan</p>
                <ColorBadge color="black" />
            </div>
            <div>
                <strong>Most Eliminations Made</strong>
                <ul>
                    <li class="flex justify-between text-xl overflow-auto"><span>Quinn<ColorBadge color="blue" /></span> <span class="opacity-60 whitespace-nowrap">9 elims</span></li>
                    <li class="flex justify-between text-xl overflow-auto"><span>Sam Friedman<ColorBadge color="black" /></span><span class="opacity-60 whitespace-nowrap">9 elims</span></li>
                </ul>
            </div>
            <p class="col-span-2 text-center mt-4 text-pink">Thank you everyone for playing!</p>
        </div>
    </div>
        <div class="mx-auto w-fit mt-4">
            <a class="bg-purple-800 rounded-lg p-2 underline decoration-pink hover:bg-pink hover:text-purple-800" href="https://docs.google.com/spreadsheets/d/1qVH7eN5vljXPw7NaNXZ9Gdd2V4X18npyOsYE1p-vPmk/edit?usp=sharing">
                See the full results spreadsheet here!
            </a>
        </div>
</main>

<style>
    main::after { /* Decorative background shape */
        content: "";
        clip-path: polygon(0 0, 100% 10%, 80% 80%, 0 100%);
        position: fixed;
        top: 10vh;
        left: 0;
        width: 40%;
        height: 60vh;
        z-index: -1;
        background: white;
        opacity: 8%;
    }
</style>