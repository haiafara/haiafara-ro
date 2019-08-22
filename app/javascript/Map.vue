<template>
  <div id="map" />
</template>

<script>
import { eventBus } from 'packs/haiafara'
import L from 'leaflet'
import 'leaflet/dist/leaflet.css'
import 'leaflet.fullscreen'
import 'leaflet.fullscreen/Control.FullScreen.css'
import ResizeSensor from 'css-element-queries/src/ResizeSensor'

export default {
  data () {
    return {
      map: null,
      geoJSONLayer: null,
      flexHeight: null,
      flexStabilised: false,
      flexChecker: undefined,
      resizeSensor: undefined,
      bounds: null,
      geoJSONData: null
    }
  },
  created () {
    eventBus.$on('mapInvalidateSize', () => {
      this.map.invalidateSize(true)
    })
    eventBus.$on('mapSetView', (coordinates, zoom) => {
      this.map.setView(coordinates, zoom)
    })
    eventBus.$on('mapFitBounds', (bounds) => {
      this.fitBounds(bounds)
    })
    eventBus.$on('mapAddGeoJSON', (geoJSONData) => {
      this.addGeoJSON(geoJSONData)
    })
    eventBus.$on('mapClearGeoJSONLayer', () => {
      if(this.geoJSONLayer) {
        this.geoJSONLayer.clearLayers()
      }
    })
  },
  mounted () {
    this.resizeSensor = new ResizeSensor(document.getElementById('map-container'), () => {
      this.checkFlexStabilized()
    })
  },
  methods: {
    fitBounds(bounds) {
      if(bounds == undefined) {
        bounds = this.bounds
      }
      if(this.flexStabilised) {
        this.map.fitBounds(bounds)
      } else {
        this.bounds = bounds
      }
    },
    addGeoJSON(geoJSONData) {
      if(geoJSONData == undefined) {
        geoJSONData = this.geoJSONData
      }
      if(this.flexStabilised) {
        this.geoJSONLayer.addData({
          type: 'Feature',
          properties: {
            name: geoJSONData.name,
            type: geoJSONData.type
          },
          id: geoJSONData.id,
          geometry: geoJSONData.geometry
        })
      } else {
        this.geoJSONData = geoJSONData
      }
    },
    checkFlexStabilized() {
      var newHeight = document.getElementById('map-container').clientHeight
      if(newHeight != 0 && newHeight == this.flexHeight) {
        this.flexStabilised = true
        this.resizeSensor.detach()
        clearTimeout(this.flexChecker)
        this.attachMap()
        this.fitBounds()
        this.addGeoJSON()
      } else {
        this.flexHeight = newHeight
        clearTimeout(this.flexChecker)
        this.flexChecker = setTimeout(() => {
          this.checkFlexStabilized()
        }, 50)
      }
    },
    attachMap() {
      this.map = L.map('map', { fullscreenControl: true, maxZoom: 20, trackResize: true })

      var CustomControl = L.Control.extend({
        options: {
          position: 'topright'
        },
        onAdd () {
          var container = L.DomUtil.create('div', 'leaflet-bar leaflet-control leaflet-control-custom')

          container.style.backgroundColor = 'white'
          container.style.width = '40px'
          container.style.height = '30px'
          container.style.padding = '5px'
          container.style.cursor = 'pointer'
          container.style.textAlign = 'center'
          container.innerHTML = 'Info'

          container.onclick = function () {
            eventBus.$emit('toggleInfoPanel')
          }

          return container
        }
      })
      this.map.addControl(new CustomControl())

      var tileLayer = L.tileLayer('//tileserver.haiafara.ro/hot/{z}/{x}/{y}.png', {
        attribution: "&copy; Contribuitori <a href='https://www.openstreetmap.org/copyright'>OpenStreetMap</a>",
        maxZoom: 20
      })
      tileLayer.addTo(this.map)

      this.geoJSONLayer = L.geoJSON(
        undefined,
        {
          onEachFeature: (feature, layer) => {
            layer.on({
              click: () => {
                this.$router.push({ name: feature.properties.type, params: { id: feature.id } })
              }
            })
            layer.bindTooltip(feature.properties.name)
          },
          pointToLayer: (feature, latlng) => {
            return L.marker(
              latlng,
              {
                icon: new L.Icon(
                  {
                    iconSize: [25, 41],
                    iconAnchor: [13, 41],
                    popupAnchor: [1, -24],
                    iconUrl: '/marker-icon-blue.png'
                  }
                )
              }
            )
          }
        }
      ).addTo(this.map)
    }
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
