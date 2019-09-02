<template>
  <div>
    <h1>{{ title }}</h1>
    {{ description }}
    <haiafara-photo-gallery :photos="photos" />
    <h2>Puncte de interes recomandate</h2>
    <ul>
      <li
        v-for="poi in pois"
        :key="poi.attributes.name"
      >
        <router-link
          :to="{ name: 'poi', params: { id: poi.id }}"
        >
          {{ poi.attributes.name }}
        </router-link>
      </li>
    </ul>
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
