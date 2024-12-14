<script lang="ts">
    import { onMount } from 'svelte';
    import { Chart } from 'chart.js/auto';
    import { colors } from './chart-config';
    import { goto } from '$app/navigation';

    const { players }: { players: Player[] } = $props();

    let canvas: HTMLCanvasElement;

    onMount(() => {
        const ctx = canvas.getContext('2d');
        if (!ctx) return;

        const rankedPlayers = players.filter(player => player.rank !== undefined)
        
        let alive = rankedPlayers.length;
        const dataPoints: { x: Date, y: number, player?: Player }[] = [{ x: new Date("2024-11-22T21:35:00-05:00"), y: alive }];

        for (const player of rankedPlayers.sort((a, b) => (a.died_at?.getTime() ?? 0) - (b.died_at?.getTime() ?? 0))) {
            if (!player.died_at) continue;
            alive--;
            dataPoints.push({ x: player.died_at, y: alive, player });
        }

        new Chart(ctx, {
            type: 'line',
            data: {
                datasets: [{
                    label: 'Players Alive',
                    data: dataPoints,
                    fill: true,
                    cubicInterpolationMode: 'monotone',
                    borderColor: colors.red,
                    backgroundColor: `${colors.purple[800]}44`,
                }]
            },
            options: {
                scales: {
                    x: {
                        type: 'time',
                    },
                },
                onClick(event, elements, chart) {
                    const element = elements[0];
                    if (!element) return;
                    const dataPoint: any = chart.data.datasets[element.datasetIndex].data[element.index];
                    goto(`/player/${dataPoint.player.id}`);
                },
                plugins: {
                    tooltip: {
                        callbacks: {
                            footer: ([ {raw} ]: any) => raw.player && `${raw.player.name} was eliminated`
                        }
                    },
                    legend: { display: false }
                }
            },
        });
    });

</script>

<div class="relative" style="aspect-ratio: 2;">
    <canvas bind:this={canvas}></canvas>
</div>