<script>
import ProjectWindow from "@/components/ProjectWindow.vue";
import ToolBar from "@/components/ToolBar.vue";

export default {
  name: 'Projects',
  components: {ToolBar, ProjectWindow},
  data() {
    return {
      slug: String,
      card: Element,
      projectWindow: Element,
      isFolderOpen: false,
      isGameOpen: false,
      trigger: 0,
    }
  },
    methods: {
    openFolder() {
      this.isFolderOpen = !this.isFolderOpen
    },
    setSlug(slug) {
      this.slug = slug
      console.log(this.slug)
      this.trigger += 1
    },
    openGame() {
      this.isGameOpen = true
      this.projectWindow = document.getElementById('projectWindow')
    },
    close(value) {
      if (value[1] === 'card') {
        this.isFolderOpen = false
        console.log('card')
      }
    },
    closeProject() {
      this.isGameOpen = false
      console.log('project')
    }
  },
  async mounted() {
    this.card = document.getElementById('card')
  }
};
</script>

<template>
  <div class="side-container">
    <div v-if="isFolderOpen"><i class="bi bi-folder2-open" @click="openFolder"></i></div>
    <div v-else><i class="bi bi-folder2" @click="openFolder"></i></div>
  </div>

  <div class="container" id="card">
    <div class="card" v-if="isFolderOpen">
      <div class="card-header">
        <h3 class="title">Games</h3>
        <tool-bar :card="card" :projectWindow="projectWindow" @close-window="close"/>
      </div>
      <div class="card-body">
        <div class="game">
          <div class="game-container" @click="setSlug('shootthecrow'); openGame()">
            <div id="shoot"><i class="bi bi-bullseye" style="color: red"></i></div>
            <label for="shoot">Shoot The Crow</label>
          </div>
          <div class="game-container" @click="setSlug('piggame'); openGame()">
            <div id="pig"><i class="bi bi-dice-5" style="color: darkviolet"></i></div>
            <label for="pig">The Pig Game</label>
          </div>
          <div class="game-container" @click="setSlug('guessthenumber'); openGame()">
            <div id="guess"><i class="bi bi-patch-question" style="color: green"></i></div>
            <label for="guess">Guess The Number</label>
          </div>
        </div>
      </div>
    </div>

    <div id="projectWindow" class="container">
      <ProjectWindow :slug="slug" :trigger="trigger" v-if="isGameOpen" @close-project="closeProject" class="projectWindow"/>
    </div>
  </div>
</template>

<style lang="scss">
  .side-container{
    position: absolute;
    z-index: 15;
    font-size: 40px;
    height: 100vh;
    width: 50px;
    display: flex;
    flex-direction: column;
    right: 10px;
    top: 10px;
    color: white;
  }
  .game {
    display: flex;
    flex-direction: row;
    margin: auto;
    font-size: 30px;
    align-items: center;
    justify-content: space-between;
  }
  .game-container {
    display: flex;
    flex-direction: column;
    gap: 20px;
    width: 30%;
    height: 200px;
    border: 1px solid black;
    justify-content: center;
    align-items: center;
  }
  .game-container:active {
    background-color: grey;
  }
  .game-container i {
    font-size: 40px;
  }
  .game label{
    font-size: 20px;
  }
  .projectWindow {
    position: absolute;
    width: 1000px;
    height: 350px;
    z-index: 3;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }
</style>