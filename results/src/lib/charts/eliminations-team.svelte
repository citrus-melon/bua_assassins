<script lang="ts">
    import { onDestroy, onMount } from 'svelte';
    import { Chart } from 'chart.js/auto';
    import { colors, colorTeams, teamToColor } from './chart-config';

    const { players }: { players: Player[] } = $props();

    let canvas: HTMLCanvasElement;

    let chart: Chart | undefined = $state();

    onMount(() => {
        const ctx = canvas.getContext('2d');
        if (!ctx) return;

        const rankedPlayers = players.filter(player => player.rank !== undefined)
        
        const data = []
        
        for (const team of colorTeams) {
            const teamPlayers = rankedPlayers.filter(player => player.color_team?.toLowerCase() === team);
            data.push(teamPlayers.reduce((a, player) => a + player.kills, 0));
        }

        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: colorTeams,
                datasets: [{
                    label: 'Eliminations Made',
                    data,
                    backgroundColor: Object.values(teamToColor).map(color => `${color}66`),
                    borderColor: Object.values(teamToColor),
                }]
            },
            options: {
                plugins: {
                    legend: {
                        display: false
                    }
                }
            },
        });
    });

    onDestroy(() => {
        chart?.destroy();
    });

</script>

<div class="grid place-items-center p-4">
    <div class="relative w-1/2" style="aspect-ratio: {chart?.aspectRatio};">
        <canvas bind:this={canvas}></canvas>
    </div>
</div>
