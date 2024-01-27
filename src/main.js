import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import bootstrap from 'bootstrap/dist/js/bootstrap'
import 'bootstrap-icons/font/bootstrap-icons.css'
import VueConfetti from 'vue-confetti'

createApp(App).use(VueConfetti).use(store).use(router).mount('#app')
