<template>
  <div>
    <div class="text">
      <h1>{{ title }}</h1>
      {{ description }}
      <ul>
        <li
          v-for="(image, index) in (images)"
          :key="image.src"
        >
          <img
            :src="image.thumb"
            @click="openLightBox(index)"
          >
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
  import { eventBus } from 'packs/haiafara'

  export default {
    data() {
      return {
        title: '',
        description: '',
        images: [
          {
            thumb: 'https://placekitten.com/200/200',
            src: 'https://placekitten.com/1000/500',
            caption: 'cat'
          },
          {
            thumb: 'https://placekitten.com/200/200',
            src: 'https://placekitten.com/1000/500',
            caption: 'cat'
          }
        ]
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
          this.description = json.data.attributes.description
        })
      },
      openLightBox(index) {
        eventBus.$emit('lightboxOpen', this.images, index)
      }
    }
  }
</script>

<style>
</style>
