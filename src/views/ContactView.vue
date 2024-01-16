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
        name: String,
        email: String,
        message: String,
        isOpen: false,
      }
    },
    watch: {
      isOpen: function (newVal, oldVal) {
        this.$nextTick(() => {
          this.card = document.getElementById('card');
          this.cardBody = this.card.querySelector('.card-body')
          this.getHeight(this.card)
        })
      }
    },
    methods: {
      getData(submitEvent) {
        this.name = submitEvent.target.elements.name.value
        this.email = submitEvent.target.elements.email.value
        this.message = submitEvent.target.elements.message.value.replace(/\r\n|\r|\n/g, '\n');
        console.log(this.message)
        this.sendData()
      },
      sendData(){
        axios.post('api/v1/contact/', {
          name: this.name,
          email: this.email,
          message: this.message,
        })
            .then(response => {
              console.log(response)
            })
            .catch(error => {
              console.warn(error)
            })
      },
      open() {
        this.isOpen = !this.isOpen
      },
      close() {
        this.isOpen = false
      }
    },
    mounted() {
      this.isOpen = true
      document.title = 'Contact Me'
    },
  }
</script>

<template>
  <div class="side-container"><i class="bi bi-envelope-arrow-up" @click="open"></i></div>
  <section class="container">
    <transition name="fade">
      <div class="card" v-if="isOpen" id="card">
        <div class="card-header" id="card-header"
             @mousedown="dragMouseDown($event, card, true); elementStyle(card, cardBody, 'down')"
             @mouseup="elementStyle(card, cardBody, 'up')">
          <h6 class="form-title">GET IN <span class="secondary">TOUCH</span></h6>
          <ToolBar :card="card" @close-window="close"/>
        </div>
        <form @submit.prevent="getData">
          <div class="card-body" id="card-body">
            <div class="input-container">
              <label class="form-label" for="name">Full Name</label>
              <input type="text" class="form-control" name="name" id="name" placeholder="John Doe" required>
            </div>
            <div class="input-container">
              <label class="form-label" for="email">Email Address</label>
              <input type="email" class="form-control" name="email" id="email" placeholder="email@example.com" required>
            </div>
            <div class="input-container">
              <label class="form-label" for="message">Message</label>
              <textarea type="text" class="form-control" name="message" id="message" rows="3" placeholder="Your message" required/>
            </div>
          </div>
          <div class="card-footer">
            <hr>
            <button class="btn btn-primary">Submit</button>
          </div>
        </form>
      </div>
    </transition>
  </section>
</template>

<style lang="scss">
  $accent: rgba(0, 79, 158);



  body, html {
    overflow: hidden;
  }

  #message {
    height: 150px;
  }

  .form-title {
    color: black;
    font-weight: bold;
  }
  .form-title span {
    color: $accent;
  }

  .input-container {
    margin-bottom: 20px;
  }

  .button-container {
    margin-top: auto;
  }


  @media (max-width: 700px) {
    .form-control {
      width: 100%;
    }
    .input-container {
      margin-bottom: 5px;
    }
    #message {
      height: 100px;
    }
  }
</style>

