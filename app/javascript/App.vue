<template>
  <v-app id="inspire">
    <v-navigation-drawer v-model="drawer" fixed right app>
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
    <v-toolbar color="light-blue" dense dark app>
      <v-toolbar-title>{{ appTitle }}</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-side-icon @click.stop="toggleNavigationDrawer"></v-toolbar-side-icon>
    </v-toolbar>
    <v-content>
      <router-view></router-view>
    </v-content>
  </v-app>
</template>

<script>
  import { eventBus } from 'packs/haiafara'

  export default {
    data() {
      return {
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
    methods: {
      toggleNavigationDrawer: function (event) {
        this.drawer = !this.drawer;
        setTimeout(() => {
          eventBus.$emit('mapInvalidateSize')
        }, 200)
      },
      focusTown: function (event) {
        eventBus.$emit('mapSetView', [47.6623, 23.6970], 15)
      },
      focusChurch: function (event) {
        eventBus.$emit('mapSetView', [47.66283, 23.69984], 18)
      }
    },
    created() {
      eventBus.$on('appUpdateOnScreen', (on_screen) => {
        this.on_screen = on_screen
      })
    }
  }
</script>
