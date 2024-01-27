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
      isOpen: function(newVal, oldVal) {
        this.$nextTick(() => {
          this.card = document.getElementById('contactCard')
          console.log(this.card)
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
             @mouseup="elementStyle($refs.contactCard, 'up')">
          <h6 class="tit" id="title">GET IN TOUCH</h6>
          <ToolBar :card="card" @close-window="close"/>
        </div>
        <form @submit.prevent="getData" class="card-body" id="card-body" ref="cardBody">
            <div class="input-container" id="name-container">
              <label class="form-label" for="name">Full Name</label>
              <input type="text" class="form-control" name="name" id="name" placeholder="John Doe" required>
            </div>
            <div class="input-container" id="email-container">
              <label class="form-label" for="email">Email Address</label>
              <input type="email" class="form-control" name="email" id="email" placeholder="email@example.com" required>
            </div>
            <div class="input-container" id="message-container">
              <label class="form-label" for="message">Message</label>
              <textarea type="text" class="form-control" name="message" id="message" rows="3" placeholder="Your message" required/>
            </div>
        </form>
        <div class="card-footer" ref="cardFooter">
          <button class="btn btn-outline-primary" data-action="submit">Submit</button>
        </div>
      </div>
    </transition>
  </section>
</template>

<style scoped lang="scss">
  $accent: rgba(0, 79, 158);

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
    width: 50%;
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
</style>

