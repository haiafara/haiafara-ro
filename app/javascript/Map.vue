<template>
  <div id="map"></div>
</template>

<script>
  import { eventBus } from "packs/haiafara";
  import L from "leaflet";
  import "leaflet/dist/leaflet.css";
  import LF from "leaflet.fullscreen";
  import "leaflet.fullscreen/Control.FullScreen.css";

  export default {
    data() {
      return {
        map: null,
        geoJSONLayer: null
      }
    },
    created() {
      eventBus.$on("mapInvalidateSize", () => {
        this.map.invalidateSize(true);
      })
      eventBus.$on("mapSetView", (coordinates, zoom) => {
        this.map.setView(coordinates, zoom);
      })
      eventBus.$on("mapFitBounds", (bounds) => {
        this.map.fitBounds(bounds);
      })
      eventBus.$on("mapAddGeoJSON", (type, id, name, geometry) => {
        this.geoJSONLayer.addData({ type: "Feature", properties: { type: type, name: name }, id, geometry });
      })
      eventBus.$on("mapClearGeoJSONLayer", () => {
        this.geoJSONLayer.clearLayers();
      })
    },
    mounted() {
      var CustomControl = L.Control.extend({
        options: {
          position: "topright"
        },
        onAdd(map) {
          var container = L.DomUtil.create("div", "leaflet-bar leaflet-control leaflet-control-custom");

          container.style.backgroundColor = "white";
          container.style.width = "40px";
          container.style.height = "30px";
          container.style.padding = "5px";
          container.style.cursor = "pointer";
          container.style.textAlign = "center";
          container.innerHTML = "Info";

          container.onclick = function() {
            eventBus.$emit("toggleInfoPanel");
          }

          return container;
        }
      });
      this.map = L.map("map", { fullscreenControl: true, maxZoom: 20, trackResize: true });
      var tileLayer = L.tileLayer("//tileserver.haiafara.ro/hot/{z}/{x}/{y}.png", {
        attribution: "&copy; Contribuitori <a href='https://www.openstreetmap.org/copyright'>OpenStreetMap</a>",
        maxZoom: 20
      });
      tileLayer.addTo(this.map);
      this.map.addControl(new CustomControl());

      this.geoJSONLayer = L.geoJSON(
        undefined,
        {
          onEachFeature: (feature, layer) => {
            layer.on({
              click: () => {
                this.$router.push({ name: feature.properties.type, params: { id: feature.id }});
              }
            })
            layer.bindTooltip(feature.properties.name);
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
                    iconUrl: "/marker-icon-blue.png"
                  }
                )
              }
            )
          }
        }
      ).addTo(this.map);
    }
  };
</script>

<style>
  #map {
    z-index: 0;
    width: 100%;
    height: 100%;
  }
</style>
