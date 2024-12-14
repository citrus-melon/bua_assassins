import { Chart } from 'chart.js';
import 'chartjs-adapter-date-fns';

export const colors = {
    transparent: 'transparent',
    current: 'currentColor',
    white: '#ffffff',
    black: '#999999',
    neutral: '#f9f9f9',
    red: '#dd0055',
    purple: {
        950: '#180022',
        800: '#4c215e',
    },
    pink: '#edd3ff',

    trueRed: '#ef4444',
    trueOrange: '#f97316',
    trueYellow: '#f59e0b',
    trueGreen: '#22c55e',
    trueBlue: '#3b82f6',
    truePurple: '#a855f7',
};

export const colorTeams: string[] = [
    'red',
    'orange',
    'yellow',
    'green',
    'blue',
    'purple',
    'black',
    'white',
];

export const teamToColor: {[key: string]: string} = {
    "red": colors.trueRed,
    "orange": colors.trueOrange,
    "yellow": colors.trueYellow,
    "green": colors.trueGreen,
    "blue": colors.trueBlue,
    "purple": colors.truePurple,
    "black": colors.black,
    "white": colors.white,
}

Chart.defaults.color = `${colors.neutral}77`;
Chart.defaults.scale.grid.display = false;
// Chart.defaults.scale.grid.lineWidth = 2;