<script>
import ProjectWindow from "@/components/ProjectWindow.vue";
import ToolBar from "@/components/ToolBar.vue";
import mixin from "@/components/mixin";

export default {
  name: 'Projects',
  mixins: [mixin],
  components: {ToolBar, ProjectWindow},
  data() {
    return {
      slug: String,
      folderCard: Element,
      container: Element,
      gameBtn: Element,
      cardBody: Element,
      isFolderOpen: false,
      isGameOpen: false,
      check: false,
      games: [],
      arrCheck: 0,
    }
  },
  watch: {
    arrCheck: function (newVal, oldVal) {
      this.isGameOpen = this.games.length > 0;
    },
  },
  methods: {
    openFolder() {
      this.isFolderOpen = !this.isFolderOpen
      this.$nextTick(() => {
        this.folderCard = document.getElementById('folder-card')
      })
    },
    setActive(caller) {
      let allElements = document.querySelectorAll('.window')
      allElements.forEach(element => {
        if (element.id === caller) {
          element.classList.add('isOnTop')
        } else {
          element.classList.remove('isOnTop')
        }
      })
    },
    setProjectCard(slug) {
      let card = document.getElementById(slug)
      return card
    },
    setFolderCard() {
      this.folderCard = document.getElementById('folder-card')
    },
    openGame(slug) {
      const existingGameIndex = this.games.findIndex(existingGame => existingGame.slug === slug);
      if (existingGameIndex !== -1) {
        if (!this.games[existingGameIndex].isOpen) {
          this.games[existingGameIndex].isOpen = true
        } else {
          this.games[existingGameIndex].isOpen = false
          this.games.splice(existingGameIndex, 1)
        }
      } else {
        let game = {
          slug: slug,
          isOpen: true,
        };
        this.games.push(game);
      }
      this.arrCheck += 1;
    },
    close(value) {
      if (value[1] === 'card') {
        this.isFolderOpen = false
      }
    },
    closeProject(slug) {
      let obj = this.games.find(obj => obj.slug === slug)
      this.games.pop(obj)
      obj.isOpen = false
    },
    moveGameBtn(game, direction) {
      const gameBtn = document.getElementById(game)
      this.cardBody = document.getElementById('card-body')
      const btn = document.getElementById(`${game}-btn`)
      const image = gameBtn.querySelector('.gImage')

      gameBtn.style.transition = 'transform 1s cubic-bezier(0.37, 0, 0.63, 1) 0s, ' +
          'background-color 1.5s cubic-bezier(0.37, 0, 0.63, 1) 0s, ' +
          'box-shadow 1.5s cubic-bezier(0.37, 0, 0.63, 1) 0s'
      btn.style.transition = 'background-color 1s cubic-bezier(0.37, 0, 0.63, 1) 0s, ' +
          'box-shadow 0.75s cubic-bezier(0.37, 0, 0.63, 1) 0s, ' +
          'color 1s cubic-bezier(0.37, 0, 0.63, 1) 0s'
      if (direction === 'up') {
        this.cardBody.style.overflow = 'visible'
        this.folderCard.style.overflow = 'visible'
        gameBtn.style.transform = 'translate(0, -100%) scale(1.2) rotateX(-40deg)'
        btn.style.backgroundColor = 'rgba(100, 149, 237, 1)'
        btn.style.color = 'rgba(255, 255, 255, 1)'
        btn.style.boxShadow = '0 0 15px black'
        console.log(gameBtn.id)
        switch (gameBtn.id) {
          case 'guess':
            gameBtn.style.boxShadow = '0px 0px 30px 5px rgba(10, 202, 112, 1)'
            gameBtn.style.backgroundColor = 'rgba(0, 73, 49, 0.6)'
            image.style.filter = 'drop-shadow(0px 0px 30px rgba(10, 202, 112, 1))'
            break
          case 'pig':
            gameBtn.style.boxShadow = '0px 0px 30px 5px #f914ff'
            gameBtn.style.backgroundColor = 'rgba(157, 2, 161, 0.6)'
            image.style.filter = 'drop-shadow(0px 0px 30px #f914ff)'
            break
          case 'shoot':
            gameBtn.style.boxShadow = '0 0 50px 15px rgb(230, 21, 21)'
            gameBtn.style.backgroundColor = 'rgba(186, 17, 17, 0.6)'
            image.style.filter = 'drop-shadow(0px 0px 30px #d60020)'
            break
          default:
            console.log(`We ran out of ${gameBtn}`)
        }
      } else {
        gameBtn.style.transform = 'translate(0, 0) scale(1)'
        gameBtn.style.backgroundColor = 'transparent'
        gameBtn.style.boxShadow = '0 5px 25px 0 #000000'
        btn.style.backgroundColor = 'rgba(100, 149, 237, 0)'
        btn.style.boxShadow = '0 0 0 black'
        btn.style.color = 'rgba(255, 255, 255, 0)'
      }
    },
  },
  mounted() {
    this.container = document.getElementById('container')
    this.isFolderOpen = true
  }
};
</script>

