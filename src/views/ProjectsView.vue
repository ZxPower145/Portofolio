<script>
import GamesFolder from "@/components/GamesFolder.vue";
import SitesFolder from "@/components/SitesFolder.vue";
import NewFolder from "@/components/NewFolder.vue";
export default {
  name: 'Projects',
  components: {GamesFolder, SitesFolder, NewFolder},
  data() {
    return {
      gamesFolderCard: Element,
      siteFolderCard: Element,
      newFolder: Element,
      isSiteFolderOpen: false,
      isGameFolderOpen: false,
      isNewOpen: false,
    }
  },
  methods: {
    openGameFolder() {
      this.isGameFolderOpen = !this.isGameFolderOpen
      // this.gameOpen = ''
      this.$nextTick(() => {
        this.setActive('gamesFolder')
        this.gameFolderCard = document.getElementById('gamesFolder')
      })
    },
    openSitesFolder() {
      this.isSiteFolderOpen = !this.isSiteFolderOpen
      this.$nextTick(() => {
        this.setActive('sitesFolder')
        this.siteFolderCard = document.getElementById('sitesFolder')
      })
    },
    openNewFolder() {
      this.isNewOpen = !this.isNewOpen
      this.$nextTick(() => {
        this.setActive('newFolder')
        this.newFolder = document.getElementById('newFolder')
      })
    },
    close(value) {
      if (value[1] === 'game-folder') {
        this.isGameFolderOpen = false
      }
      if (value[1] === 'site-folder') {
        this.isSiteFolderOpen = false
      }
      if(value[1] === 'new-folder') {
        this.isNewOpen = false
      }
    },
    setActive(caller) {
      this.$nextTick(() => {
        let allElements = document.querySelectorAll('.window')
        allElements.forEach(element => {
          if (element.id === caller) {
            element.classList.add('isOnTop')
          } else {
            element.classList.remove('isOnTop')
          }
        })
      })
    },
  },
  mounted() {
    this.container = document.getElementById('container')
    this.isGameFolderOpen = true
  }
};
</script>

<template>
  <section class="side-container">
    <div class="folders">
      <div id="game-folder" @click="openGameFolder">
        <div v-if="isGameFolderOpen"><i class="bi bi-folder2-open"></i></div>
        <div v-else><i class="bi bi-folder2"></i></div>
        <label for="game-folder" style="font-size: 20px">Games</label>
      </div>
      <div id="site-folder" @click="openSitesFolder">
        <div v-if="isSiteFolderOpen"><i class="bi bi-folder2-open"></i></div>
        <div v-else><i class="bi bi-folder2"></i></div>
        <label for="site-folder" style="font-size: 20px">Websites</label>
      </div>
      <div id="new-folder" @click="openNewFolder">
        <div v-if="isNewOpen"><i class="bi bi-folder2-open"></i></div>
        <div v-else><i class="bi bi-folder2"></i></div>
        <label for="new-folder" style="font-size: 20px">New Folder</label>
      </div>
    </div>
  </section>

  <section class="container" id="container">
    <transition-group name="fade">
      <GamesFolder v-if="isGameFolderOpen"
                   @close-game-window="close"
                   @mousedown="setActive('gamesFolder')"
                   @touchstart="setActive('gamesFolder')"
                   :class="'window'"
                   :id="'gamesFolder'"/>
      <SitesFolder v-if="isSiteFolderOpen"
                   @close-site-window="close"
                   @mousedown="setActive('sitesFolder')"
                   @touchstart="setActive('sitesFolder')"
                   :class="'window'"
                   :id="'sitesFolder'"/>
      <NewFolder v-if="isNewOpen"
        @close-new-window="close"
        @mousedown="setActive('newFolder')"
        @touchstart="setActive('newFolder')"
        :class="'window'"
        :id="'newFolder'"/>
    </transition-group>
  </section>
</template>

<style lang="scss" scoped>
  .bi {
    color: #946c21
  }
  .side-container label{
    color: black;
  }
  #game-folder, #site-folder, #new-folder {
    display: flex;
    flex-direction: column;
  }
</style>