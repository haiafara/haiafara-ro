<template>
  <div id="map" />
</template>

<script>
import { eventBus } from 'packs/haiafara'
import L from 'leaflet'
import 'leaflet/dist/leaflet.css'
import 'leaflet.fullscreen'
import 'leaflet.fullscreen/Control.FullScreen.css'
import 'leaflet-active-area'
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
      geoJSONQueue: []
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
    eventBus.$on('mapQueueGeoJSON', (geoJSONData) => {
      this.queueGeoJSON(geoJSONData)
    })
    eventBus.$on('mapClearGeoJSONLayer', () => {
      if(this.geoJSONLayer) {
        this.geoJSONLayer.clearLayers()
      }
    })
  },
  mounted () {
    this.resizeSensor = new ResizeSensor(document.getElementById('map'), () => {
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
    queueGeoJSON(geoJSONData) {
      this.geoJSONQueue.push(geoJSONData)
      if(this.flexStabilised) {
        this.addGeoJSON()
      }
    },
    addGeoJSON() {
      for(var key in this.geoJSONQueue) {
        var gd = this.geoJSONQueue[key]
        this.geoJSONLayer.addData({
          type: 'Feature',
          properties: {
            name: gd.name,
            type: gd.type
          },
          id: gd.id,
          geometry: gd.geometry
        })
      }
      this.geoJSONQueue = []
    },
    checkFlexStabilized() {
      var newHeight = document.getElementById('map').clientHeight
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
      this.map = L.map('map', {
        fullscreenControl: true,
        fullscreenControlOptions: {
          position: 'topright'
        },
        maxZoom: 20,
        trackResize: true
      })

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
            eventBus.$emit('infoPanelToggle')
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
      if(window.matchMedia('(min-width: 768px)').matches) {
        this.map.setActiveArea({
          position: 'absolute',
          top: '0px',
          left: '450px',
          right: '0px',
          bottom: '0px'
        })
      }
    }
  }
}
</script>

<style>
  #map {
    z-index: 0;
    height: 100%;
  }
</style>
