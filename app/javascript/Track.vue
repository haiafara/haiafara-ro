<template>
  <div>
    <h1
      class="text-2xl font-bold text-gray-700 mb-2"
    >
      {{ title }}
    </h1>
    <div class="mb-2">
      {{ description }}
    </div>
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
        rj.data.type == 'track' &&
        rj.data.id == this.$route.params.id
      ) {
        this.updateTrack(rj)
      } else {
        fetch('/api/tracks/' + this.$route.params.id, {
          method: 'get'
        }).then((response) => {
          return response.json()
        }).then((json) => {
          this.updateTrack(json)
        })
      }
    },
    mounted() {
      eventBus.$emit('mapClearGeoJSONLayer')
    },
    methods: {
      updateTrack(json) {
        this.$nextTick(function() {
          eventBus.$emit('appUpdateOnScreen', { type: json.data.type, name: json.data.attributes.name })
          eventBus.$emit('mapFitBounds', json.data.attributes.bounds)

          this.title = json.data.attributes.name
          this.description = json.data.attributes.description
          this.photos = []

          this.relationships = json.data.relationships
          this.included = json.included

          this.loadIncludedPhotos()

          eventBus.$emit('mapQueueGeoJSON', {
            type: json.data.type,
            id: json.data.id,
            name: json.data.attributes.name,
            geometry: json.data.attributes.shape
          })
        })
      }
    }
  }
</script>

<style>
</style>
