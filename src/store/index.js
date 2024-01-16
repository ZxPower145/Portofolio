import { createStore } from 'vuex'

export default createStore({
  state: {
    projectCard: Element,
    isLoading: false,
  },
  getters: {
  },
  mutations: {
    setIsLoading(state, status) {
      state.isLoading = status
    },
    setProjectCard(state, status) {
      state.projectCard = status
    }
  },
  actions: {
  },
  modules: {
  }
})
