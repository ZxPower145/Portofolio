<template>
  <section class="container">
    <div class="card" id="card">
      <div class="card-header">
        <h6 class="title">GET IN <span class="secondary">TOUCH</span></h6>
        <ToolBar :card="this.card"/>
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
  body, html {
    overflow: hidden;
  }


  .card {
    overflow: auto;
    height: 500px;
  }

  #message {
    height: 200px;
  }

  @media (max-width: 700px) {
    .form-control {
      width: 300px;
    }
  }
</style>

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
        name: null,
        email: null,
        message: null,
        card: null,
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
    }
  }
</script>
