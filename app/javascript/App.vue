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
      <v-toolbar-title>Hartă Turistică Baia Sprie</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-side-icon @click.stop="toggleNavigationDrawer"></v-toolbar-side-icon>
    </v-toolbar>
    <v-content>
      <haiafara-map></haiafara-map>
    </v-content>
  </v-app>
</template>

<script>
  import Map from './Map.vue'

  export default {
    components: {
      'haiafara-map': Map
    },
    data: function() {
      return {
        drawer: false
      }
    },
    methods: {
      toggleNavigationDrawer: function (event) {
        this.drawer = !this.drawer;
        setTimeout(function() {
          // map.invalidateSize(true)
        }, 200);
      },
      focusTown: function (event) {
        // map.setView([47.6623, 23.6970], 15);
      },
      focusChurch: function (event) {
        // map.setView([47.66283, 23.69984], 18);
      }
    },
  }
</script>
