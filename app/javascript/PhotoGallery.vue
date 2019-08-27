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
        v-for="(photo, index) in (photos)"
        :key="photo.src"
        xs4
      >
        <v-card
          flat
          tile
        >
          <v-img
            :src="photo.thumb"
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
