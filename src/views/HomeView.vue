<script>
import axios from 'axios';
import ToolBar from "@/components/ToolBar.vue";
import mixin from "@/components/mixin";
axios.defaults.baseURL = 'http://localhost:8000';
export default {
  name: 'Home',
  mixins: [mixin],
  components: {
    ToolBar,
  },
  data() {
    return {
      mainBio: '',
      secondaryBio: '',
      isOpen: false,
      card: '',
      cardBody: '',
    }
  },
  watch: {
    isOpen: function (newVal, oldVal) {
      this.$nextTick(() => {
        this.card = document.getElementById('card')
        this.cardBody = this.card.querySelector('.card-body')
        this.getHeight(this.card)
      })
    }
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
    close() {
      this.isOpen = false
    },
    open() {
      this.isOpen = !this.isOpen
    },
  },
  mounted() {
    this.getBio()
    this.isOpen = true
    document.title = 'Home'
  },
}
</script>

<template>
  <div class="side-container"><i class="bi bi-file-person" @click="open"></i></div>
  <section class="container">
    <transition name="fade">
      <div class="card" v-if="isOpen" id="card">
        <div class="card-header" id="card-header"
          @mousedown="dragMouseDown($event, card, true); elementStyle(card, cardBody, 'down')"
          @mouseup="elementStyle(card, cardBody, 'up')">
          <h6 class="title">WEBDEVELOPER: <span class="secondary">COSTIN BOGDAN</span></h6>
          <ToolBar :card="card" @close-window="close"/>
        </div>
        <div class="card-body" id="card-body">
          <div class="loading-container" v-if="this.$store.state.isLoading">
            <div class="is-loading-bar" v-bind:class="{'is-loading': $store.state.isLoading}">
              <div class="lds-dual-ring"></div>
            </div>
          </div>
          <div v-else>
            <h5 class="main-bio"> {{mainBio}} </h5>
            <p class="secondary-bio">{{secondaryBio}}</p>
          </div>
        </div>
        <div class="card-footer">
          <router-link to="/contact" class="btn btn-primary">Contact Me</router-link>
        </div>
      </div>
    </transition>
  </section>
</template>


<style lang="scss" scoped>
  @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono&family=Roboto&display=swap');
  $accent: rgba(0, 79, 158);

  .secondary {
    color: $accent;
    font-weight: bolder;
  }

  .main-bio {
    color: black;
    font-weight: normal;
    font-size: 23px;
  }

  .title {
    font-weight: bold;
    color: black;
    font-size: 18px;
  }
</style>
