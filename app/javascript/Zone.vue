<template>
  <v-container ma-0 pa-0 fluid fill-height class="b">
    <v-layout row wrap>
      <v-flex grow :class="{'map-minheight': $vuetify.breakpoint.smAndDown, 'collapsed': showInfoPanel && $vuetify.breakpoint.mdAndUp }" id="map-container">
        <haiafara-map></haiafara-map>
      </v-flex>
      <aside :class="{'collapsed': !showInfoPanel, 'sliding-panel': $vuetify.breakpoint.mdAndUp}" id="info-panel">
        <h1>Lorem ipsum dolor sit amet</h1>
        <p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Doloremque nostrum explicabo dolorum expedita commodi id, porro voluptatem, est delectus corporis obcaecati laborum sit unde suscipit modi incidunt consequatur sunt neque. Lorem ipsum, dolor sit amet consectetur adipisicing elit. Doloremque nostrum explicabo dolorum expedita commodi id, porro voluptatem, est delectus corporis obcaecati laborum sit unde suscipit modi incidunt consequatur sunt neque.</p>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Veritatis maiores culpa nam a, libero tempore laborum nostrum cupiditate necessitatibus mollitia animi debitis dolores est tempora fugit doloremque, quisquam nemo alias! Lorem ipsum dolor sit amet consectetur, adipisicing elit. Debitis modi minima quos! Reprehenderit inventore beatae totam corrupti illo, id aliquid commodi illum quibusdam accusantium modi culpa in impedit tempora pariatur!<p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Corporis praesentium corrupti et quos rerum labore. Laborum numquam, voluptates sint quas veritatis culpa minus labore quos natus quod. Voluptatum, magni unde. Lorem, ipsum dolor sit amet consectetur adipisicing elit. Dolore accusantium beatae vero perferendis assumenda culpa, unde incidunt aperiam provident! Sapiente neque architecto, totam placeat perferendis dicta earum exercitationem sint accusantium? Lorem, ipsum dolor sit amet consectetur adipisicing elit. Praesentium mollitia deserunt ad fugit doloribus? Nemo optio accusamus quas expedita, aliquid, aspernatur numquam officiis qui ex temporibus quidem illum! Nostrum, deleniti!</p>
        <p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ducimus illo maiores facilis mollitia enim sapiente hic nobis distinctio libero, veniam commodi debitis sequi beatae quae eveniet, repellendus temporibus quibusdam magni? Lorem ipsum dolor sit amet consectetur adipisicing elit. Odit fugiat nemo quasi esse, similique ipsa eos in nesciunt ipsum consectetur praesentium magni optio consequatur nulla ea vel. Magnam, minima aliquid!</p>
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
        showInfoPanel: false
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

  #info-panel.sliding-panel {
    padding: 15px;
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
