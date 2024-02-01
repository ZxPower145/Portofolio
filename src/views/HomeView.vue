<script>
import axios from 'axios';
import ToolBar from "@/components/mixins/ToolBar.vue";
import mixin from "@/components/mixins/mixin";
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
      cardBody: '',
      cardFooter: '',
      card: '',
    }
  },
  watch: {
    isOpen: function(newVal, oldVal) {
      this.$nextTick(() => {
        this.card = document.getElementById('card')
        console.log(this.card)
      })
    }
  },
  methods: {
    async getBio() {
      this.$store.commit('setIsLoading', true)
      try {
        const response = await axios.get('api/v1/profile/1');
        this.mainBio = response.data.primary_bio;
        this.secondaryBio = response.data.secondary_bio;
        this.$store.commit('setIsLoading', false)
      } catch (error) {
        console.error('Error fetching bio:', error);
      }
    },
    close() {
      this.isOpen = false
    },
    open() {
      this.isOpen = !this.isOpen
    },
  },
  mounted() {
    document.title = 'Home'
    this.getBio()
  },
}
</script>

<template>
  <div class="side-container">
    <div class="folders">
      <i class="bi bi-file-person" id="bio" @click="open"></i>
      <label for="bio" style="font-size: 20px">Bio</label>
    </div>
  </div>
  <section class="container">
    <transition name="fade">
      <div class="card" v-if="isOpen" id="card" ref="card">
        <div class="card-header" id="card-header" ref="cardHeader"
          @mousedown="dragMouseDown($event, $refs.card); elementStyle($refs.card, 'down', true)"
          @touchstart="dragMouseDown($event, $refs.card)"
          @touchmove="elementStyle($refs.card, 'down',  false,true)"
          @touchend="elementStyle($refs.card, 'up', false, true)"
          @mouseup="elementStyle($refs.card, 'up')">
          <h6 id="title" class="tit">WEBDEVELOPER: COSTIN BOGDAN</h6>
          <ToolBar :card="card" @close-window="close" id="toolbar"/>
        </div>
        <div class="card-body" id="card-body" ref="cardBody">
          <div class="loading-container" v-if="this.$store.state.isLoading">
            <div class="is-loading-bar" v-bind:class="{'is-loading': $store.state.isLoading}">
              <div class="lds-dual-ring"></div>
            </div>
          </div>
          <div v-else>
            <p class="main-bio" v-html="mainBio"></p>
            <p class="secondary-bio" v-html="secondaryBio"></p>
          </div>
        </div>
        <div class="card-footer" id="card-footer" ref="cardFooter">
          <router-link to="/contact" class="btn btn-primary">Contact Me</router-link>
        </div>
      </div>
    </transition>
  </section>
</template>


<style lang="scss" scoped>
  $accent: rgba(0, 79, 158);

  .secondary {
    color: $accent;
    font-weight: bolder;
  }
  .main-bio {
    font-weight: bold;
    color: white;
    font-size: 20px;
  }
  .secondary-bio {
    font-weight: bold;
    color: lightgrey;
    font-size: 15px;
  }
  .card-body {
    padding: 10px;
  }
  .folders {
    display: flex;
    flex-direction: column;
  }
  @media  screen and (max-width: 500px) {
    .main-bio {
      font-size: 15px;
    }
    .secondary-bio {
      font-size: 10px;
    }
    .card-body {
      overflow-y: scroll;
    }
    .tit {
      font-size: 15px;
    }
  }
</style>
