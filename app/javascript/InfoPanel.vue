<template>
  <aside
    id="info-panel"
    class="sliding-panel absolute p-2"
    :class="{'collapsed': !show}"
  >
    <div class="rounded-lg bg-white p-3 h-full shadow border border-gray-300">
      <router-view />
    </div>
  </aside>
</template>

<script>
import { eventBus } from 'packs/haiafara'

export default {
  data() {
    return {
      show: true
    }
  },
  created() {
    eventBus.$on('infoPanelToggle', () => {
      this.toggle()
    })
  },
  methods: {
    toggle() {
      this.show = !this.show
      setTimeout(() => {
        eventBus.$emit('mapInvalidateSize')
      }, 200)
    }
  }
}
</script>

<style scoped>
  #info-panel {
    z-index: 5;
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
</style>