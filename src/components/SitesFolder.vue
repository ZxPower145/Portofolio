<script>
import mixin from "@/components/mixin";
import ToolBar from "@/components/ToolBar.vue";
export default {
  name: 'SitesFolder',
  mixins: [mixin],
  components: {ToolBar},
  data() {
    return {
      sitesCard: Element,
      container: Element,
      openedSite: '',
      isSiteOpen: false,
      title: 'Websites'
    }
  },
  watch: {
    openedSite: function (newVal, oldVal) {
      switch (newVal) {
        case '':
          this.title = 'Websites'
          break
        case 'invoice':
          this.title = 'Invoice Manager'
          break
        case 'shop':
          this.title = 'WebStore'
          break
        default:
          this.title = 'Websites'
      }
    }
  },
  methods: {
    moveSiteBtn(element, direction) {
      const cardBody = this.$refs.cardBody
      const folder = this.$refs.card
      element.style.transition = 'transform 1s cubic-bezier(0.37, 0, 0.63, 1) 0s, ' +
          'background-color 1.5s cubic-bezier(0.37, 0, 0.63, 1) 0s, ' +
          'box-shadow 1.5s cubic-bezier(0.37, 0, 0.63, 1) 0s'
      if (direction === 'up') {
        cardBody.style.overflow = 'visible'
        folder.style.overflow = 'visible'
        element.style.overflow = 'visible'
        element.style.transform = 'translateX(300px)'

        switch (element.id) {
          case 'invoiceBtn':
            element.style.boxShadow = '0 0 30px 5px #8a8130'
            element.style.backgroundColor = 'rgba(176, 166, 72, 0.6)'
            break
          case 'shopBtn':
            element.style.boxShadow = '0 0 30px 5px #27e669'
            element.style.backgroundColor = 'rgba(32, 176, 82, 0.6)'
            break
          default:
            console.error('Something went wrong, no element found:' + element)
            break
        }
      } else {
        element.style.overflow = 'hidden'
        element.style.transform = 'translateX(0)'
        element.style.boxShadow = '0 0 30px 5px black'
        element.style.backgroundColor = 'rgba(255, 255, 255, 0.1)'
      }
    },
    close() {
      this.$emit('close-site-window', [true, 'site-folder'])
      this.isSiteOpen = false
    },
    openSite(site) {
      this.openedSite = site
      this.isSiteOpen = true
      const cardbody = this.$refs.cardBody
      cardbody.style.padding = '0'
      cardbody.style.overflow = 'hidden'
    },
    back() {
      this.openedSite = ''
      this.isSiteOpen = false
    }
  },
  mounted() {
    this.$nextTick(() => {
      this.sitesCard = document.getElementById('sitesFolder')
      this.container = document.getElementById('container')
    })
  }
}
</script>

<template>
  <div class="card" id="sitesCard" ref="card">
    <div class="card-header" id="card-header" ref="sitesCardHeader"
       @mousedown="dragMouseDown($event, $refs.card); elementStyle($refs.card, 'down', isSiteOpen)"
       @touchstart="dragMouseDown($event, $refs.card); elementStyle($refs.card, 'down', isSiteOpen)"
       @touchend="elementStyle($refs.card, 'up', isSiteOpen)"
       @mouseup="elementStyle($refs.card, 'up', isSiteOpen)">
      <div v-if="openedSite !== ''" class="back" @click="back"><i class="bi bi-arrow-left-circle"></i></div>
      <h6 class="tit" id="title">{{title}}</h6>
      <tool-bar class="toolbar" id="toolbar" :card="sitesCard" :container="container" @close-window="close"/>
    </div>
    <div class="card-body" id="card-body" ref="cardBody">
      <div class="sites-container" v-if="openedSite === ''">
        <div class="site" ref="invoice" id="invoiceBtn"
             @click="openSite('invoice')"
             @mouseover="moveSiteBtn($refs.invoice, 'up')"
             @mouseleave="moveSiteBtn($refs.invoice)">
          <i class="bi bi-receipt" id="invoice"></i>
          <label for="invoice">Django Invoice Manager</label>
        </div>
        <div class="site" ref="shop" id="shopBtn"
             @click="openSite('shop')"
             @mouseover="moveSiteBtn($refs.shop, 'up')"
             @mouseleave="moveSiteBtn($refs.shop)">
          <i class="bi bi-shop" id="store"></i>
          <label for="store">Django and Vue Online Store</label>
          <i class="bi bi-globe2"></i>
        </div>
      </div>
      <div class="invoice" v-if="openedSite === 'invoice'">
        <img src="@/assets/invoiceManager.png" class="shop-img">
      </div>
      <div class="shop" v-if="openedSite === 'shop'">
        <img src="@/assets/shop.png" class="shop-img">
      </div>
    </div>
    <div class="card-footer" id="card-footer" ref="cardFooter">
      <div v-if="openedSite === 'shop'" class="buttons">
        <a class="btn btn-outline-primary" href="https://github.com/ZxPower145/django-and-vue-webstore" target="_blank">
          GitHub</a>
        <a class="btn btn-outline-primary" href="https://zxwebstore.com" target="_blank">WebSite</a>
      </div>
      <div v-if="openedSite === 'invoice'" class="buttons">
        <a class="btn btn-outline-primary" href="https://github.com/ZxPower145/python-invoice-manager-webapp" target="_blank">
          GitHub</a>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
  .buttons {
    display: flex;
    gap: 30px;
  }
  .buttons button {
    text-transform: uppercase;
  }
  .sites-container {
    grid-row: span 3;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 30px;
  }
  .site {
    display: flex;
    flex-direction: row;
    align-items: center;
    width: 90%;
    height: 100px;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(20px);
    border-radius: 20px;
    box-shadow: 0 0 35px 2px black;
    justify-content: center;
    gap: 30px;
  }
  .site i {
    font-size: 30px;
    font-weight: bold;
  }
  .site label {
    text-transform: uppercase;
    font-size: 20px;
  }
  .tit {
    font-size: 30px;
  }

  .shop {
    grid-row: span 3;
  }
  .shop-img {
    max-width: 100%;
    height: 100%;
  }
  .card-body {
    overflow: hidden;
    padding: 0;
  }
  .card {
    overflow: hidden;
  }
</style>