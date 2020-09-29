

<template>
  <div>
    <h1
      class="text-2xl font-bold text-gray-700 mb-2"
    >
      {{ title }}
    </h1>
    <!-- eslint-disable vue/no-v-html -->
    <div
      class="mb-2"
      v-html="description"
    />
    <!-- eslint-enable vue/no-v-html -->
    <haiafara-photo-gallery
      v-if="photos.length"
      :photos="photos"
    />
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
        photos: []
      }
    },
    created() {
      var rj = window.resource_json
      if(
        rj &&
        rj.data.type == 'poi' &&
        rj.data.id == this.$route.params.id
      ) {
        this.updatePOI(rj)
      } else {
        fetch('/api/pois/' + this.$route.params.id, {
          method: 'get'
        }).then((response) => {
          return response.json()
        }).then((json) => {
          this.updatePOI(json)
        })
      }
    },
    mounted() {
      eventBus.$emit('mapClearGeoJSONLayer')
    },
    methods: {
      updatePOI(json) {
        this.$nextTick(function() {
          eventBus.$emit('appUpdateOnScreen', { type: json.data.type, name: json.data.attributes.name })
          eventBus.$emit('mapFitBounds', json.data.attributes.bounds)

          this.title = json.data.attributes.name
          this.description = json.data.attributes.description_html
          this.photos = []

          this.relationships = json.data.relationships
          this.included = json.included

          this.loadIncludedPhotos()
        })
      }
    }
  }
</script>

<style>
</style>
