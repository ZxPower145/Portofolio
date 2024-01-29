<script>
import mixin from "@/components/mixin";
import ToolBar from "@/components/ToolBar.vue";
export default {
  name: 'SitesFolder',
  mixins: [mixin],
  components: {ToolBar},
  data() {
    return {
      newCard: Element,
      container: Element,
      openedSite: '',
      isSiteOpen: false,
      title: 'New Folder',
      projects: [],
      preview: false,
      currOpen: '',
    }
  },
  watch: {
    openedSite: function (newVal, oldVal) {
      switch (newVal) {
        case '':
          this.title = 'New Folder'
          break
        case 'student':
          this.title = 'Management'
          break
        case 'chat':
          this.title = 'ChatBot'
          break
        default:
          this.title = 'New Folder'
      }
    }
  },
  methods: {
    close() {
      this.$emit('close-new-window', [true, 'new-folder'])
      this.isSiteOpen = false
    },
    openSite(site) {
      this.openedSite = site
      this.isSiteOpen = true
      this.preview = false
      const cardbody = this.$refs.cardBody
      cardbody.style.padding = '0'
      cardbody.style.overflow = 'hidden'
      let filteredProjects = this.projects.filter((obj) => {
        if (obj.slug === site) {
          this.currOpen = obj
        }
      })
    },
    back() {
      this.openedSite = ''
      this.isSiteOpen = false
    }
  },
  async mounted() {
    await this.$nextTick(() => {
      this.newCard = document.getElementById('newFolder')
      this.container = document.getElementById('container')
    })
    this.projects = await this.getProjects('app')
  }
}
</script>

<template>
  <div class="card" id="newCard" ref="card">
    <div class="card-header" id="card-header" ref="newCardHeader"
       @mousedown="dragMouseDown($event, $refs.card); elementStyle($refs.card, 'down', isSiteOpen)"
       @touchstart="dragMouseDown($event, $refs.card)"
       @touchmove="elementStyle($refs.card, 'down', isSiteOpen)"
       @touchend="elementStyle($refs.card, 'up', isSiteOpen)"
       @mouseup="elementStyle($refs.card, 'up', isSiteOpen)">
      <div v-if="openedSite !== ''" class="back" @click="back"><i class="bi bi-arrow-left-circle"></i></div>
      <h6 class="tit" id="title">{{title}}</h6>
      <tool-bar class="toolbar" id="toolbar" :card="newCard" :container="container" @close-window="close"/>
    </div>
    <div class="card-body" id="card-body" ref="cardBody">
      <div class="loading-container" v-if="this.$store.state.isLoading[0] && this.$store.state.isLoading[1] === 'app'">
        <div class="is-loading-bar" v-bind:class="{'is-loading': $store.state.isLoading}">
          <div class="lds-dual-ring"></div>
        </div>
      </div>
      <div class="element-selector" v-else>
        <div v-for="project in projects">
          <div class="element-container" :ref="project.slug" v-if="openedSite === ''"
            @mouseover="moveElementBtn($refs[project.slug][0], 'up')"
            @mouseleave="moveElementBtn($refs[project.slug][0], 'down')">
            <div class="elementBtn" :id="project.slug" @click="openSite(project.slug.toString(), true)">
              <img :src="require(`@/assets/thumbnails/${project.slug.toLowerCase()}.png`)" :alt="project.slug"
                   class="elementThumbImage"/>
              <label :for="project.slug" class="element-label">{{project.name}}</label>
            </div>
          </div>
          <div v-else>
            <div v-if="project.slug === openedSite" class="description">
              <div v-if="!preview">
                <p v-html="project.description"></p>
                <button class="btn btn-primary playBtn" @click="preview = true">See Preview</button>
              </div>
              <div v-else>PREVIEW</div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="card-footer" id="card-footer" ref="cardFooter">
      <div v-if="openedSite !== ''" class="buttons">
        <a class="btn btn-outline-primary github" :href="currOpen.github"
           target="_blank">
          GitHub
        </a>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
  .buttons {
    display: flex;
    gap: 30px;
  }
  .buttons a {
    text-transform: uppercase;
  }

  .tit {
    font-size: 30px;
  }

  .card-body {
    overflow: hidden;
    padding: 0;
  }
  .card {
    overflow: hidden;
  }
  .description-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100%;
  }
</style>