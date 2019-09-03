<template>
  <div class="mb-2">
    <h2 class="text-lg font-semibold">
      {{ title }}
    </h2>
    <div class="flex flex-wrap justify-between">
      <img
        v-for="(photo, index) in (photos)"
        :key="photo.src"
        :src="photo.thumb"
        @click="openLightBox(index)"
      >
    </div>
  </div>
</template>

<script>
import { eventBus } from 'packs/haiafara'

export default {
  props: {
    title: {
      type: String,
      default: 'Galerie Foto'
    },
    photos: {
      type: Array,
      default: () => []
    }
  },
  methods: {
    openLightBox(index) {
      eventBus.$emit('lightboxOpen', this.$props.photos, index)
    }
  }
}
</script>

<style scoped>
  img {
    width: 32.5%;
    height: 100%;
    cursor: pointer;
  }
</style>
