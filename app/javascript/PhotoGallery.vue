<template>
  <div>
    <h2 class="text-lg font-semibold">
      {{ title }}
    </h2>
    <ul>
      <li
        v-for="(photo, index) in (photos)"
        :key="photo.src"
      >
        <img
          :src="photo.thumb"
          @click="openLightBox(index)"
        >
      </li>
    </ul>
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
    cursor: pointer;
  }
</style>
