<template>
  <div>
    <div class="text">
      <h1>{{ infoPanelTitle }}</h1>
      {{ infoPanelDescription }}
    </div>
    <v-list subheader>
      <v-subheader>Puncte de interes recomandate</v-subheader>
      <v-list-tile
        v-for="poi in infoPanelPOIs"
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

  export default {
    data() {
      return {
        infoPanelTitle: '',
        infoPanelDescription: '',
        infoPanelPOIs: []
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
          this.infoPanelTitle = json.data.attributes.name
          this.infoPanelDescription = json.data.attributes.description
          /* TODO - the following should be intersected with json.data.relationships.pois */
          this.infoPanelPOIs = json.included
          this.infoPanelPOIs.forEach(poi => {
            eventBus.$emit('mapQueueGeoJSON', {
              type: poi.type,
              id: poi.id,
              name: poi.attributes.name,
              geometry: poi.attributes.shape
            })
          })
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
