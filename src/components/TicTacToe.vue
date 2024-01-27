<script setup>
import {ref, computed} from "vue";

const player = ref('X')
const board = ref([
    [""], [""], [""],
    [""], [""], [""],
    [""], [""], [""],
])
const calculateWinner = (squares) => {
  const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
  ]
  for (let i = 0; i < lines.length; i++) {
    const [a, b, c] = lines[i]
    if (squares[a] && squares[a] === squares[b] && squares[a] === squares[c]) {
      return squares[a]
    }
  }
  return null
}
const winner = computed(() => calculateWinner(board.value.flat()))
const makeMove = (x, y) => {
  if (winner.value) return
  if (board.value[x][y] !== '') return
  board.value[x][y] = player.value
  player.value = player.value === 'X' ? 'O' : 'X'
}
const resetGame = () => {
  board.value = [
    [""], [""], [""],
    [""], [""], [""],
    [""], [""], [""],
  ]
  player.value = 'X'
}
</script>

<template>
  <main class="text-center">
    <h1 class="tictitle">Tic Tac Toe</h1>
    <h3 class="player" v-if="!winner">Player {{player}}'s turn</h3>
    <h3 class="player" v-else>Player {{winner}} won!</h3>
    <div class="board">
      <div v-for="(row, x) in board"
           :key="x">
        <div v-for="(cell, y) in row"
             :key="y" @click="makeMove(x, y)"
             :class="'cells'">
          <i v-if="cell === 'X'" class="bi bi-x-lg"></i>
          <i v-if="cell === 'O'" class="bi bi-circle"></i>
        </div>
      </div>
    </div>
    <button class="reset" v-if="winner" @click="resetGame">Reset</button>
  </main>
</template>

<style scoped lang="scss">
  main {
    height: 100%;
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 15px;
  }
  .tictitle, .player {
    color: white;
    filter: drop-shadow(0 0 15px black);
  }
  .tictitle {
    font-size: 25px;
  }
  .player {
    font-size: 15px;
  }
  .board {
    width: 300px;
    height: 300px;
    display: grid;
    grid-template-rows: 100px 100px 100px;
    grid-template-columns: 100px 100px 100px;
    z-index: 3;
  }
  .cells {
    border: 1px solid black;
    width: 100px;
    height: 100px;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    background-color: rgba(0, 0, 0, 0.3);
    transition: all 0.5s ease;
    color: white;
    font-size: 40px;
    text-align: center;
    z-index: 2;
  }
  .cells:hover {
    background: rgba(0, 0, 0, 0.5);
  }
  .reset {
    background-color: #7e4fe3;
    margin-top: 25px;
    width: 150px;
    height: 70px;
    border-radius: 90px;
    border: none;
    font-size: 20px;
    filter: drop-shadow(0 0 15px black);
    transition: all 0.7s ease;
  }
  .reset:active {
    background-color: rgba(255, 255, 255, 0.3);
  }
</style>