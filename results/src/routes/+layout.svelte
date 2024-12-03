<script lang="ts">
	import '../app.css';
	let { children } = $props();

    import { updated } from '$app/stores';
	$effect(() => {
		if ($updated) {
			location.reload();
		}
	})
</script>

{@render children()}
