<template>
  <v-container ma-0 pa-0 fluid fill-height class="b">
    <v-layout row wrap>
      <v-flex :class="{'map-minheight': $vuetify.breakpoint.xsAndDown, 'collapsed': showInfoPanel && $vuetify.breakpoint.smAndUp }" id="map-container">
        <haiafara-map></haiafara-map>
      </v-flex>
      <aside :class="{'collapsed': !showInfoPanel, 'sliding-panel': $vuetify.breakpoint.smAndUp}" id="info-panel">
        <h1>{{ infoPanelTitle }}</h1>
        {{ infoPanelDescription }}
      </aside>
    </v-layout>
  </v-container>
</template>

<script>
  import { eventBus } from 'packs/haiafara'
  import Map from './Map.vue'

  export default {
    components: {
      'haiafara-map': Map
    },
    data() {
      return {
        showInfoPanel: false,
        infoPanelTitle: '',
        infoPanelDescription: '',
        infoPanelPOIs: []
      }
    },
    methods: {
      toggleInfoPanel() {
        this.showInfoPanel = !this.showInfoPanel
        setTimeout(() => {
          eventBus.$emit('mapInvalidateSize')
        }, 200)
      },
      updateZone(json) {
        eventBus.$emit('appUpdateOnScreen', { type: json.data.type, name: json.data.attributes.name })
        eventBus.$emit('mapFitBounds', json.data.attributes.bounds)
        this.infoPanelTitle = json.data.attributes.name
        this.infoPanelDescription = json.data.attributes.description
        /* TODO - the following should be intersected with json.data.relationships.pois */
        this.infoPanelPOIs = json.included
        this.infoPanelPOIs.forEach(poi => {
          eventBus.$emit('mapAddGeoJSON', poi.attributes.shape)
        })
      }
    },
    created() {
      eventBus.$on('toggleInfoPanel', () => {
        this.toggleInfoPanel()
      })
    },
    mounted() {
      var rj = window.resource_json
      if(
        rj &&
        rj.data.type == 'zone' &&
        rj.data.id == this.$route.params.zone
      ) {
        this.updateZone(rj)
      } else {
        fetch('/api/zones/' + this.$route.params.zone, {
          method: 'get'
        }).then((response) => {
          return response.json()
        }).then((json) => {
          this.updateZone(json)
        })
      }
    }
  }
</script>

<style>
  /* TODO - separate this for mobile */
  #map-container {
    width: 100%;
    transition: padding 0.2s;
  }

  #map-container.collapsed {
    padding-right: 400px;
  }

  #map-container.map-minheight {
    min-height: 400px;
  }

  #info-panel {
    padding: 15px;
  }

  #info-panel.sliding-panel {
    background: #fff;
    right: 0;
    left: auto;
    position: absolute;
    height: 100%;
    overflow: auto;
    border-left: 1px solid #ddd;
    width: 400px;
    transition: transform 0.2s;
    transform: translateX(0px);
  }

  #info-panel.sliding-panel.collapsed {
    transform: translateX(400px);
  }
</style>
