import { mount } from 'svelte'
import './app.css'
import App from './App.svelte'
import { eliminateTarget, nfcOperation, playerStore, refreshGame, refreshPlayer, refreshTarget, sessionStore, setNfcTag, setPlayerState } from './state'

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

    const previousTarget = player.target;

    if (player.state === 'pending_registration') {
      await setNfcTag(uuid);
      await setPlayerState('active');
      nfcOperation.set(null);
    } else if (player.state === 'active') {
      const result = await eliminateTarget(uuid);

      if (!result) {
        return nfcOperation.set(null);
      }

      nfcOperation.set({
        success: result.id === previousTarget,
        result
      });
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
