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
        
        const data = [];
        const labels = [];

        for (let date = new Date("2024-11-22T21:00:00-05:00"); date < new Date("2024-11-23T05:30:00-05:00"); date.setHours(date.getHours() + 1)) {
            const playersDiedThen = rankedPlayers.filter(player => {
                const diedAt = player.died_at?.getTime() ?? new Date("2024-11-23T05:30:00-05:00");
                const upperBound = new Date(date)
                upperBound.setHours(date.getHours() + 1);
                return diedAt < upperBound && diedAt >= date;
            });
            data.push({ x: new Date(date), y: playersDiedThen.length });
            labels.push(date.toLocaleTimeString());
        }
        console.log(data);
        
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels,
                datasets: [{
                    label: 'Eliminations Made',
                    data,
                    backgroundColor: `${colors.purple[800]}88`,
                    borderColor: colors.red,
                    borderRadius: 10,
                    borderWidth: 2,
                }]
            },
            options: {
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