<template>
  <v-app id="inspire">
    <v-navigation-drawer v-model="drawer" fixed clipped app>
      <v-list dense>
        <v-list-tile @click="focusTown">
          <v-list-tile-action>
            <v-icon>home</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>Tot orașul</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile @click="focusChurch">
          <v-list-tile-action>
            <v-icon>contact_mail</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>Biserica Romano-Catolică</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>
    <v-toolbar color="light-blue" clipped-left dense dark app>
      <v-toolbar-side-icon @click.stop="toggleNavigationDrawer"></v-toolbar-side-icon>
      <v-btn icon @click="toggleInfoPanel">
        <v-icon>info</v-icon>
      </v-btn>
      <v-toolbar-title>{{ appTitle }}</v-toolbar-title>
    </v-toolbar>
    <v-content>
      <v-container ma-0 pa-0 fluid fill-height class="b">
        <v-layout row wrap>
           <v-flex :class="{'map-minheight': $vuetify.breakpoint.xsAndDown, 'collapsed': showInfoPanel && $vuetify.breakpoint.smAndUp }" id="map-container">
            <haiafara-map></haiafara-map>
          </v-flex>
         <aside :class="{'collapsed': !showInfoPanel, 'sliding-panel': $vuetify.breakpoint.smAndUp}" id="info-panel">
            <router-view></router-view>
          </aside>
        </v-layout>
      </v-container>
    </v-content>
  </v-app>
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
        drawer: false,
        on_screen: null
      }
    },
    computed: {
      appTitle() {
        let title = this.on_screen ? 'Hartă Turistică ' + this.on_screen.name : window.title
        document.title = title
        return title
      }
    },
    methods: {
      toggleNavigationDrawer: function (event) {
        this.drawer = !this.drawer;
        setTimeout(() => {
          eventBus.$emit('mapInvalidateSize')
        }, 200)
      },
      toggleInfoPanel() {
        this.showInfoPanel = !this.showInfoPanel
        setTimeout(() => {
          eventBus.$emit('mapInvalidateSize')
        }, 200)
      },
      focusTown: function (event) {
        eventBus.$emit('mapSetView', [47.6623, 23.6970], 15)
      },
      focusChurch: function (event) {
        eventBus.$emit('mapSetView', [47.66283, 23.69984], 18)
      }
    },
    created() {
      eventBus.$on('appUpdateOnScreen', (on_screen) => {
        this.on_screen = on_screen
      })
      eventBus.$on('toggleInfoPanel', () => {
        this.toggleInfoPanel()
      })
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
    padding-left: 450px;
  }

  #map-container.map-minheight {
    min-height: 400px;
  }

  #info-panel {
  }

  #info-panel.sliding-panel {
    background: #fff;
    position: absolute;
    height: 100%;
    overflow: auto;
    border-right: 1px solid #ddd;
    width: 450px;
    transition: transform 0.2s;
    transform: translateX(0px);
  }

  #info-panel.sliding-panel.collapsed {
    transform: translateX(-450px);
  }
</style>
