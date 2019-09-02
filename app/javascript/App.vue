<template>
  <div class="h-screen">
    <haiafara-lightbox />
    <haiafara-navigation />
    <div
      id="content"
      class="h-full w-fill"
    >
      <aside
        id="info-panel"
        class="absolute p-2"
        :class="{'collapsed': !showInfoPanel, 'sliding-panel': true}"
      >
        <div class="rounded-lg bg-white p-3 h-full">
          <router-view />
        </div>
      </aside>
      <haiafara-map />
    </div>
  </div>
</template>

<script>
  import { eventBus } from 'packs/haiafara'
  import Navigation from './Navigation'
  import Map from './Map.vue'
  import LightBox from './LightBox'

  export default {
    components: {
      'haiafara-map': Map,
      'haiafara-lightbox': LightBox,
      'haiafara-navigation': Navigation
    },
    data() {
      return {
        showInfoPanel: true,
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
    transition: padding 0.2s;
  }

  #map-container.collapsed {
    padding-left: 450px;
  }

  #map-container.map-minheight {
    min-height: 400px;
  }

  #info-panel {
    z-index: 3;
  }

  #info-panel.sliding-panel {
    overflow: auto;
    width: 450px;
    transition: transform 0.2s;
    transform: translateX(0px);
    height: calc(100vh - 56px);
  }

  #info-panel.sliding-panel.collapsed {
    transform: translateX(-450px);
  }

  #content {
    padding-top: 56px;
  }
</style>
