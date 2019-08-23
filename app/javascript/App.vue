<template>
  <v-app id="inspire">
    <LightBox :images="images" />
    <v-navigation-drawer
      v-model="drawer"
      fixed
      clipped
      app
    >
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
    <v-toolbar
      color="light-blue"
      clipped-left
      dense
      dark
      app
    >
      <v-toolbar-side-icon @click.stop="toggleNavigationDrawer" />
      <v-btn
        icon
        @click="toggleInfoPanel"
      >
        <v-icon>info</v-icon>
      </v-btn>
      <v-toolbar-title>{{ appTitle }}</v-toolbar-title>
    </v-toolbar>
    <v-content>
      <v-container
        ma-0
        pa-0
        fluid
        fill-height
        class="b"
      >
        <v-layout
          row
          wrap
        >
          <v-flex
            id="map-container"
            :class="{'map-minheight': $vuetify.breakpoint.xsAndDown, 'collapsed': showInfoPanel && $vuetify.breakpoint.smAndUp }"
          >
            <haiafara-map />
          </v-flex>
          <aside
            id="info-panel"
            :class="{'collapsed': !showInfoPanel, 'sliding-panel': $vuetify.breakpoint.smAndUp}"
          >
            <router-view />
          </aside>
        </v-layout>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
  import { eventBus } from 'packs/haiafara'
  import Map from './Map.vue'
  import LightBox from 'vue-image-lightbox'
  import 'vue-image-lightbox/dist/vue-image-lightbox.min.css'

  export default {
    components: {
      'haiafara-map': Map,
      LightBox
    },
    data() {
      return {
        showInfoPanel: false,
        drawer: false,
        on_screen: null,
        images: [
          {
            thumb: 'https://placekitten.com/200/200',
            src: 'https://placekitten.com/1000/500',
            caption: 'cat'
          },
          {
            thumb: 'https://placekitten.com/200/200',
            src: 'https://placekitten.com/1000/500',
            caption: 'cat'
          }
        ]
      }
    },
    computed: {
      appTitle() {
        let title = this.on_screen ? 'Hartă Turistică ' + this.on_screen.name : window.title
        document.title = title
        return title
      }
    },
    created() {
      eventBus.$on('appUpdateOnScreen', (on_screen) => {
        this.on_screen = on_screen
      })
      eventBus.$on('toggleInfoPanel', () => {
        this.toggleInfoPanel()
      })
    },
    methods: {
      toggleNavigationDrawer: function () {
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
      focusTown: function () {
        eventBus.$emit('mapSetView', [47.6623, 23.6970], 15)
      },
      focusChurch: function () {
        eventBus.$emit('mapSetView', [47.66283, 23.69984], 18)
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
