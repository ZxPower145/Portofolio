<script>
import TicTacToe from "@/components/games/TicTacToe.vue";
import ToolBar from "@/components/mixins/ToolBar.vue";
import GuessTheNumber from "@/components/games/GuessTheNumber.vue";
import PigGame from "@/components/games/PigGame.vue";
import ShootTheCrow from "@/components/games/ShootTheCrow.vue";
import mixin from "@/components/mixins/mixin";

export default {
  name: 'GamesFolder',
  components: {TicTacToe, ToolBar, GuessTheNumber, PigGame, ShootTheCrow},
  mixins: [mixin],
  data() {
    return {
      gameFolderCard: Element,
      gameBtn: Element,
      cardBody: Element,
      gameOpen: '',
      isGameOpen: false,
      title: 'Games',
      projects: [],
      currOpen: '',
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
          this.title = 'Shoot'
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
      let filteredProject = this.projects.filter((obj) => {
        if (obj.slug === this.gameOpen) {
          this.currOpen = obj
        }
      })
      if (slug === 'shoot') {
        this.$refs.cardBody.style.overflow = 'hidden'
      }
    },
    close() {
      this.$emit('close-game-window', [true, 'game-folder'])
    },
  },
  async mounted() {
    this.gameFolderCard = document.getElementById('folder-card')
    this.projects = await this.getProjects('game')
  }
}
</script>

<template>
  <div class="card" id="folder-card" ref="card" @mouseover="setFolderCard">
    <div class="card-header" id="card-header"
         @mousedown="dragMouseDown($event, $refs.card); elementStyle($refs.card, 'down', isGameOpen)"
         @touchstart="dragMouseDown($event, $refs.card)"
         @touchmove="elementStyle($refs.card, 'down', isGameOpen)"
         @touchend="elementStyle($refs.card, 'up', isGameOpen)"
         @mouseup="elementStyle($refs.card, 'up', isGameOpen)">
      <div v-if="gameOpen !== ''" class="back" @click="openGame('', false)"><i class="bi bi-arrow-left-circle"></i></div>
      <h6 class="tit" id="title">{{title}}</h6>
      <tool-bar class="toolbar" id="toolbar" :card="gameFolderCard" @close-window="close"/>
    </div>
    <div class="card-body" id="card-body" ref="cardBody">
      <div class="loading-container" v-if="this.$store.state.isLoading[0] && this.$store.state.isLoading[1] === 'game'">
        <div class="is-loading-bar" v-bind:class="{'is-loading': $store.state.isLoading}">
          <div class="lds-dual-ring"></div>
        </div>
      </div>
      <div class="element-selector" v-else v-if="gameOpen === ''">
        <div v-for="project in projects">
          <div class="element-container" :ref="project.slug"
            @mouseover="moveElementBtn($refs[project.slug][0], 'up')"
            @mouseleave="moveElementBtn($refs[project.slug][0], 'down')">
            <div class="elementBtn" :id="project.slug" @click="openGame(project.slug.toString(), true)">
              <img :src="project.get_thumbnail" :alt="project.slug"
                   class="elementThumbImage"/>
              <label :for="project.slug" class="element-label">{{project.name}}</label>
            </div>
          </div>
        </div>
      </div>
      <GuessTheNumber v-if="gameOpen === 'guess'" :description="currOpen.description" :class="'elementWindow'"/>
      <PigGame v-else-if="gameOpen === 'piggame'" :description="currOpen.description" :class="'elementWindow'"/>
      <TicTacToe v-else-if="gameOpen === 'tictactoe'" :description="currOpen.description" :class="'elementWindow'"/>
      <ShootTheCrow v-else-if="gameOpen === 'shoot'" :description="currOpen.description" :preview="currOpen.get_preview" :class="'elementWindow'"/>
    </div>
    <div class="card-footer" ref="cardFooter">
      <div v-if="gameOpen !== ''">
        <a class="btn btn-outline-primary github"
        :href="currOpen.github" target="_blank">
          GitHub
        </a>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
  .btn {
    text-transform: uppercase;
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
  @media screen and (max-width: 200px) {
    .card, .card-body {
      width: 300px;
    }

    .element-container {
      height: 100%;
    }

    .elementThumbImage {
      width: 60px;
      height: 60px;
    }
  }
</style>