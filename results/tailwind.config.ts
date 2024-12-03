import typography from '@tailwindcss/typography';
import type { Config } from 'tailwindcss';

export default {
  content: ['./src/**/*.{html,js,svelte,ts}'],

  theme: {
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      'white': '#ffffff',
      'neutral': '#f9f9f9',
      'red': '#dd0055',
      'purple': {
        950: '#180022',
        800: '#4c215e',
      },
      'pink': '#edd4ff',
    },
    extend: {}
  },

  plugins: [typography]
} satisfies Config;
