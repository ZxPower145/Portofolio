<script>
  export default {
    name: 'Navbar',
    data() {
      return {
        currentUrl: '',
        elementId: '',
        interBubble: null,
        curX: 0,
        curY: 0,
        tgX: 0,
        tgY: 0,
      };
    },
    methods: {
      setActive(elementId) {
        this.elementId = elementId;
      },
      move() {
        const inertia = 0.2; // Adjust this value for the desired inertia
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
    }
  }
</script>

<template>
  <meta content="width=device-width, initial-scale=1" name="viewport" />

  <div class="interactive" id="interactive"></div>

  <button class="btn ham"
        type="button"
        data-bs-toggle="offcanvas"
        data-bs-target="#offcanvasWithBothOptions"
        aria-controls="offcanvasWithBothOptions">
    <i class="bi bi-list" style="color: white; font-size: 5vh"></i>
  </button>


  <div class="offcanvas offcanvas-start" data-bs-scroll="true" tabindex="-1" id="offcanvasWithBothOptions"
       aria-labelledby="offcanvasWithBothOptionsLabel">
    <div class="offcanvas-header">
      <h5 class="offcanvas-title" id="offcanvasWithBothOptionsLabel">Portofolio</h5>
      <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
      <router-link to="/" class="nav-link" id="home" :class="{ 'active-link': elementId === 'home' }">
        Home
      </router-link>
      <router-link to="/contact" class="nav-link" id="contact" :class="{ 'active-link': elementId === 'contact' }">
        Contact
      </router-link>
      <router-link to="/projects" class="nav-link" id="projects" :class="{ 'active-link': elementId === 'projects' }">
        Projects
      </router-link>
    </div>
  </div>
  <router-view/>

  <div class="minimized" id="minimized"></div>

</template>

<style lang="scss">
  $offcanvas-horizontal-width: 320px;
  $primary: #0F75D2;
  $accent: rgba(0, 79, 158);
  :root {
    --bg: 0, 79, 158;
    --color-interactive: 0, 187, 255;
    --blending: hard-light;
  }

  @import "bootstrap";
  @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono&family=Roboto:wght@100&display=swap');
  * {
    box-sizing: border-box;
    font-family: 'JetBrains Mono', monospace;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
  }
  body {
    margin: 0;
    padding: 0;
    background: #2e2e2e;
  }
  // Nav-Bar
  .ham {
    position: absolute;
    left: 5px;
    top: 5px;
    z-index: 5;
  }
  .offcanvas {
    background: transparent;
    backdrop-filter: blur(5rem);
  }
  .offcanvas-body {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
    height: 100%;
    gap: 20px;
    padding: 0;
    padding-left: 10px;
  }
  .nav-link:hover{
    color: white !important;
  }
  .nav-link:focus{
    color: deepskyblue;
  }
  .offcanvas-title {
    color: white;
    text-transform: uppercase;
    font-size: 40px;
  }
  .nav-link {
    width: 100%;
    color: white;
    text-transform: uppercase;
    text-align: center;
    font-size: 30px;
  }
  .active-link {
    color: deepskyblue;
    background-color: rgba(0, 187, 255, 0.3);
    border-bottom-left-radius: 99px;
    border-top-left-radius: 99px;
    filter: drop-shadow(5px 5px 15px black);
  }
  // Circle on cursor
  .interactive {
    position: absolute;
    background: radial-gradient(circle at center, rgba(var(--color-interactive), 0.4) 0,
        rgba(var(--color-interactive), 0) 20%) no-repeat;
    mix-blend-mode: var(--blending);
    width: 100%;
    height: 100%;
    opacity: 1;
  }
  // Loading
  .loading-container {
    display: flex;
    height: 100%;
    text-align: center;
    justify-content: center;
    margin: auto;
  }
  .lds-dual-ring {
    display: inline-block;
    width: 80px;
    height: 80px;
  }
  .lds-dual-ring:after{
    content: "";
    display: block;
    width: 64px;
    height: 64px;
    margin: 8px;
    border-radius: 50%;
    border: 8px solid #8f8f8f;
    border-color: #8f8f8f transparent #8f8f8f transparent;
    animation: lds-dual-ring 1.2s linear infinite;
  }
  @keyframes lds-dual-ring {
    0% {
      transform: rotate(0deg);
    }
    100% {
      transform: rotate(360deg);
    }
  }
  .is-loading-bar {
    height: 0;
    overflow: hidden;
    -webkit-transition: all 0.3s;
    transition: all 0.3s;

    &.is-loading {
      height: 80px;
    }
  }

  .container {
    position: absolute;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100vh;
    min-width: 100%;
  }
  .card {
    position: absolute;
    display: flex;
    flex-direction: column;
    overflow: scroll;
    background: #2e2e2e;
    -webkit-box-shadow: 0 4px 45px 0 #000000;
    box-shadow: 0 4px 45px 0 #000000;
    width: 30%;
    height: 40%;
  }
  .card::-webkit-scrollbar,
  .card-body::-webkit-scrollbar{
    display: none;
  }
  .card-header {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    text-align: center;
    cursor: pointer;
    height: 50px;
    background: white;
    border-top-right-radius: 30px;
    border-top-left-radius: 30px;
  }
  .card-body {
    display: flex;
    flex-direction: column;
    height: 100%;
    overflow-y: auto;
    color: white;
  }
  .card-footer {
    height: 60px;
    bottom: 0;
  }
  .card-footer a {
    font-weight: normal;
  }

  // "Folder" Icon
  .side-container {
    position: absolute;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    top: 20px;
    right: 30px;
    font-size: 45px;
    color: white;
    cursor: pointer;
    z-index: 3;
  }
  .side-container:active {
    color: #878787;
  }
  .side-container:hover {
    opacity: .8;
  }

  .isOnTop {
    z-index: 15;
  }
  .minimized {
    position: absolute;
    display: flex;
    flex-direction: row;
    align-items: flex-start;
    justify-content: flex-start;
    justify-content: flex-start;
    height: 50px;
    width: 100%;
    bottom: 0;
    background: black;
  }

  //@media screen and (max-width: 1000px) {
  //  body {
  //    padding: 50px !important;
  //    background: blue;
  //    overflow: hidden !important;
  //  }
  //  .interactive {
  //    height: 100%;
  //  }
  //  .container {
  //    position: absolute;
  //  }
  //  .card {
  //    position: absolute;
  //    left: 50%;
  //    right: 50%;
  //    transform: translate(-50%, -50%);
  //    display: flex;
  //    flex-direction: column;
  //    overflow: hidden;
  //    max-width: 70%;
  //    max-height: 200px !important;
  //  }
  //  .card-body {
  //    overflow-y: auto;
  //  }
  //  .card-footer {
  //    bottom: 0;
  //  }
  //}

  // Vue On-Load Transition
  // Fade
  .fade-enter-from {
    opacity: 0;
    top: -30%;
    left: 50%;
    transform: translate(-50%, 30%) scale(0.1);
  }
  .fade-enter-active,
  .fade-leave-active {
    transition: all 1.5s ease-in-out;
  }
  .fade-leave-to{
    opacity: 0;
    top: -30%;
    left: 50%;
    transform: translate(-50%, -130%) scale(0.1);
  }

  // Card
  .proj-enter-from {
    opacity: 0;
    top: -30%;
    left: 50%;
    transform: translate(-50%, 30%) scale(0,1);
  }
  .proj-enter-to {
    opacity: 1;
    top: 30%;
    left: 50%;
    transform: translate(-50%, -30%) scale(1);
  }
  .proj-enter-active{
    -webkit-transition: all 1s ease;
    -moz-transition: all 1s ease;
    -ms-transition: all 1s ease;
    -o-transition: all 1s ease;
    transition: all 1s ease;
  }
  .proj-leave-from{
    opacity: 1;
    transform: scale(1);
  }
  .proj-leave-to{
    opacity: 0;
    top: -30%;
    left: 50%;
    transform: translate(-50%, 30%) scale(0);
  }
  .proj-leave-active{
    -webkit-transition: all 1s ease;
    -moz-transition: all 1s ease;
    -ms-transition: all 1s ease;
    -o-transition: all 1s ease;
    transition: all 1s ease;
  }
</style>

