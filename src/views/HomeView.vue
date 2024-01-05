<script>
import axios from 'axios';
import ToolBar from "@/components/ToolBar.vue";
axios.defaults.baseURL = 'http://localhost:8000';
export default {
  name: 'Home',
  components: {
    ToolBar
  },
  data () {
    return {
      card: Element,
      mainBio: '',
      secondaryBio: '',
      isOpen: true,
    }
  },
  mounted() {
    this.getBio()
    this.card = document.getElementById('card')
    document.title = 'Home'
  },
  methods: {
    async getBio() {
      this.$store.commit('setIsLoading', true)
      try {
        const response = await axios.get('api/v1/profile/1');
        this.mainBio = this.stripHtmlTags(response.data.primary_bio);
        this.secondaryBio = this.stripHtmlTags(response.data.secondary_bio);
        this.$store.commit('setIsLoading', false)
      } catch (error) {
        console.error('Error fetching bio:', error);
      }
    },
    stripHtmlTags(html) {
      const doc = new DOMParser().parseFromString(html, 'text/html');
      return doc.body.textContent || '';
    },
    close(value) {
      this.isOpen = false
    },
    open() {
      this.isOpen = !this.isOpen
    }
  },
}
</script>

<template>
  <div class="cv"><i class="bi bi-file-person" @click="open"></i></div>
  <section class="container">
    <div class="card-container" id="card">
      <div class="card" v-if="isOpen">
        <div class="card-header" id="card-header">
          <h6 class="title">WEBDEVELOPER: <span class="secondary">COSTIN BOGDAN</span></h6>
          <ToolBar :card="card" @close-window="close"/>
        </div>
        <div class="card-body" id="card-body">
          <div v-if="this.$store.state.isLoading" class="loading-container">
            <div class="is-loading-bar has-text-centered" v-bind:class="{'is-loading': $store.state.isLoading}">
              <div class="lds-dual-ring"></div>
            </div>
          </div>
          <div v-else>
            <h5 class="card-title"> {{mainBio}} </h5>
            <p class="card-text">{{secondaryBio}}</p>
          </div>
        </div>
        <div class="card-footer">
          <router-link to="/contact" class="btn btn-primary">Contact Me</router-link>
        </div>
      </div>
    </div>
  </section>
</template>


<style lang="scss" scoped>
  @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono&family=Roboto&display=swap');
  $accent: rgba(0, 79, 158);

  .cv {
    position: absolute;
    top: 20px;
    right: 20px;
    font-size: 45px;
    color: white;
    cursor: pointer;
    z-index: 3;
  }

  .secondary {
    color: $accent;
    font-weight: bolder;
  }

  .title {
    font-weight: bold;
  }
</style>
