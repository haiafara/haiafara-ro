<template>
  <div>
    <v-container pb-0>
      <h1>{{ title }}</h1>
      {{ description }}
    </v-container>
    <haiafara-photo-gallery :photos="photos" />
    <v-list subheader>
      <v-subheader>Puncte de interes recomandate</v-subheader>
      <v-list-tile
        v-for="poi in pois"
        :key="poi.attributes.name"
        avatar
        :to="{ name: 'poi', params: { id: poi.id }}"
      >
        <v-list-tile-avatar>
          <v-icon>place</v-icon>
        </v-list-tile-avatar>
        <v-list-tile-content>
          <v-list-tile-title>{{ poi.attributes.name }}</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>
  </div>
</template>

<script>
  import { eventBus } from 'packs/haiafara'
  import PhotoGallery from './PhotoGallery'
  import { load_included } from './mixins/load_included'

  export default {
    components: {
      'haiafara-photo-gallery': PhotoGallery
    },
    mixins: [ load_included ],
    data() {
      return {
        title: '',
        description: '',
        relationships: null,
        included: null,
        pois: [],
        photos: []
      }
    },
    created() {
      var rj = window.resource_json
      if(
        rj &&
        rj.data.type == 'zone' &&
        rj.data.id == this.$route.params.id
      ) {
        this.updateZone(rj)
      } else {
        fetch('/api/zones/' + this.$route.params.id, {
          method: 'get'
        }).then((response) => {
          return response.json()
        }).then((json) => {
          this.updateZone(json)
        })
      }
    },
    methods: {
      updateZone(json) {
        this.$nextTick(function() {
          eventBus.$emit('appUpdateOnScreen', { type: json.data.type, name: json.data.attributes.name })
          eventBus.$emit('mapFitBounds', json.data.attributes.bounds)

          this.title = json.data.attributes.name
          this.description = json.data.attributes.description
          this.pois = []
          this.photos = []

          this.relationships = json.data.relationships
          this.included = json.included

          this.loadIncludedPOIs()
          this.loadIncludedPhotos()
        })
      }
    }
  }
</script>

<style>
  .text {
    padding: 15px;
  }
</style>
