<script>
import mixin from "@/components/mixin";
import ToolBar from "@/components/ToolBar.vue";
export default {
  name: 'SitesFolder',
  mixins: [mixin],
  components: {ToolBar},
  data() {
    return {
      newCard: Element,
      container: Element,
      openedSite: '',
      isSiteOpen: false,
      title: 'New Folder'
    }
  },
  watch: {
    openedSite: function (newVal, oldVal) {
      switch (newVal) {
        case '':
          this.title = 'New Folder'
          break
        case 'management':
          this.title = 'Management'
          break
        case 'chat':
          this.title = 'ChatBot'
          break
        default:
          this.title = 'New Folder'
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
          case 'managementBtn':
            element.style.boxShadow = '0 0 30px 5px #931be3'
            element.style.backgroundColor = 'rgba(103, 16, 161, 0.6)'
            break
          case 'chatBtn':
            element.style.boxShadow = '0 0 30px 5px #18d6d6'
            element.style.backgroundColor = 'rgba(17, 150, 150, 0.6)'
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
      this.$emit('close-new-window', [true, 'new-folder'])
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
      this.newCard = document.getElementById('newFolder')
      this.container = document.getElementById('container')
    })
  }
}
</script>

<template>
  <div class="card" id="newCard" ref="card">
    <div class="card-header" id="card-header" ref="newCardHeader"
       @mousedown="dragMouseDown($event, $refs.card); elementStyle($refs.card, 'down', isSiteOpen)"
       @touchstart="dragMouseDown($event, $refs.card); elementStyle($refs.card, 'down', isSiteOpen)"
       @touchend="elementStyle($refs.card, 'up', isSiteOpen)"
       @mouseup="elementStyle($refs.card, 'up', isSiteOpen)">
      <div v-if="openedSite !== ''" class="back" @click="back"><i class="bi bi-arrow-left-circle"></i></div>
      <h6 class="tit" id="title">{{title}}</h6>
      <tool-bar class="toolbar" id="toolbar" :card="newCard" :container="container" @close-window="close"/>
    </div>
    <div class="card-body" id="card-body" ref="cardBody">
      <div class="sites-container" v-if="openedSite === ''">
        <div class="site" ref="management" id="managementBtn"
             @click="openSite('management')"
             @mouseover="moveSiteBtn($refs.management, 'up')"
             @mouseleave="moveSiteBtn($refs.management)">
          <i class="bi bi-receipt" id="management"></i>
          <label for="management">Student Management System (GUI)</label>
        </div>
        <div class="site" ref="chat" id="chatBtn"
             @click="openSite('chat')"
             @mouseover="moveSiteBtn($refs.chat, 'up')"
             @mouseleave="moveSiteBtn($refs.chat)">
          <i class="bi bi-chat-square-text" id="chat"></i>
          <label for="chat">Python ChatGPT Chatbot (GUI)</label>
        </div>
      </div>
      <div class="management" v-if="openedSite === 'management'">
        <div class="textWrapper">
          <h3>Python Student Management System</h3>
          <h5>App features:</h5>
          <p>- You can add, edit or delete student entries (Name, Course and Mobile)</p>
          <p>- You can search up a specific student by name</p>
        </div>
      </div>
      <div class="management" v-if="openedSite === 'chat'">
        <div class="textWrapper">
          <h3>Python Chatbot</h3>
          <p>- A simple GUI made for the ChatGPT API</p>
        </div>
      </div>
    </div>
    <div class="card-footer" id="card-footer" ref="cardFooter">
      <div v-if="openedSite === 'chat'" class="buttons">
        <a class="btn btn-outline-primary" href="https://github.com/ZxPower145/python-chatgpt-chatbot"
           target="_blank">
          GitHub
        </a>
      </div>
      <div v-if="openedSite === 'management'" class="buttons">
        <a class="btn btn-outline-primary" href="https://github.com/ZxPower145/student-management-system-gui"
           target="_blank">
          GitHub
        </a>
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

  .chat {
    grid-row: span 3;
  }
  .management {
    display: flex;
    width: 100%;
    height: 100%;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
  .textWrapper {
    display: flex;
    flex-direction: column;
    gap: 30px;
  }
  h3 {
    font-size: 30px;
    font-weight: 600;
    text-transform: uppercase;
    color: whitesmoke;
  }
  h5 {
    color: lightgrey;
    font-size: 25px;
  }
  p {
    font-size: 20px;
    color: lightgrey;
  }
  .card-body {
    overflow: hidden;
    padding: 0;
  }
  .card {
    overflow: hidden;
  }
</style>