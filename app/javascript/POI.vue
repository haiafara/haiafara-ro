<template>
  <div>
    <div class="text">
      <h1>{{ title }}</h1>
      {{ description }}
    </div>
  </div>
</template>

<script>
  import { eventBus } from 'packs/haiafara'

  export default {
    data() {
      return {
        title: '',
        description: ''
      }
    },
    methods: {
      updatePOI(json) {
        this.$nextTick(function() {
          eventBus.$emit('appUpdateOnScreen', { type: json.data.type, name: json.data.attributes.name })
          eventBus.$emit('mapFitBounds', json.data.attributes.bounds)
          this.title = json.data.attributes.name
          this.description = json.data.attributes.description
        })
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
    }
  }
</script>

<style>
</style>
