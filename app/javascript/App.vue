<template>
  <div class="h-screen">
    <haiafara-lightbox />
    <haiafara-navigation />
    <div
      id="content"
      class="h-full w-fill"
    >
      <haiafara-info-panel />
      <haiafara-map />
    </div>
  </div>
</template>

<script>
  import { eventBus } from 'packs/haiafara'
  import LightBox from './LightBox'
  import Navigation from './Navigation'
  import InfoPanel from './InfoPanel'
  import Map from './Map.vue'

  export default {
    components: {
      'haiafara-lightbox': LightBox,
      'haiafara-navigation': Navigation,
      'haiafara-info-panel': InfoPanel,
      'haiafara-map': Map
    },
    data() {
      return {
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
    }
  }
</script>

<style>
  #content {
    padding-top: 56px;
  }
</style>
