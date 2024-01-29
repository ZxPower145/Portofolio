<template>
  <div class="pig-container" v-if="isPlaying">
    <main>
      <section class="player player--active" id="player-0">
        <h2 class="name">Player 1</h2>
        <p class="score"> {{score[0]}} </p>
        <div class="current">
          <p class="current-label">Current</p>
          <p class="current-score">{{current[0]}}</p>
        </div>
      </section>
      <section class="interactives">
        <img :src="require(`@/assets/piggame/dice-${diceroll}.png`)" alt="Playing dice" class="dice" />
        <button class="customBtn btn--new" @click="reset">🔄 New game</button>
        <div v-if="playing" class="dice-interact">
          <button class="customBtn" @click="roll">🎲 Roll dice</button>
          <button class="customBtn" @click="hold">📥 Hold</button>
        </div>
      </section>
      <section class="player" id="player-1">
        <h2 class="name">Player 2</h2>
        <p class="score"> {{score[1]}} </p>
        <div class="current">
          <p class="current-label">Current</p>
          <p class="current-score">{{current[1]}}</p>
        </div>
      </section>
    </main>
  </div>
  <div v-else class="description">
    <p v-html="description"></p>
    <button class="btn btn-primary playBtn" @click="isPlaying = true">Play</button>
  </div>
</template>

<script>
export default {
  name: 'PigGame',
  props: {
    description: '',
  },
  data() {
    return {
      source: '@/src/assets/piggame/dice-1.png',
      diceroll: 1,
      score: [0, 0],
      current: [0, 0],
      playerOneScore: 0,
      playerTwoScore: 0,
      winScore: 100,
      activePlayer: 0,
      playing: true,
      isPlaying: false,
    }
  },
  watch: {
    playerOneScore: function (newVal, oldVal) {
      if (newVal >= 100) {
        this.playing = false
        const playerO = document.getElementById('player-0')
        const playerT = document.getElementById('player-1')
        playerO.classList.remove('player--active')
        playerT.classList.remove('player--active')
        playerO.querySelector('.name').innerText = 'Winner 🏆'
        playerO.classList.add('winner')
        playerT.querySelector('.name').innerText = 'Loser 😭'
        playerT.classList.add('loser')
      }
    },
    playerTwoScore: function (newVal, oldVal) {
      if (newVal >= 100) {
        this.playing = false
        const playerO = document.getElementById('player-0')
        const playerT = document.getElementById('player-1')
        playerT.querySelector('.name').innerText = 'Winner 🏆'
        playerT.classList.add('winner')
        playerO.querySelector('.name').innerText = 'Loser 😭'
        playerO.classList.add('loser')
      }
    }
  },
  methods: {
    switchPlayer(currPlayer) {
      this.diceroll = 1
      if (currPlayer === 0) {
        this.activePlayer = 1
        this.current[1] = 0
        document.getElementById('player-1').classList.add('player--active')
        document.getElementById('player-0').classList.remove('player--active')
      } else {
        this.activePlayer = 0
        this.current[0] = 0
        document.getElementById('player-0').classList.add('player--active')
        document.getElementById('player-1').classList.remove('player--active')
      }
    },
    reset() {
      this.diceroll = 1
      this.score = [0, 0]
      this.current = [0, 0]
      this.activePlayer = 0
      this.playing = true
      const playerO = document.getElementById('player-0')
      const playerT = document.getElementById('player-1')
      playerO.classList.add('player--active')
      playerT.classList.remove('player--active')
      playerO.querySelector('.name').innerText = 'Player 1'
      playerO.classList.remove('winner')
      playerO.classList.remove('loser')
      playerT.querySelector('.name').innerText = 'Player 2'
      playerT.classList.remove('winner')
      playerT.classList.remove('loser')
    },
    roll() {
      this.diceroll = Math.trunc(Math.random() * 6) + 1
      if (this.activePlayer === 0) {
        this.current[0] += this.diceroll
        if (this.diceroll === 1) {
          this.current[0] = 0
          this.switchPlayer(0)
        }
      } else {
        this.current[1] += this.diceroll
        if (this.diceroll === 1) {
          this.current[1] = 0
          this.switchPlayer(1)
        }
      }
    },
    hold() {
      switch (this.activePlayer) {
        case 0:
          this.score[0] += this.current[0]
          this.playerOneScore = this.score[0]
          this.switchPlayer(0)
          break
        case 1:
          this.score[1] += this.current[1]
          this.playerTwoScore = this.score[1]
          this.switchPlayer(1)
          break
        default:
          console.error('Something unexpected happened, please try again!')
          break
      }
    }

  },
}
</script>

<style scoped lang="scss">
.winner {
  background-color: rgba(202, 56, 255, 0.5);
}
.loser {
  background-color: rgba(219, 26, 39, 0.5);
}
.pig-container {
  width: 100%;
  height: 100%;
  background-image: linear-gradient(to top left, #393682 0%, #962ebf 100%);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
main {
  width: 90%;
  height: 80%;
  display: flex;
  flex-direction: row;
  background-color: rgba(255, 255, 255, 0.35);
  backdrop-filter: blur(200px);
  filter: blur();
  box-shadow: 0 3rem 5rem rgba(0, 0, 0, 0.4);
  border-radius: 9px;
  overflow: hidden;
}

#player-0, #player-1 {
  display: flex;
  flex-direction: column;
  width: 40%;
  align-items: center;
  justify-content: space-evenly;
  padding: 4rem;
}

.interactives {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-evenly;
  width: 20%;
}

.dice-interact {
  display: flex;
  flex-direction: column;
  gap: 10px;
  justify-content: center;
  align-items: center;
}

/* ELEMENTS */
.name {
  font-size: 1.5rem;
  text-transform: uppercase;
  letter-spacing: 1px;
  word-spacing: 2px;
  font-weight: 300;
  margin-bottom: 1rem;
}

.score {
  font-size: 3rem;
  font-weight: 300;
  color: #7e4fe3;
  margin-bottom: auto;
}

.player--active {
  background-color: rgba(255, 255, 255, 0.4);
}
.player--active .name {
  font-weight: 700;
}
.player--active .score {
  font-weight: 400;
}
.player--active .current {
  opacity: 1;
}

.current {
  background-color: #542fc2;
  opacity: 0.8;
  border-radius: 9px;
  color: #fff;
  width: 150px;
  height: 80px;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  transition: all 0.75s;
}

.current-label {
  text-transform: uppercase;
  font-size: 1rem;
  color: #ddd;
}

.current-score {
  font-size: 1rem;
}

.customBtn {
  color: #444;
  background: none;
  border: none;
  font-family: inherit;
  font-size: 15px;
  text-transform: uppercase;
  cursor: pointer;
  font-weight: 400;
  transition: all 0.2s;

  background-color: white;
  background-color: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(10px);

  border-radius: 50rem;
  box-shadow: 0 1.75rem 3.5rem rgba(0, 0, 0, 0.1);
}

.customBtn::first-letter {
  font-size: 1.5rem;
}


.dice {
  height: 5rem;
  box-shadow: 0 2rem 5rem rgba(0, 0, 0, 0.2);
}

.player--winner {
  background-color: #0b42a1;
}

.player--winner .name {
  font-weight: 700;
  color: #2fb4cc;
}
</style>