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
      v-html="description_html"
    />
    <!-- eslint-enable vue/no-v-html -->
    <haiafara-photo-gallery
      v-if="photos.length"
      :photos="photos"
    />
    <haiafara-poi-list
      v-if="pois.length"
      :pois="pois"
    />
  </div>
</template>

<script>
  import { eventBus } from 'packs/haiafara'
  import PhotoGallery from './PhotoGallery'
  import POIList from './POIList'
  import { load_included } from './mixins/load_included'

  export default {
    components: {
      'haiafara-photo-gallery': PhotoGallery,
      'haiafara-poi-list': POIList
    },
    mixins: [ load_included ],
    data() {
      return {
        title: '',
        description_html: '',
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
          this.description_html = json.data.attributes.description_html
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
