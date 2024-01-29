<script>
  import axios from "axios";
  import ToolBar from "@/components/ToolBar.vue";
  import mixin from "@/components/mixin";
  export default {
    name: 'Contact',
    mixins: [mixin],
    components: {
      ToolBar
    },
    data() {
      return {
        card: '',
        cardBody: '',
        name: '',
        email: '',
        message: '',
        isOpen: false,
      }
    },
    watch: {
      isOpen: function(newVal, oldVal) {
        this.$nextTick(() => {
          this.card = document.getElementById('contactCard')
        })
      }
    },
    methods: {
      async sendData(){
        if (this.message, this.email, this.name !== '' && this.email.includes('@')) {
          this.$store.commit('setIsLoading', [true, 'contact'])
          await axios.post('api/v1/contact/', {
            name: this.name,
            email: this.email,
            message: this.message,
          })
              .then(response => {
                console.log(response)
                this.$store.commit('setIsLoading', [false, 'finished'])
              })
              .catch(error => {
                this.$store.commit('setIsLoading', [false, 'finished'])
                console.warn(error)
              })
        }
        if (this.name === '') {
          this.name = 'Please provide a name!'
        }
        if (this.email === '') {
          this.email = 'Please provide a email address!'
        }
        if (!this.email.includes('@')) {
          this.email = 'Please provide a valid email address!'
        }
        if (this.message === '') {
          this.message = 'Please provide a message!'
        }
      },
      open() {
        this.isOpen = !this.isOpen
      },
      close() {
        this.isOpen = false
      }
    },
    mounted() {
      document.title = 'Contact Me'
    },
  }
</script>

<template>
  <div class="side-container">
    <div class="folder">
      <div>
        <i class="bi bi-envelope-arrow-up" id="contact" @click="open"></i>
      </div>
      <label for="contact" style="font-size: 20px">Contact Me</label>
    </div>
  </div>
  <section class="container">
    <transition name="fade">
      <div class="card" v-if="isOpen" id="contactCard" ref="contactCard">
        <div class="card-header" id="card-header" ref="cardHeader"
             @mousedown="dragMouseDown($event, $refs.contactCard); elementStyle($refs.contactCard, 'down')"
             @touchstart="dragMouseDown($event, $refs.contactCard)"
             @touchmove="elementStyle($refs.contactCard, 'down', true)"
             @touchend="elementStyle($refs.contactCard, 'up', true)"
             @mouseup="elementStyle($refs.contactCard, 'up')">
          <h6 class="tit" id="title">GET IN TOUCH</h6>
          <ToolBar :card="card" @close-window="close"/>
        </div>
        <form class="card-body" id="card-body" ref="cardBody">
          <div v-if="this.$store.state.isLoading[0] && this.$store.state.isLoading[1] === 'contact'">
            <div class="loading-container">
              <div class="is-loading-bar" v-bind:class="{'is-loading': $store.state.isLoading}">
                <div class="lds-dual-ring"></div>
              </div>
            </div>
          </div>
          <div v-else-if="!this.$store.state.isLoading[0] && this.$store.state.isLoading[1] === ''" class="inputs">
            <div class="input-container" id="name-container">
              <label class="form-label" for="name">Full Name</label>
              <input type="text" class="form-control" name="name" id="name" placeholder="John Doe" required v-model="name">
            </div>
            <div class="input-container" id="email-container">
              <label class="form-label" for="email">Email Address</label>
              <input type="email" class="form-control" name="email" id="email" placeholder="email@example.com" required v-model="email">
            </div>
            <div class="input-container" id="message-container">
              <label class="form-label" for="message">Message</label>
              <textarea type="text" class="form-control" name="message" id="message" rows="3" placeholder="Your message" required v-model="message"/>
            </div>
          </div>
          <div v-else-if="!this.$store.state.isLoading[0] && this.$store.state.isLoading[1] === 'finished'">
            <h1 class="success">Thank you for reaching out!.</h1>
            <h1 class="success">I will make sure to contact you shortly</h1>
          </div>
        </form>
        <div class="card-footer" ref="cardFooter">
          <button class="btn btn-outline-primary" v-if="this.$store.state.isLoading[1] !== 'finished'" @click="sendData">Submit</button>
        </div>
      </div>
    </transition>
  </section>
</template>

<style scoped lang="scss">
  $accent: rgba(0, 79, 158);

  .inputs {
    width: 100%;
    height: 100%;
    grid-row: span 3;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-items: center;
    justify-content: center;
  }
  .success {
    width: 100%;
    height: 100%;
    grid-row: span 3;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-items: center;
    justify-content: center;
    font-size: 20px;
    color: lightgrey;
  }

  #message {
    height: 150px;
  }
  .tit {
    font-size: 30px;
  }
  .card-body {
    overflow-y: auto;
    justify-items: center;
    align-items: center;
    width: 100%;
    column-width: auto;
  }
  .input-container label {
    color: white;
    font-size: 20px;
  }
  .input-container {
    width: 60%;
  }
  #name-container, #email-container, #message-container {
    row-span: 1;
  }
  #name-container {
    grid-row: 1 / 1;
  }
  #email-container {
    grid-row: 2 / 2;
  }
  #message-container {
    grid-row: 3 / 3;
  }
  .folder {
    display: flex;
    flex-direction: column;
  }
  @media  screen and (max-width: 500px) {
   .input-container {
     width: 80%;
   }
  }
</style>

