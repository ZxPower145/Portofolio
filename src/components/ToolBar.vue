<script>
  export default {
    name: 'ToolBar',
    props: {
      container: Element,
      card: undefined,
    },
    data() {
      return {
        isMinimized: false,
      }
    },
    methods: {
      toggleSize(card, container) {
        const bar = document.getElementById('minimized')
        console.log('Container: ', container)
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
        if (this.card.id === 'folder-card' || 'card') {
          this.$emit('close-window', [true, 'card'])
        }
        if (this.card.id === 'projectWindow') {
          this.$emit('close-project-window', [true, 'project'])
        }
        else {
          this.$emit('close-project-window', [true, 'project'])
        }
        if (!this.card) {
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

<style lang="scss">
  .toolbar {
    display: flex;
    flex-direction: row;
    margin-left: auto;
    gap: 20px;
  }
  .toolbar h4 {
    cursor: pointer;
  }
</style>