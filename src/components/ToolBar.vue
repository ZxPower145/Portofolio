<script>
  export default {
    name: 'ToolBar',
    props: {
      card: Object,
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
            this.card.style.height = "500px";
          } else {
            this.card.style.height = "50px";
          }
          this.isMinimized = !this.isMinimized;
        } else {
          console.error("Card element not found");
        }
      },
      close() {
        this.card.style.opacity = 0;
        this.$emit('close');
      }
    },
  }
</script>

<template>
  <div class="toolbar">
    <h4 v-if="isMinimized" @click="toggleSize" id="maximize" class="bi bi-fullscreen"></h4>
    <h4 v-else @click="toggleSize" id="minimize" class="bi bi-fullscreen-exit"></h4>
    <h4 @click="close" id="close" class="bi bi-x-square"></h4>
  </div>
</template>

<style lang="scss">
  #close {
    color: darkred;
  }

  .toolbar {
    display: flex;
    flex-direction: row;
    margin-left: auto;
    gap: 12px;
  }
</style>