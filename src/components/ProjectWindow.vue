<script>
import axios from 'axios';
import { ref, onMounted } from 'vue';
import ToolBar from "@/components/ToolBar.vue";

export default {
  name: 'ProjectWindow',
  components: { ToolBar },
  props: {
    slug: String,
    isFolderOpen: Boolean,
    opacity: Number,
  },
  data() {
    return{
      card: null
    }
  },
  setup(props) {
    const projectData = ref({
      name: null,
      slug: null,
      description: null,
      gitHub: null,
      isHosted: null,
      hostLink: null,
    });

    onMounted(async () => {
      try {
        const response = await axios.get(`/api/v1/projects/`);
        const project = response.data.find(p => p.slug === props.slug);

        if (project) {
          projectData.value = {
            name: project.name,
            slug: project.slug,
            description: project.description.replace(/\\n/g, '<br>'),
            gitHub: project.github,
            isHosted: project.is_hosted,
            hostLink: project.host_link,
          };
        }
      } catch (error) {
        console.error(error);
      }
    });

    return {
      projectData,
    };
  },
  methods: {
    closeProjectWindow() {
      this.card.style.opacity = 0;
    },
  },
  mounted() {
    this.card = document.getElementById('projectWindow');
  }
};
</script>

<template>
  <section class="container" id="projectWindow">
    <div class="card">
      <div class="card-header">
        <h3 class="title">{{ projectData.name }}</h3>
        <ToolBar :card="this.card" @close="closeProjectWindow"/>
      </div>
      <div class="card-body" id="card-body">
        <div class="description" v-html="projectData.description">
        </div>
      </div>
      <div class="card-footer" id="card-footer" style="display: flex; flex-direction: row; gap: 10px">
        <a :href="projectData.gitHub" target="_blank" class="btn btn-primary">GitHub</a>
        <a v-if="projectData.isHosted" :href="projectData.hostLink" target="_blank" class="btn btn-primary">Website Link</a>
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
