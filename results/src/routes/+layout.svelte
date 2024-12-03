<script lang="ts">
    import { updated } from '$app/stores';
	import '../app.css';
	let { children } = $props();

	$effect(() => {
		if ($updated) {
			location.reload();
		}
	})
</script>

{@render children()}
