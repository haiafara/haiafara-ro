<template>
  <div id="lightbox">
    <LightBox
      ref="lightbox"
      :show-caption="true"
      :show-light-box="false"
      :media="images"
    />
  </div>
</template>

<script>
  import { eventBus } from 'packs/haiafara'
  import LightBox from 'vue-it-bigger'
  import 'vue-it-bigger/dist/vue-it-bigger.min.css'

  export default {
    components: {
      LightBox
    },
    data() {
      return {
        images: []
      }
    },
    created () {
      eventBus.$on('lightboxOpen', (images, index) => {
        this.images = images
        this.$refs.lightbox.showImage(index)
      })
    }
  }
</script>
