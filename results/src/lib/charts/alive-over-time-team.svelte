<script lang="ts">
    import { onDestroy, onMount } from 'svelte';
    import { Chart } from 'chart.js/auto';
    import { colors, colorTeams, teamToColor } from './chart-config';
    import { goto } from '$app/navigation';

    const { players }: { players: Player[] } = $props();

    let canvas: HTMLCanvasElement;

    let chart: Chart | undefined = $state();

    onMount(() => {
        const ctx = canvas.getContext('2d');
        if (!ctx) return;

        const rankedPlayers = players.filter(player => player.rank !== undefined)
        
        const datasets = [];
        for (const team of colorTeams) {
            const teamPlayers = rankedPlayers.filter(player => player.color_team?.toLowerCase() === team);

            let alive = teamPlayers.length;
            const dataPoints: { x: Date, y: number, player?: Player }[] = [{ x: new Date("2024-11-22T21:35:00-05:00"), y: alive }];
    
            for (const player of teamPlayers.sort((a, b) => (a.died_at?.getTime() ?? 0) - (b.died_at?.getTime() ?? 0))) {
                if (!player.died_at) continue;
                alive--;
                dataPoints.push({ x: player.died_at, y: alive, player });
            }

            dataPoints.push({ x: new Date("2024-11-23T05:30:00-05:00"), y: alive });

            datasets.push({
                label: team,
                data: dataPoints,
                cubicInterpolationMode: 'monotone' as const,
                borderColor: teamToColor[team],
                pointHoverBorderColor: colors.white,
            });
        }

        new Chart(ctx, {
            type: 'line',
            data: { datasets },
            options: {
                scales: {
                    x: { type: 'time', },
                    y: { title: { display: true, text: 'Players Alive' } },
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
                }
            },
        });
    });

    onDestroy(() => {
        chart?.destroy();
    });

</script>

<p class="opacity-60 text-center text-sm">Click on legend labels to show/hide teams</p>
<div class="relative" style="aspect-ratio: {chart?.aspectRatio};">
    <canvas bind:this={canvas}></canvas>
</div>