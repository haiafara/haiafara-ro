<template>
  <v-container ma-0 pa-0 fluid fill-height class="b">
    <v-layout row wrap>
      <v-flex grow :class="{'map-minheight': $vuetify.breakpoint.smAndDown, 'collapsed': showInfoPanel && $vuetify.breakpoint.mdAndUp }" id="map-container">
        <haiafara-map></haiafara-map>
      </v-flex>
      <aside :class="{'collapsed': !showInfoPanel, 'sliding-panel': $vuetify.breakpoint.mdAndUp}" id="info-panel">
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
        infoPanelDescription: ''
      }
    },
    methods: {
      toggleInfoPanel() {
        this.showInfoPanel = !this.showInfoPanel
        setTimeout(() => {
          eventBus.$emit('mapInvalidateSize')
        }, 200)
      }
    },
    created() {
      eventBus.$on('toggleInfoPanel', () => {
        this.toggleInfoPanel()
      })
      fetch('/api/zones/' + this.$route.params.zone, {
        method: 'get'
      }).then((response) => {
        return response.json()
      }).then((json) => {
        eventBus.$emit('appUpdateOnScreen', { type: json.data.type, name: json.data.attributes.name })
        eventBus.$emit('mapFitBounds', json.data.attributes.bounds)
        this.infoPanelTitle = json.data.attributes.name
        this.infoPanelDescription = json.data.attributes.description
      })
    }
  }
</script>

<style>
  /* TODO - separate this for mobile */
  #map-container {
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
