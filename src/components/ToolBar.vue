<script>
  export default {
    name: 'ToolBar',
    props: {
      container: '',
      card: '',
    },
    data() {
      return {
        isMinimized: false,
      }
    },
    methods: {
      toggleSize(card, container) {
        const bar = document.getElementById('minimized')
        this.isMinimized = !this.isMinimized
        if (this.isMinimized) {
          card.style.overflow = 'hidden'
          card.style.height = '50px'
          card.style.width = '200px'
          // bar.appendChild(card)
        } else {
          card.style.height = 'auto'
          card.style.width = 'auto'
          // container.parentNode.appendChild(card)
        }
      },
      close() {
        if (this.card) {
          this.$emit('close-window', [true, 'card'])
        } else {
          console.error("Card element not found in close func")
        }
      },
    },
  }
</script>

<template>
  <div class="toolbar">
    <h4 v-if="isMinimized" @click="toggleSize(card, container)" id="maximize" class="bi bi-fullscreen"></h4>
    <h4 v-else @click="toggleSize(card, container)" id="minimize" class="bi bi-fullscreen-exit"></h4>
    <h4 @click="close" class="bi bi-x-square" style="color: darkred"></h4>
  </div>
</template>

<style scoped lang="scss">
  .toolbar h4 {
    grid-row: 3 / 3;
    cursor: pointer;
    max-height: 24px;
    font-weight: bold;
    margin: 0;
  }
</style>