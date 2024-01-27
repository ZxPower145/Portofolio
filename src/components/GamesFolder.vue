<script>
import TicTacToe from "@/components/TicTacToe.vue";
import ToolBar from "@/components/ToolBar.vue";
import GuessTheNumber from "@/components/GuessTheNumber.vue";
import PigGame from "@/components/PigGame.vue";
import mixin from "@/components/mixin";
export default {
  name: 'GamesFolder',
  components: {TicTacToe, ToolBar, GuessTheNumber, PigGame},
  mixins: [mixin],
  data() {
    return {
      gameFolderCard: Element,
      container: Element,
      gameBtn: Element,
      cardBody: Element,
      gameOpen: '',
      isGameOpen: false,
      title: 'Games'
    }
  },
  watch: {
    gameOpen: function (newVal, oldVal) {
      switch (newVal) {
        case '':
          this.title = 'Games'
          break
        case 'guess':
          this.title = 'Guess ?'
          break
        case 'piggame':
          this.title = 'The Pig Game'
          break
        case 'tictactoe':
          this.title = 'Tic Tac Toe'
          break
        case 'shoot':
          this.title = 'Shoot The Crow'
          break
        default:
          this.title = 'Games'
      }
    }
  },
  methods: {
    setFolderCard() {
      this.gameFolderCard = document.getElementById('gamesFolder')
    },
    openGame(slug, value) {
      this.gameOpen = slug
      this.$refs.cardBody.style.padding = '0'
      this.isGameOpen = value
      if (slug === 'shoot') {
        this.$refs.cardBody.style.overflow = 'hidden'
      }
    },
    close() {
      this.$emit('close-game-window', [true, 'game-folder'])
    },
  },
  mounted() {
    this.gameFolderCard = document.getElementById('folder-card')
    this.container = document.getElementById('container')
  }
}
</script>

<template>
  <div class="card" id="folder-card" ref="card" @mouseover="setFolderCard">
  <div class="card-header" id="card-header"
       @mousedown="dragMouseDown($event, $refs.card); elementStyle($refs.card, 'down', isGameOpen)"
       @touchstart="dragMouseDown($event, $refs.card); elementStyle($refs.card, 'down', isGameOpen)"
       @touchend="elementStyle($refs.card, 'up', isGameOpen)"
       @mouseup="elementStyle($refs.card, 'up', isGameOpen)">
    <div v-if="gameOpen !== ''" class="back" @click="openGame('', false)"><i class="bi bi-arrow-left-circle"></i></div>
    <h6 class="tit" id="title">{{title}}</h6>
    <tool-bar class="toolbar" id="toolbar" :card="gameFolderCard" :container="container" @close-window="close"/>
  </div>
  <div class="card-body" id="card-body" ref="cardBody">
    <div class="game-selecter" v-if="gameOpen === ''">
      <div class="game-container" id="guess-container" ref="guess"
        @mouseover="moveGameBtn($refs.guess, 'up')"
        @mouseleave="moveGameBtn($refs.guess,'down')">
        <div class="game" id="guess" @click="openGame('guess', true)">
          <img src='@/assets/guess.png' alt="Guess" class="gImage"/>
          <label for="guess" class="game-label">Guess The Number</label>
        </div>
      </div>

      <div class="game-container" id="pig-container" ref="pig"
        @mouseover="moveGameBtn($refs.pig, 'up')"
        @mouseleave="moveGameBtn($refs.pig,'down')">
        <div class="game" id="pig" @click="openGame('piggame', true)">
          <img src='@/assets/dice.jpg' alt="Pig Game" class="gImage"/>
          <label for="pig" class="game-label">The Pig Game</label>
        </div>
      </div>

      <div class="game-container" ref="tictactoe" id="tictac-container"
           @mouseover="moveGameBtn($refs.tictactoe, 'up')"
           @mouseleave="moveGameBtn($refs.tictactoe, 'down')">
        <div class="game" id="tictactoe" @click="openGame('tictactoe', true)">
          <img src='@/assets/tictac.png' alt="TicTac"  class="gImage"/>
          <label for="tictactoe" class="game-label">Tic Tac Toe</label>
        </div>
      </div>

      <div class="game-container" ref="shoot" id="shoot-container"
           @mouseover="moveGameBtn($refs.shoot, 'up')"
           @mouseleave="moveGameBtn($refs.shoot, 'down')">
        <div class="game" id="shoot" @click="openGame('shoot', true)">
          <img src='@/assets/shoot.png' alt="Shoot"  class="gImage"/>
          <label for="shoot" class="game-label">Shoot The Crow</label>
        </div>
      </div>
    </div>
    <GuessTheNumber v-if="gameOpen === 'guess'" :class="'gameWindow'"/>
    <PigGame v-if="gameOpen === 'piggame'" :class="'gameWindow'"/>
    <img src="@/assets/shootthecrowimg.png" v-if="gameOpen === 'shoot'" :class="'gameImage'">
    <TicTacToe v-if="gameOpen === 'tictactoe'" :class="'gameWindow'"/>
  </div>
  <div class="card-footer" ref="cardFooter">
    <a class="btn btn-outline-primary"
       v-if="gameOpen === 'piggame'"
       href="https://github.com/ZxPower145/pig-game"
       target="_blank">
      Github
    </a>
    <a class="btn btn-outline-primary"
       v-if="gameOpen === 'guess'"
       href="https://github.com/ZxPower145/guess-the-number"
       target="_blank">
      Github
    </a>
    <a class="btn btn-outline-primary"
       v-if="gameOpen === 'shoot'"
       href="https://github.com/ZxPower145/shoot-the-crow"
       target="_blank">
      Github
    </a>
  </div>
</div>
</template>

<style scoped lang="scss">
  .btn {
    text-transform: uppercase;
  }
  .game-container {
    display: flex;
    justify-content: center;
    grid-row: span 3;
  }
  .gameImage{
    width: 100%;
  }
  .game {
    display: flex;
    flex-direction: row;
    align-items: center;
    width: 90%;
    height: 100px;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(20px);
    border-radius: 20px;
    box-shadow: 0 0 35px 2px black;
  }
  .game .game-label {
    color: black;
    text-align: center;
    width: 100%;
    height: 30px;
    font-size: 25px;
    margin-left: 5px;
    margin-right: 5px;
  }

  .gameWindow {
    grid-row: span 3;
  }
  i {
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .tit {
    font-size: 30px;
  }
  .card-body {
    padding: 0;
  }

  .gImage {
    width: 70px;
    height: 70px;
    object-fit: cover;
    border-radius: 99px;
    box-shadow: 0 0 15px 1px black;
    margin-left: 25px;
  }
  .game-selecter {
    grid-row: span 3;
    display: flex;
    flex-direction: column;
    justify-content: space-evenly;
  }
  @media screen and (max-width: 200px) {
    .card, .card-body {
      width: 300px;
    }

    .game-container {
      height: 100%;
    }

    .gImage {
      width: 60px;
      height: 60px;
    }
  }
</style>