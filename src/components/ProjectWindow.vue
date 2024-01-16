<script>
import axios from 'axios';
import ToolBar from "@/components/ToolBar.vue";
import mixin from "@/components/mixin";

export default {
  name: 'ProjectWindow',
  mixins: [mixin],
  components: { ToolBar },
  props: {
    slug: String,
    container: Element,
  },
  data() {
    return {
      projectWindow: Element,
      projectDetail: {},
      localLoading: {
        slug: '',
      },
    }
  },
  methods: {
    async getProjectDetails(slug) {
      this.localLoading.slug = slug
      const res = await axios.get(`/api/v1/projects/details/${slug}`)
      let project = res.data
      if (project) {
        this.projectDetail = {
          name: project.name,
          slug: project.slug,
          description: project.description,
          github: project.github,
          hostLink: project.host_link,
          isHosted: project.is_hosted,
          isActive: project.is_active,
        }
      } else {
        console.warn('No Project found')
      }
      this.localLoading.slug = ''
    },
    close() {
      this.$emit('close-project', true)
    },
    headerPress() {
      this.$emit('header-press', true)
    }
  },
  async mounted() {
    await this.getProjectDetails(this.slug)
    this.projectWindow = document.getElementById(this.slug)
  }
};
</script>

<template>
  <div class="card">
    <div class="card-header" id="card-header"
         @mousedown="headerPress"
         @touchstart="headerPress"
         @mousemove="headerPress">
      <h3 class="title">{{ projectDetail.name }}</h3>
      <ToolBar :card="projectWindow" :container="container" @close-project-window="close"/>
    </div>
    <div class="card-body" id="card-body">
      <div v-if="localLoading.slug" class="loading-container">
        <div class="is-loading-bar has-text-centered" v-bind:class="{'is-loading': localLoading.slug === slug}">
          <div class="lds-dual-ring"></div>
        </div>
      </div>
      <div class="description" v-else v-html="projectDetail.description"></div>
    </div>
    <div class="card-footer" id="card-footer" style="display: flex; flex-direction: row; gap: 10px">
      <a :href="projectDetail.github" target="_blank" class="btn btn-primary">GitHub</a>
      <a v-if="projectDetail.isHosted" :href="projectDetail.hostLink" target="_blank" class="btn btn-primary">Website Link</a>
    </div>
  </div>
</template>

<style lang="scss">
  $accent: rgba(0, 79, 158);

  .title {
    text-transform: uppercase;
    font-weight: bold;
    color: $accent;
  }
  .description {
    font-size: 20px;
    font-weight: normal;
  }
</style>