<template>
  <section class="side-container isOnTop" @click="openFolder">
    <div id="game-folder">
      <div v-if="isFolderOpen"><i class="bi bi-folder2-open"></i></div>
      <div v-else><i class="bi bi-folder2"></i></div>
    </div>
    <label for="game-folder" style="font-size: 20px">Games</label>
  </section>

  <section class="container" id="container">
    <transition name="fade">
      <div class="card window" id="folder-card"
           v-if="isFolderOpen"
           @mousedown="setActive('folder-card')"
           @touchstart="setActive('folder-card')"
           @mouseover="setFolderCard">
        <div class="card-header" id="card-header"
             @mousedown="dragMouseDown($event, folderCard)"
             @touchstart="dragMouseDown($event, folderCard)">
          <h3 class="title">Games</h3>
          <tool-bar :card="folderCard" :container="container" @close-window="close"/>
        </div>
        <div class="card-body" id="card-body">
          <div class="games">
            <div class="game-container"
                 @mouseover="moveGameBtn('shoot', 'up')"
                 @mouseleave="moveGameBtn('shoot', 'down')">
              <div class="game" id="shoot">
                <img src='@/assets/shoot.png' alt="Shoot"  class="gImage"/>
                <label for="shoot" class="game-label">Shoot The Crow</label>
              </div>
              <button class="view btn" id="shoot-btn" @click="openGame('shootthecrow')">View</button>
            </div>

            <div class="game-container"
              @mouseover="moveGameBtn('pig', 'up')"
              @mouseleave="moveGameBtn('pig', 'down')">
              <div class="game" id="pig">
                <img src='@/assets/dice.jpg' alt="Pig Game" class="gImage"/>
                <label for="pig" class="game-label">The Pig Game</label>
              </div>
              <button class="view btn" id="pig-btn" @click="openGame('piggame')">View</button>
            </div>

            <div class="game-container"
              @mouseover="moveGameBtn('guess', 'up')"
              @mouseleave="moveGameBtn('guess', 'down')">
              <div class="game" id="guess">
                <img src='@/assets/guess.png' alt="Guess" class="gImage"/>
                <label for="guess" class="game-label">Guess The Number</label>
              </div>
              <button class="view btn" id="guess-btn" @click="openGame('guessthenumber')">View</button>
            </div>
          </div>
        </div>
        <div class="card-footer"></div>
      </div>
    </transition>
  </section>
  <section>
    <div v-for="game in games" :key="game.slug">
      <transition name="fade" :key="game.isOpen">
          <ProjectWindow
              v-if="isGameOpen"
              :id="game.slug"
              :slug="game.slug"
              :container="container"
              @mousedown="setActive(game.slug); dragMouseDown($event, setProjectCard(game.slug))"
              @touchstart="setActive(game.slug); dragMouseDown($event, setProjectCard(game.slug))"
              @close-project="closeProject(game.slug)"
              :class="'window'"/>
      </transition>
    </div>
  </section>
</template>

<style scoped>

  .view {
    position: absolute;
    left: 50%;
    top: 80%;
    transform: translateX(-50%);
    background-color: rgba(100, 149, 237, 0);
    color: rgba(255, 255, 255, 0);
  }
  .games {
    display: flex;
    width: 100%;
    height: 100%;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    background-color: transparent;
    gap: 10%;
  }
  .game-container {
    width: 25%;
    height: 85%;
    backdrop-filter: blur(20px);
  }
  .game {
    width: 100%;
    height: 100%;
    position: absolute;
    z-index: 4;
    display: grid;
    grid-template-columns: auto;
    align-content: space-around;
    border: 1px solid rgba(0, 0, 0, 0.5);
    box-shadow: 0 5px 25px 0 #000000;
    justify-items: center;
    text-align: center;
    background: transparent;
  }

  .gImage {
    width: 70px;
    height: 70px;
    border-radius: 99px;
    object-fit: fill;
    //border: 1px solid rgba(0, 0, 0, 0.5);
    filter: drop-shadow(0 0 15px black);
  }
  .game-label{
    font-size: 15px;
    font-weight: 400;
    letter-spacing: 2px;
    color: black;
  }

  .card-footer {
    height: 30px;
  }
</style>