<template>
  <div class="guess-container">
    <header>
      <h1>Guess My Number!</h1>
      <div class="number" id="number">?</div>
    </header>
    <main>
      <section class="left">
        <div class="leftish">
          <input type="number" class="guess" v-model="guess"/>
          <div class="buttons">
            <button class="btn check" @click="checkGuess()" v-if="!end">Check!</button>
            <button class="btn" @click="reset">Again!</button>
          </div>
        </div>
      </section>
      <section class="right">
        <p class="message"> {{message}} <p id="sub">Enter a number between 1-20</p></p>
        <p class="label-score">💯 Score: {{score}} </p>
        <p class="label-highscore">
          🥇 Highscore: <span class="highscore"> {{highscore}}</span>
        </p>
      </section>
    </main>
  </div>
</template>

<script>
  export default {
    name: 'Guess',
    data() {
      return {
        secretNumber: undefined,
        message: 'Start guessing...',
        score: 100,
        highscore: 0,
        guess: 0,
        end: false,
      }
    },
    watch: {
      score: function (newVal, oldVal) {
        if (newVal === 0) {
          this.bodyBackground('#800000')
          this.message = 'You lost 💥'
          this.end = true
        }
      }
    },
    methods: {
      bodyBackground(color) {
        document.querySelector('.guess-container').style.backgroundColor = color
      },
      genSecretNumber() {
        this.secretNumber = Math.trunc(Math.random() * 20) + 1
      },
      reset() {
        this.score = 100
        this.guess = 0
        this.message = 'Start guessing...'
        this.genSecretNumber()
        this.bodyBackground('#2e2e2e')
        this.$confetti.stop()
        document.getElementById('sub').style.visibility = 'visible'
        document.getElementById('number').innerText = '?'
        this.end = false
      },
      checkGuess() {
        document.getElementById('sub').style.visibility = 'hidden'
        if (!this.guess) {
          this.message = '🚫 No number'
        } else {
          if (this.score > 0) {
            switch (true) {
              case this.guess < 1 || this.guess > 20:
                this.message = 'Please insert a number between 1 - 20'
                break
              case  this.guess > this.secretNumber:
                this.message = 'Lower 👇'
                this.score -= 10
                break
              case this.guess < this.secretNumber:
                this.message = 'Higher ☝️'
                this.score -= 10
                break
              case this.guess === this.secretNumber:
                this.$confetti.start()
                document.getElementById('number').innerText = this.secretNumber
                this.message = 'Winner 🏆'
                this.highscore = this.score
                this.end = true
                this.bodyBackground('#29943b')
                setTimeout(() => {
                  this.$confetti.stop()
                }, 5000)
                break
              default:
                this.message = 'Something went wrong, please try again!'
                this.score -= 10
                break
            }
          }
        }
      }
    },
    mounted() {
      this.genSecretNumber()
    }
  }
</script>

<style scoped lang="scss">
  /* LAYOUT */
  .guess-container {
    background-color: #0f331b;
    color: #eee;
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    overflow: hidden;
  }

  header {
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 10px;
    align-items: center;
    height: 50%;
    border-bottom: 7px solid rgb(0, 73, 49);
    filter: drop-shadow(0 5px 20px rgba(0, 0, 0, 0.6));
  }

  main {
    display: flex;
    flex-direction: row;
    height: 50%;
    width: 100%;
    color: #eee;
    //align-items: center;
    //justify-content: space-evenly;
    filter: drop-shadow(0 5px 20px rgba(0, 0, 0, 0.6));
  }

  .left {
    height: 100%;
    width: 50%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 15px;
    gap: 30px;
  }
  .leftish {
    display: flex;
    flex-direction: column;
    gap: 40px;
    width: 100%;
    height: 100%;
    justify-content: center;
    align-items: center;
  }

  .right {
    height: 100%;
    width: 50%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 5px;
    font-size: 15px;
  }

  .buttons {
    display: flex;
    flex-direction: row;
    gap: 30px;
  }

  /* ELEMENTS STYLE */
  h1 {
    font-size: 2rem;
    text-align: center;
    width: 100%;
    color: rgb(62, 122, 5);
  }

  .number {
    display: flex;
    justify-content: center;
    align-items: center;
    background: rgb(0, 73, 49);
    color: rgb(10, 202, 112);
    font-size: 3rem;
    width: 75px;
    height: 75px;
    text-align: center;
  }

  .guess {
    background: none;
    border: 4px solid #eee;
    font-family: inherit;
    color: inherit;
    font-size: 3rem;
    width: 100px;
    height: 60px;
    text-align: center;
    z-index: 15;
  }

  .btn {
    border: none;
    background-color: rgb(62, 122, 5);
    color: #222;
    font-size: 25px;
    font-family: inherit;
    height: 50px;
    width: 125px;
    border-radius: 20px;
    cursor: pointer;
    z-index: 15;
  }

  .btn:hover {
    transition: background-color 0.5s ease;
    background-color: #ccc;
  }
</style>