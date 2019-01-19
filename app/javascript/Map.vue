<template>
  <div id="map"></div>
</template>

<script>
  import { eventBus } from 'packs/haiafara'
  import L from 'leaflet'
  import 'leaflet/dist/leaflet.css'

  export default {
    data() {
      return {
        map: true
      }
    },
    mounted() {
      this.$nextTick(function () {
        this.map = L.map('map', { maxZoom: 20, trackResize: true }).setView([47.6623, 23.6970], 15)
        var tileLayer = L.tileLayer("//tileserver.haiafara.ro/hot/{z}/{x}/{y}.png", {
          attribution: '&copy; Contribuitori <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
          maxZoom: 20
        });
        tileLayer.addTo(this.map)
      })
    },
    created() {
      eventBus.$on('invalidateMapSize', () => {
        this.map.invalidateSize(true)
      })
      eventBus.$on('setMapView', (coordinates, zoom) => {
        this.map.setView(coordinates, zoom)
      })
    }
  }
</script>

<style>
  #map {
    z-index: 0;
    width: 100%;
    height: 100%;
  }
</style>
