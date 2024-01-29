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
  $offcanvas-horizontal-width: 300px;
  $primary: #0F75D2;
  $accent: rgba(0, 79, 158);
  $background-header: #4d4c4c;
  $background-body: #6e6e6e;
  $background-footer: #4d4c4c;
  :root {
    --bg: 0, 79, 158;
    --color-interactive: 203, 66, 245;
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
  body{
    margin: 0;
    padding: 0;
    background: #a3a3a3;
    overflow: hidden;
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
    grid-row: span 3;
    height: 100%;
    width: 100%;
    justify-content: center;
    align-items: center;
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
    height: 100vh;
    min-width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    align-items: center;
  }
  .card {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    display: grid;
    grid-template-columns: auto;
    grid-template-rows: 10% 80% 10%;
    width: 60%;
    height: 700px;
    background: transparent;
    border: transparent;
    border-top-right-radius: 40px;
    border-top-left-radius: 40px;
    z-index: 10 !important;
  }
  .card::-webkit-scrollbar,
  .card-body::-webkit-scrollbar{
    display: none;
  }
  .card-header {
    display: flex;
    flex-direction: row;
    align-items: center;
    border: 1px solid rgba(0, 0, 0, 0.3);
    background: $background-header;
    transition: all 1s;
  }
  .card-header:first-child{
    border-top-right-radius: 40px;
    border-top-left-radius: 40px;
  }

  // Project Element Buttons:
  .elementThumbImage {
    width: 70px;
    height: 70px;
    object-fit: cover;
    border-radius: 99px;
    box-shadow: 0 0 15px 1px black;
    margin-left: 25px;
  }
  .element-selector {
    grid-row: span 3;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 25px;
  }
  .element-container {
    display: flex;
    justify-content: center;
    align-items: center;
    grid-row: span 3;
  }
  .elementImage{
    width: 100%;
  }
  .description {
    width: 100%;
    grid-row: span 3;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    justify-items: center;
    color: lightgrey;
  }
  .elementBtn {
    display: flex;
    flex-direction: row;
    align-items: center;
    width: 90%;
    height: 100px;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(20px);
    border-radius: 20px;
    box-shadow: 0 0 35px 2px black;
  }
  .elementBtn .element-label {
    color: black;
    text-align: center;
    width: 100%;
    height: 30px;
    font-size: 25px;
    margin-left: 5px;
    margin-right: 5px;
  }
  .elementWindow {
    grid-row: span 3;
  }

  .tit {
    font-size: 25px;
    flex: 85%;
    height: 100%;
    display: flex;
    align-items: center;
    margin: 0;
    font-weight: 800;
    letter-spacing: 1px;
    word-spacing: -10px;
    color: white;
    text-transform: uppercase;
    background: linear-gradient(
            135deg, #ff00d2, #fed90f, #00a2ff, #09f1b8,
            #ff00d2, #fed90f, #00a2ff, #09f1b8);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    -webkit-background-size: 300% 300%;
    animation: gradientScale 8s infinite;
  }
  @keyframes gradientScale {
    0% {
      background-position: 0% 50%;
    }
    50% {
      background-position: 100% 50%;
    }
    100% {
      background-position: 0% 50%;
    }
  }
  .back {
    display: flex;
    flex: 5%;
    height: 100%;
    align-items: center;
    justify-content: center;
    font-size: 28px;
    margin: 0;
    margin-right: 5px;
    background: linear-gradient(
            135deg, #ff00d2, #fed90f, #00a2ff, #09f1b8,
            #ff00d2, #fed90f, #00a2ff, #09f1b8);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    -webkit-background-size: 300% 300%;
    animation: gradientScale 8s infinite;
  }
  .toolbar {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 15px;
    grid-row: 3 / 3;
    width: 100%;
    flex: 10%;
    z-index: 10;
  }
  .card-header > h6 {
    grid-column: span 1;
    grid-row: span 1;
  }
  .card-body {
    transition: all 1s ease;
    display: grid;
    grid-template-rows: auto auto auto;
    grid-template-columns: auto;
    overflow: hidden;
    grid-row: 2 / 3;
    padding: 0;
    border: 1px solid rgba(0, 0, 0, 0.3);
    border-top: none;
    border-bottom: none;
    background: $background-body;
  }
  .card-footer {
    display: flex;
    overflow: hidden;
    padding: 10px;
    border: 1px solid rgba(0, 0, 0, 0.3);
    background: $background-footer;
    align-items: center;
    grid-row: 3 / 3;
  }
  // "Folder" Icon
  .side-container {
    position: absolute;
    top: 5px;
    right: 10px;
    display: flex;
    flex-direction: column;
    text-align: center;
    justify-content: flex-end;
    align-items: flex-end;
    font-size: 45px;
    color: #2e2e2e;
    cursor: pointer;
    z-index: 4;
    margin-right: 10px;
  }
  .side-container label {
    margin-bottom: 15px;
  }
  .side-container i:active {
    color: #878787;
  }
  .side-container i:hover {
    opacity: .8;
  }
  .isOnTop {
    z-index: 15;
  }

  // Vue On-Load Transition

  .fade-enter-from,
  .fade-leave-to{
    opacity: 0;
    top: -100%;
    left: -100%;
    transform: translate(-100%, -100) scale(0.1);
  }
  .fade-enter-active,
  .fade-leave-active {
    transition: all 1s;
  }
  
  @media  screen and (max-width: 500px) {
    .container {
      position: absolute !important;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 100% !important;
      height: 100% !important;
    }
    body, html {
      width: 100%;
      height: 100%;
    }
    .card {
      width: 90%;
      height: 90%;
      z-index: 13;
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
      right: 0;
      font-size: 30px;
    }
    .side-container label {
      font-size: 20px;
    }
  }
</style>

