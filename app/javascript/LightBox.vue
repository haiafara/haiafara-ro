<template>
  <div id="lightbox">
    <LightBox
      ref="lightbox"
      :show-caption="true"
      :show-light-box="false"
      :images="images"
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
