<template>
  <section class="container">
    <div class="card" id="card">
      <div class="card-header">
        <h6 class="title">WEBDEVELOPER: <span class="secondary">COSTIN BOGDAN</span></h6>
        <ToolBar :card="this.card"/>
      </div>
      <div class="card-body" id="card-body">
        <h5 class="card-title">{{ mainBio }}</h5>
        <p class="card-text">{{ secondaryBio }}</p>
      </div>
      <div class="card-footer">
        <router-link to="/contact" class="btn btn-primary">Contact Me</router-link>
      </div>
    </div>
  </section>
</template>

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
      mainBio: '',
      secondaryBio: '',
      card: null,
    }
  },
  mounted() {
    this.card = document.getElementById('card');
    this.getBio()
    document.title = 'Home'
  },
  methods: {
    async getBio() {
      try {
        const response = await axios.get('api/v1/profile/1');
        this.mainBio = this.stripHtmlTags(response.data.primary_bio);
        this.secondaryBio = this.stripHtmlTags(response.data.secondary_bio);
      } catch (error) {
        console.error('Error fetching bio:', error);
      }
    },
    stripHtmlTags(html) {
      const doc = new DOMParser().parseFromString(html, 'text/html');
      return doc.body.textContent || '';
    },
  },
}
</script>

<style lang="scss">
  @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono&family=Roboto&display=swap');
  $accent: rgba(0, 79, 158);

  .card {
    min-width: 100%;
    overflow: hidden;
  }
  .card::-webkit-scrollbar {
    display: none;
  }
  .example {
    -ms-overflow-style: none;  /* IE and Edge */
    scrollbar-width: none;  /* Firefox */
  }

  .card-header {
    display: flex;
    align-items: center;
    text-align: center;
    justify-content: space-between;
    flex-direction: row;
  }

  .container {
    height: 100vh;
    position: relative;
    display: flex;
    flex-direction: row;
    align-items: center;
  }

  .secondary {
    color: $accent;
    font-weight: bolder;
  }

  .title {
    font-weight: bold;
  }

  @media (max-width: 700px) {
    .card {
      display: flex;
      flex-direction: column;
      overflow: hidden;
      min-width: 100%;
      height: 400px;
    }
    .card-body {
      overflow-y: auto;
    }
    .card-footer {
      bottom: 0;
    }
  }
</style>
