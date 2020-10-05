<template>
  <div id="lightbox">
    <LightBox
      ref="lightbox"
      :media="images"
      :show-caption="true"
      :show-light-box="false"
    >
      <template v-slot:customCaption="slotProps">
        <div>
          <p>{{ slotProps.currentMedia.name }}</p>
          <!-- eslint-disable vue/no-v-html -->
          <span v-html="slotProps.currentMedia.description_html" />
          <!-- eslint-enable vue/no-v-html -->
        </div>
      </template>
    </LightBox>
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
        images: ['']
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
