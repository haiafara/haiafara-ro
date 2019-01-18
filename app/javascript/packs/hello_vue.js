/* eslint no-console: 0 */

import Vue from 'vue/dist/vue.esm'

import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
Vue.use(Vuetify)

import L from 'leaflet'
import 'leaflet/dist/leaflet.css'

var map;

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: "#app",
    data: {
      drawer: false
    },
    props: {
      source: String
    },
    methods: {
      toggleNavigationDrawer: function (event) {
        this.drawer = !this.drawer;
        setTimeout(function() {
          map.invalidateSize(true)
        }, 200);
      },
      focusTown: function (event) {
        map.setView([47.6623, 23.6970], 15);
      },
      focusChurch: function (event) {
        map.setView([47.66283, 23.69984], 18);
      }
    },
    mounted: function() {
      this.$nextTick(function () {
        map = L.map("map", { maxZoom: 20, trackResize: false }).setView([47.6623, 23.6970], 15);
        var tileLayer = L.tileLayer("//tileserver.link7.ro/hot/{z}/{x}/{y}.png", {
          attribution: '&copy; Contribuitori <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
          maxZoom: 20
        });
        tileLayer.addTo(map);
      })
    }
  });
})
