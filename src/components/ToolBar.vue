<script>
  export default {
    name: 'ToolBar',
    props: {
      card: Object,
      projectWindow: Object,
    },
    data() {
      return {
        isMinimized: false,
      }
    },
    methods: {
      toggleSize() {
        if (this.card) {
          if (this.isMinimized) {
            this.card.classList.remove('minimized')
          } else {
            this.card.classList.add('minimized')
          }
          this.isMinimized = !this.isMinimized
        } else {
          console.error("Card element not found")
        }
      },
      close() {
        this.card.classList.remove('minimized')
        this.isMinimized = false
        if (this.card.id === 'card') {
          this.$emit('close-window', [true, 'card'])
        }
        if (this.card.id === 'projectWindow') {
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
    <h4 v-if="isMinimized" @click="toggleSize" id="maximize" class="bi bi-fullscreen"></h4>
    <h4 v-else @click="toggleSize" id="minimize" class="bi bi-fullscreen-exit"></h4>
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