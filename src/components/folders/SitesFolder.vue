<script>
import mixin from "@/components/mixin";
import ToolBar from "@/components/ToolBar.vue";
export default {
  name: 'SitesFolder',
  mixins: [mixin],
  components: {ToolBar},
  data() {
    return {
      sitesCard: Element,
      container: Element,
      openedSite: '',
      isSiteOpen: false,
      title: 'Websites',
      projects: [],
      seePreview: false,
      currOpen: '',
    }
  },
  watch: {
    openedSite: function (newVal, oldVal) {
      switch (newVal) {
        case '':
          this.title = 'Websites'
          break
        case 'invoice':
          this.title = 'Invoice'
          break
        case 'webstore':
          this.title = 'WebStore'
          break
        default:
          this.title = 'Websites'
      }
    }
  },
  methods: {
    close() {
      this.$emit('close-site-window', [true, 'site-folder'])
      this.isSiteOpen = false
    },
    openSite(site) {
      this.openedSite = site
      this.isSiteOpen = true
      this.seePreview = false
      const cardbody = this.$refs.cardBody
      cardbody.style.padding = '0'
      cardbody.style.overflow = 'hidden'
      let filteredProjects = this.projects.filter((obj) => {
        if (obj.slug === site) {
          this.currOpen = obj
        }
      })
    },
  },
  async mounted() {
     await this.$nextTick(() => {
      this.sitesCard = document.getElementById('sitesFolder')
      this.container = document.getElementById('container')
    })
    this.projects = await this.getProjects('website')
  }
}
</script>

<template>
  <div class="card" id="sitesCard" ref="card">
    <div class="card-header" id="card-header" ref="sitesCardHeader"
       @mousedown="dragMouseDown($event, $refs.card); elementStyle($refs.card, 'down', isSiteOpen, true)"
       @touchstart="dragMouseDown($event, $refs.card)"
       @touchmove="elementStyle($refs.card, 'down', isSiteOpen, true)"
       @touchend="elementStyle($refs.card, 'up', isSiteOpen, true)"
       @mouseup="elementStyle($refs.card, 'up', isSiteOpen, true)">
      <div v-if="openedSite !== ''" class="back" @click="openSite('')"><i class="bi bi-arrow-left-circle"></i></div>
      <h6 class="tit" id="title">{{title}}</h6>
      <tool-bar class="toolbar" id="toolbar" :card="sitesCard" :container="container" @close-window="close"/>
    </div>
    <div class="card-body" id="card-body" ref="cardBody">
      <div class="loading-container" v-if="this.$store.state.isLoading[0] && this.$store.state.isLoading[1] === 'website'">
        <div class="is-loading-bar" v-bind:class="{'is-loading': $store.state.isLoading}">
          <div class="lds-dual-ring"></div>
        </div>
      </div>
      <div class="element-selector" v-else v-if="openedSite === ''">
        <div v-for="project in projects">
          <div class="element-container" :ref="project.slug"
            @mouseover="moveElementBtn($refs[project.slug][0], 'up')"
            @mouseleave="moveElementBtn($refs[project.slug][0], 'down')">
            <div class="elementBtn" :id="project.slug" @click="openSite(project.slug.toString())">
                <img :src="require(`@/assets/thumbnails/${project.slug.toLowerCase()}.png`)" :alt="project.slug"
                     class="elementThumbImage"/>
              <label :for="project.slug" class="element-label">{{project.name}}</label>
            </div>
          </div>
        </div>
      </div>
      <div class="description" v-if="openedSite === 'invoice'">
        <div v-if="!seePreview">
          <p v-html="currOpen.description"></p>
          <button class="btn btn-primary playBtn" @click="seePreview = true">See Preview</button>
        </div>
        <img v-else src="@/assets/preview/invoiceManager.png" class="elementImage">
      </div>
      <div class="description" v-else-if="openedSite === 'webstore'">
        <div v-if="!seePreview">
          <p v-html="currOpen.description"></p>
          <button class="btn btn-primary playBtn" @click="seePreview = true">See Preview</button>
        </div>
        <img v-else src="@/assets/preview/shop.png" class="elementImage">
      </div>
    </div>
    <div class="card-footer" id="card-footer" ref="cardFooter">
      <div v-if="openedSite !== ''" class="buttons">
        <a class="btn btn-outline-primary github" :href="getLink(openedSite)" target="_blank">
          GitHub</a>
        <a v-if="openedSite === 'webstore'" class="btn btn-outline-primary" href="https://zxwebstore.com"
           target="_blank">WebSite</a>
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
    overflow-y: scroll;
    padding: 0;
  }
  .card {
    overflow: hidden;
  }

</style>