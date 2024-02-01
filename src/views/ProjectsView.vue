<script>
import GamesFolder from "@/components/folders/GamesFolder.vue";
import SitesFolder from "@/components/folders/SitesFolder.vue";
import NewFolder from "@/components/folders/NewFolder.vue";
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
    document.title = 'Projects'
  }
};
</script>

<template>
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

  <div class="side-container" id="side-container">
    <div class="folders">
      <div id="game-folder" class="folder" @click="openGameFolder">
        <div class="icon" v-if="isGameFolderOpen"><i class="bi bi-folder2-open"></i></div>
        <div class="icon" v-else><i class="bi bi-folder2"></i></div>
        <label for="game-folder" style="font-size: 20px">Games</label>
      </div>
      <div id="site-folder" class="folder" @click="openSitesFolder">
        <div class="icon" v-if="isSiteFolderOpen"><i class="bi bi-folder2-open"></i></div>
        <div class="icon" v-else><i class="bi bi-folder2"></i></div>
        <label for="site-folder" style="font-size: 20px">Websites</label>
      </div>
      <div id="new-folder" class="folder" @click="openNewFolder">
        <div class="icon" v-if="isNewOpen"><i class="bi bi-folder2-open"></i></div>
        <div class="icon" v-else><i class="bi bi-folder2"></i></div>
        <label for="new-folder" style="font-size: 20px">New Folder</label>
      </div>
    </div>
  </div>
</template>