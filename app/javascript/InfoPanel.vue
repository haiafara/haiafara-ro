<template>
  <aside
    id="info-panel"
    class="sliding-panel absolute md:p-2"
    :class="{'collapsed': !show}"
  >
    <div class="text-gray-700 bg-white h-full p-3 md:rounded-lg md:shadow md:border md:border-gray-300">
      <div class="h-full overflow-auto">
        <button @click="toggle()" class="md:hidden w-full font-bold mb-2 py-2 px-4 rounded border border-gray-200">Arată harta</button>
        <router-view />
      </div>
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
    transition: transform 0.2s;
    transform: translateX(0px);
    height: calc(100vh - 56px);
  }

  @media screen and (max-width: 767px) {
    #info-panel.sliding-panel.collapsed {
      transform: translateX(-100%);
    }

    #info-panel.sliding-panel {
      width: 100%;
    }
  }

  @media screen and (min-width: 768px) {
    #info-panel.sliding-panel.collapsed {
      transform: translateX(-450px);
    }

    #info-panel.sliding-panel {
      width: 450px;
    }
  }
</style>
