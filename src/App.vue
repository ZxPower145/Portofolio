<script>
  export default {
    name: 'Navbar',
    data() {
      return {
        currentUrl: '',
        elementId: '',
        interBubble: null,
        activeLink: {
          'home': false,
          'contact': false,
          'projects': false,
        },
        curX: 0,
        curY: 0,
        tgX: 0,
        tgY: 0,
      };
    },
    methods: {
      setActive(elementId) {
        for (let obj in this.activeLink) {
          if (obj === elementId) {
            this.activeLink[`${obj}`] = true
            console.log(obj)
          } else {
            this.activeLink[`${obj}`] = false
            console.log('False', obj)
          }
        }
      },
      move() {
        const inertia = 0.2;
        const deltaX = this.tgX - this.curX;
        const deltaY = this.tgY - this.curY;

        this.curX += deltaX * inertia;
        this.curY += deltaY * inertia;
        this.interBubble.style.transform = `translate(-50%, -50%) \
        translate(${Math.round(this.curX)}px, ${Math.round(this.curY)}px)`;

        setTimeout(() => {
          requestAnimationFrame(() => {
            this.move();
          });
        }, 16);
      },
      toggleCanvas(action) {
        console.log(action)
        const body = document.querySelector("body")
        if (action === 'open') {
          this.$refs.nav.classList.remove('nav-closed')
          this.$refs.nav.classList.add('nav-open')
          body.style.transition = 'all 1s'
          body.style.backdropFilter = 'grayscale(70%)'
        } else {
          this.$refs.nav.classList.remove('nav-open')
          this.$refs.nav.classList.add('nav-closed')
          body.style.backdropFilter = 'unset'
        }
      },
      handleClickOutside(event) {
        const navContainer = this.$refs.nav;
        const ham = this.$refs.ham

        try {
          if (!ham.contains(event.target)) {
            if (navContainer && !navContainer.contains(event.target)) {
              this.toggleCanvas('close');
            }
          }
        } catch (e) {
          console.log(e)
        }
      },
    },
    watch: {
      '$route'(to, from) {
        this.currentUrl = to.fullPath;
        switch (this.currentUrl) {
          case '/': this.setActive('home');
            break;
          case '/contact': this.setActive('contact');
            break;
          case '/projects': this.setActive('projects');
            break;
          default:
            this.setActive('');
        }
      },
    },
    mounted() {
      document.title = 'Wrong Turn?'
      const url = document.URL.split('/')
      this.currUrl = url[url.length - 1]
      this.setActive(this.currUrl)
      this.interBubble = document.getElementById('interactive');

      window.addEventListener('mousemove', event => {
        this.tgX = event.clientX;
        this.tgY = event.clientY;
      });
      window.addEventListener('touchmove', event => {
        this.tgX = event.touches[0].clientX;
        this.tgY = event.touches[0].clientY;
      });
      this.move();
      window.addEventListener('click', this.handleClickOutside);
    }
  }
</script>

<template>
  <meta content="width=device-width, initial-scale=1" name="viewport" />

  <div class="interactive" id="interactive"></div>

  <button class="bi bi-list ham" ref="ham" @click="toggleCanvas('open')"></button>


  <div class="nav nav-closed" data-bs-scroll="true" id="nav" ref="nav">
    <div class="nav-header">
      <h5 class="nav-title" id="nav-title">Portofolio</h5>
      <button type="button" class="btn-close" aria-label="close" @click="toggleCanvas('close')"></button>
    </div>
    <div class="nav-body">
      <router-link to="/" class="navLink bi" id="home"
                   :class="{
                    'bi-house': !activeLink.home,
                    'bi-house-fill': activeLink.home,
                    'active-link': activeLink.home
                   }">
      </router-link>
      <router-link to="/contact" class="navLink bi" id="contact"
                   :class="{
                     'bi-mailbox': !activeLink.contact,
                     'bi-mailbox2-flag': activeLink.contact,
                     'active-link': activeLink.contact
                   }">
      </router-link>
      <router-link to="/projects" class="navLink bi" id="projects"
                   :class="{
                     'bi-archive': !activeLink.projects,
                     'bi-archive-fill': activeLink.projects,
                     'active-link': activeLink.projects
                   }">
      </router-link>
    </div>
  </div>
  <router-view/>

  <div class="minimized" id="minimized"></div>

</template>


<style lang="scss">
  $primary: #0F75D2;

  @import "bootstrap";
  @import "@/assets/css/nav";
  @import "@/assets/css/card";
  @import "@/assets/css/cursorCircle";
  @import "@/assets/css/loading";
  @import "@/assets/css/elements";
  @import "@/assets/css/sideContainer";
  @import "@/assets/css/onLoadAnimation";
  @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono&family=Roboto:wght@100&display=swap');
  * {
    box-sizing: border-box;
    font-family: 'JetBrains Mono', monospace;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
  }
  body{
    margin: 0;
    padding: 0;
    background-image: url("@/assets/back2.jpg");
    background-size: cover;
    background-repeat: no-repeat;
    box-shadow: inset 0 0 50px 5px #000;
    overflow: hidden;
  }
  .container {
    height: 100vh;
    min-width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    align-items: center;
    overflow: hidden;
    margin: 0;
    padding: 0;
  }

  .isOnTop {
    z-index: 15;
  }
  .window {
    position: absolute;
  }

  @media  screen and (max-width: 500px) {
    .container {
      width: 100% !important;
      height: 100% !important;
    }
    body, html {
      width: 100%;
      height: 100%;
    }
    .card {
      position: absolute;
      width: 80%;
      height: 70%;
    }
    .card-body {
      overflow-y: scroll !important;
    }
    .playBtn {
      display: none;
    }
    .element-label {
      font-size: 20px !important;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .side-container {
      position: absolute;
      left: 0;
      right: 0;
      font-size: 30px;
    }
    .side-container label {
      font-size: 15px;
    }
  }
</style>

