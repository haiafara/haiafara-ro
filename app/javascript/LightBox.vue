<template>
  <div id="lightbox">
    <LightBox
      ref="lightbox"
      :images="images"
      :show-light-box="false"
    />
  </div>
</template>

<script>
  import { eventBus } from 'packs/haiafara'
  import LightBox from 'vue-image-lightbox'
  import 'vue-image-lightbox/dist/vue-image-lightbox.min.css'

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
