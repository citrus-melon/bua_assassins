<script lang="ts">
    import Button from "$lib/components/ui/button/button.svelte";
    import { showTutorialStore } from "../state";
</script>

<div class="container w-fit h-[75vh]">
    <h1 class="text-center text-7xl font-bold my-8">The Game Rules</h1>
    <ul class="list-disc">
        <li><span class="font-bold">The aim of the game:</span>At the beginning of the game, each of you will be assigned another player as a target. Players will track down and eliminate their targets until only two players remain. Whenever a player eliminates their target, they get the victim's target. Once two players remain, the winner will be determined in a final duel. During the first two hours of the game (the “witness period”), if anyone catches you “tapping” your target, the “elimination” is considered unsuccessful and you must try again at a later time.</li>
        <li><span class="font-bold">How to play:</span> Each player will receive a “target” sticker which they must stick to their back-shoulder and ensure is visible through the game.To eliminate your target, follow the instructions in the website to tap their “target” sticker with your phone! If you have an iPhone, you can likely scan with the top part of your phone; Android phones and Samsung phones will scan by tapping the back of the phone.</li>
        <li><span class="font-bold">Time and place:</span> Game play occurs at all hours and in all places, except designated sleep rooms! But please use common sense and gauge the situation to behave appropriately (so please don’t drive each other insane 😅). Don't hurt each other, or run in hallways and classrooms!</li>
        <li>The Assassins game will start when the events committee announces it, and has a hard deadline at 5:30 am Saturday morning!</li>
        <li>You can forfeit the game or leave early at any time through the app or by reaching out to us.</li>
        <li>PLEASE respect your peers and the rules of the game!!! This game is highly based on the honor code, and if disputes arise, try to settle them amongst yourselves! Remember to also be respectful of the building and other activities (run by events). We’ve worked very hard to make this game fun, so make sure to keep it fun for everyone!!!</li>
    </ul>
    <div class="w-fit mx-auto my-8"><Button class="w-full text-2xl p-8 rounded-full" on:click={() => showTutorialStore.set(false)}>Close</Button></div>
</div>