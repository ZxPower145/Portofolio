<script>
import axios from 'axios';
import ToolBar from "@/components/ToolBar.vue";

export default {
  name: 'ProjectWindow',
  components: { ToolBar },
  props: {
    slug: String,
    isProjectOpen: Boolean,
    trigger: 0,
  },
  data() {
    return{
      projectWindow: Element,
      projectDetail: {},
      projects: [],
    }
  },
  watch: {
    trigger: function (newVal, oldVal) {
      this.getProjectDetails(this.slug)
    }
  },
  methods: {
    async getProjects() {
      this.$store.commit('setIsLoading', true)
      const response = await axios.get(`/api/v1/projects/`);
      for (let i = 0; i < response.data.length; i++) {
        this.projects.push(response.data[i]);
      }
      this.$store.commit('setIsLoading', false)
    },
    getProjectDetails(slug) {
      if (this.projects.length > 0) {
        let project = this.projects.find(obj => obj.slug === slug)
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
          console.warn('No projects found')
        }
      }
    },
    close() {
      this.$emit('close-project', true)
    }
  },
  async mounted() {
    await this.getProjects();
    this.projectWindow = document.getElementById('projectWindow')
    this.getProjectDetails(this.slug)
  }
};
</script>

<template>
  <section class="container" id="projectWindow">
    <div class="card">
      <div class="card-header">
        <h3 class="title">{{ projectDetail.name }}</h3>
        <ToolBar :card="projectWindow" @close-project-window="close()"/>
      </div>
      <div class="card-body" id="card-body">
        <div v-if="this.$store.state.isLoading" class="loading-container">
          <div class="is-loading-bar has-text-centered" v-bind:class="{'is-loading': $store.state.isLoading}">
            <div class="lds-dual-ring"></div>
          </div>
        </div>
        <div class="description" v-else v-html="projectDetail.description"></div>
      </div>
      <div class="card-footer" id="card-footer" style="display: flex; flex-direction: row; gap: 10px">
        <a :href="projectDetail.gitHub" target="_blank" class="btn btn-primary">GitHub</a>
        <a v-if="projectDetail.isHosted" :href="projectDetail.hostLink" target="_blank" class="btn btn-primary">Website Link</a>
      </div>
    </div>
  </section>
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
