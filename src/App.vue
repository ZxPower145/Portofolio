<template>
  <div class="gradient-bg">
    <div class="gradients-container">
      <div class="interactive" id="interactive"></div>
    </div>
  </div>

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
      <router-link to="/" class="nav-link" id="home" :class="{ 'isActive': elementId === 'home' }">
        Home
      </router-link>
      <router-link to="/contact" class="nav-link" id="contact" :class="{ 'isActive': elementId === 'contact' }">
        Contact
      </router-link>
      <router-link to="/projects" class="nav-link" id="projects" :class="{ 'isActive': elementId === 'projects' }">
        Projects
      </router-link>
    </div>
  </div>
  <router-view/>

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
  @keyframes moveInCircle {
    0% {
      transform: rotate(0deg);
    }
    50% {
      transform: rotate(180deg);
    }
    100% {
      transform: rotate(360deg);
    }
  }
  @keyframes moveVertical {
    0% {
      transform: translateY(-50%);
    }
    50% {
      transform: translateY(50%);
    }
    100% {
      transform: translateY(-50%);
    }
  }
  @keyframes moveHorizontal {
    0% {
      transform: translateX(-50%) translateY(-10%);
    }
    50% {
      transform: translateX(50%) translateY(10%);
    }
    100%{
      transform: translateX(-50%) translateY(-10%);
    }
  }

  * {
    font-family: 'JetBrains Mono', monospace;
    box-sizing: border-box;
  }
  body {
    margin: 0;
    padding: 0;
  }

  .container {
    justify-content: center;
    align-items: center;
    flex-direction: column;
  }

  .ham {
    position: absolute;
    left: 5px;
    top: 5px;
    z-index: 5;
  }

  .gradient-bg {
    width: 100vw;
    height: 100vh;
    position: absolute;
    overflow: hidden;
    background: rgba(var(--bg));
    top: 0;
    left: 0;
  }

  .gradients-container{
    width: 100%;
    height: 100%;
  }

  .interactive {
    position: absolute;
    background: radial-gradient(circle at center, rgba(var(--color-interactive), 0.4) 0,
        rgba(var(--color-interactive), 0) 20%) no-repeat;
    mix-blend-mode: var(--blending);

    width: 100%;
    height: 100%;

    opacity: 1;
  }

  .offcanvas {
    background: #212529;
  }

  .offcanvas-body:hover{
    color: $accent !important;
  }

  .offcanvas-title {
    color: white;
    text-transform: uppercase;
    font-size: 40px;
  }

  .nav-link {
    color: white;
    text-transform: uppercase;
    font-size: 30px;
  }

  .isActive {
    color: $accent;
  }

  @media (max-width: 700px) {
   .interactive {
      height: 100%;
    }
  }
</style>

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
      }
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
      this.currentUrl = this.$route.fullPath;
      this.setActive(this.currentUrl);

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
