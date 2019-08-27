<template>
  <v-container
    grid-list-sm
    fluid
  >
    <h2>{{ title }}</h2>
    <v-layout
      row
      wrap
    >
      <v-flex
        v-for="(image, index) in (images)"
        :key="image.src"
        xs4
      >
        <v-card
          flat
          tile
        >
          <v-img
            :src="image.thumb"
            aspect-ratio="1"
            @click="openLightBox(index)"
          />
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { eventBus } from 'packs/haiafara'

export default {
  props: {
    title: {
      type: String,
      default: 'Galerie Foto'
    },
    images: {
      type: Array,
      default: () => []
    }
  },
  methods: {
    openLightBox(index) {
      eventBus.$emit('lightboxOpen', this.$props.images, index)
    }
  }
}
</script>
