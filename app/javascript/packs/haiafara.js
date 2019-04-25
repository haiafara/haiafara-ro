/* eslint no-console: 0 */

import Vue from 'vue'

import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
Vue.use(Vuetify)

// start the event bus, beep beep

export const eventBus = new Vue()

// import modules

import App from '../App.vue'
import Home from '../Home.vue'
import Zone from '../Zone.vue'
import POI from '../POI.vue'

// router

import VueRouter from 'vue-router'
Vue.use(VueRouter)

const routes = [
  { path: '/', name: 'home', component: Home },
  { path: '/unde/:id', name: 'zone', component: Zone },
  { path: '/pdi/:id', name: 'poi', component: POI }
]

const router = new VueRouter({
  mode: 'history',
  routes
})

// and go!

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#app',
    router,
    render: h => h(App),
  })
})
