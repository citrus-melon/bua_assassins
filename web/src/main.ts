import { mount } from 'svelte'
import './app.css'
import App from './App.svelte'
import { refreshGame, refreshPlayer, refreshTarget, sessionStore } from './state'

const unsubscribe = sessionStore.subscribe(session => {
  if (session) {
    refreshGame();
    refreshPlayer();
    refreshTarget();
    unsubscribe();
  }
})

const app = mount(App, {
  target: document.getElementById('app')!,
})

export default app
