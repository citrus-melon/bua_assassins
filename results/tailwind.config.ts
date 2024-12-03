import typography from '@tailwindcss/typography';
import type { Config } from 'tailwindcss';
import colors from 'tailwindcss/colors'

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

      'true-red': colors.red,
      'true-orange': colors.orange,
      'true-yellow': colors.yellow,
      'true-green': colors.green,
      'true-blue': colors.blue,
      'true-purple': colors.purple,
    },
    extend: {}
  },

  plugins: [typography]
} satisfies Config;
