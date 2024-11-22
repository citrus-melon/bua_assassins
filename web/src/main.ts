import { mount } from 'svelte'
import './app.css'
import App from './App.svelte'
import { refreshGame, refreshPlayer, refreshTarget } from './state'

refreshGame();
refreshPlayer();
refreshTarget();

const app = mount(App, {
  target: document.getElementById('app')!,
})

export default app
