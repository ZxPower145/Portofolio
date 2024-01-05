<script>
  import axios from "axios";
  import ToolBar from "@/components/ToolBar.vue";
  export default {
    name: 'Contact',
    components: {
      ToolBar
    },
    data() {
      return {
        card: Element,
        name: String,
        email: String,
        message: String,
        isOpen: true,
      }
    },
    mounted() {
      this.card = document.getElementById('card');
      document.title = 'Contact Me'
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
    }
  }
</script>

<template>
  <div class="cv"><i class="bi bi-envelope-arrow-up" @click="open"></i></div>
  <section class="container" id="card">
    <div class="card" v-if="isOpen">
      <div class="card-header">
        <h6 class="form-title">GET IN <span class="secondary">TOUCH</span></h6>
        <ToolBar :card="this.card" @close-window="close"/>
      </div>
      <div class="card-body" id="card-body">
        <form @submit.prevent="getData">
          <div class="col">
            <label class="form-label" for="name">Full Name</label>
            <input type="text" class="form-control" name="name" id="name" placeholder="John Doe" required>
          </div>
          <div class="col">
            <label class="form-label" for="email">Email Address</label>
            <input type="email" class="form-control" name="email" id="email" placeholder="John Doe" required>
          </div>
          <div class="col">
            <label class="form-label" for="message">Message</label>
            <textarea type="text" class="form-control" name="message" id="message" rows="3" placeholder="Your message" required/>
          </div>
          <button class="btn btn-primary mt-3">Submit</button>
        </form>
      </div>
    </div>
  </section>
</template>

<style lang="scss">
  $accent: rgba(0, 79, 158);

  body, html {
    overflow: hidden;
  }

  #message {
    height: 200px;
  }

  .form-title {
    color: black;
  }
  .form-title span {
    color: $accent;
  }

  .cv {
    position: absolute;
    top: 20px;
    right: 20px;
    font-size: 45px;
    color: white;
    cursor: pointer;
  }

  @media (max-width: 700px) {
    .form-control {
      width: 300px;
    }
  }
</style>

