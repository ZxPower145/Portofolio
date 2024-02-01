<script>
  export default {
    name: 'ToolBar',
    props: {
      card: '',
    },
    methods: {
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
    <h4 @click="close" class="bi bi-x-circle"></h4>
  </div>
</template>

<style scoped lang="scss">
  .toolbar h4 {
    grid-row: 3 / 3;
    cursor: pointer;
    max-height: 24px;
    font-weight: bold;
    margin: 0;
    color: darkred;
  }
</style>