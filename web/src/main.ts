import { mount } from 'svelte'
import './app.css'
import App from './App.svelte'
import { eliminateTarget, nfcOperation, playerStore, refreshGame, refreshPlayer, refreshTarget, sessionStore, setNfcTag } from './state'

// window.addEventListener('popstate', () => {
  
// });

const ogUrl = new URL(window.location.href);

const tagMatch = ogUrl.pathname.match(/^\/tag\/([0-9a-fA-F-]{36})$/);
if (tagMatch) {
  const uuid = tagMatch[1];
  nfcOperation.set('pending');

  const unsubscribe = playerStore.subscribe(async player => {
    if (!player) return;
    unsubscribe();

    if (player.state === 'pending_registration') {
      await setNfcTag(uuid);
      nfcOperation.set(null);
    } else if (player.state === 'active') {
      const result = await eliminateTarget(uuid);
      nfcOperation.set(result);
    } else {
      nfcOperation.set(null);
    }
  });
}

window.history.replaceState(null, '', ogUrl.origin);

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
