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
            const total = teamPlayers.reduce((a, b) => a + (b.died_at ?? new Date("2024-11-23T05:30:00-05:00")).getTime(), 0);
            data.push(new Date(total / teamPlayers.length));
        }

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: colorTeams,
                datasets: [{
                    label: 'Average Survival Until',
                    data,
                    backgroundColor: Object.values(teamToColor).map(color => `${color}66`),
                    borderColor: Object.values(teamToColor),
                    borderRadius: 10,
                    borderWidth: 2,
                }]
            },
            options: {
                scales: {
                    y: {
                        type: 'time',
                        min: new Date("2024-11-23T00:00:00-05:00").getTime(),
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    }
                },
            },
        });
    });

    onDestroy(() => {
        chart?.destroy();
    });

</script>

<div class="relative" style="aspect-ratio: {chart?.aspectRatio};">
    <canvas bind:this={canvas}></canvas>
</div>