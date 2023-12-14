<script>
import ProjectWindow from "@/components/ProjectWindow.vue";
import ToolBar from "@/components/ToolBar.vue";

export default {
  name: 'Projects',
  components: {ToolBar, ProjectWindow},
  data() {
    return {
      slug: null,
      isFolderOpen: false,
      card: null,
      isGameOpen: false,
      projectWindow: null,
    }
  },
  methods: {
    openGame(slug) {
      this.card.style.opacity = 0;
      this.slug = slug
      this.isGameOpen = !this.isGameOpen
    },
    openFolder() {
      this.card.style.opacity = 1;
      this.isFolderOpen = !this.isFolderOpen
    }
  },
  mounted() {
    this.card = document.getElementById('card');
  }
};
</script>

<template>
  <div class="side-container">
    <div v-if="isFolderOpen"><i class="bi bi-folder2-open" @click="openFolder"></i></div>
    <div v-else><i class="bi bi-folder2" @click="openFolder"></i></div>
  </div>
  <ProjectWindow :slug="this.slug" v-if="isGameOpen"/>
  <section class="games container" id="card">
    <div class="card" v-if="isFolderOpen">
      <div class="card-header">
        <h3 class="title">Games</h3>
        <ToolBar :card="card"/>
      </div>
      <div class="card-body" id="card-body">
        <div class="game">
          <label for="shoot">Shoot The Crow</label>
          <div id="shoot"><i class="bi bi-bullseye" style="color: red" @click="openGame('shootthecrow')"></i></div>
        </div>
        <div class="game">
          <label for="guess">Guess The Number</label>
          <div id="guess"><i class="bi bi-patch-question" style="color: green" @click="openGame('guessthenumber')">
          </i></div>
        </div>
        <div class="game">
          <label for="pig">The Pig Game</label>
          <div id="pig"><i class="bi bi-dice-5-fill" style="color: mediumpurple" @click="openGame('piggame')"></i></div>
        </div>
      </div>
    </div>
  </section>
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
    font-size: 30px;
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  .game label{
    font-size: 20px;
  }
  .games .card-body {
    display: flex;
    flex-direction: column;
    gap: 40px;
    justify-content: center;
  }
</style>