<script>
export default {
  name: "ShootTheCrow",
  props: {
    description: '',
  },
  data() {
    return {
      seePreview: false
    }
  },
}
</script>

<template>
  <div v-if="!seePreview" class="description">
    <p v-html="description"></p>
    <button class="btn btn-primary playBtn" @click="seePreview = true">See Preview</button>
  </div>
  <div v-else>
    <img src="@/assets/preview/shootthecrowimg.png" class="elementImage">
  </div>
</template>

<style scoped lang="scss">

</style>