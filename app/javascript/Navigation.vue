<template>
  <nav
    id="navbar"
    class="flex items-center justify-between flex-wrap bg-teal-500 p-3 fixed shadow w-full"
  >
    <router-link
      class="flex items-center flex-shrink-0 text-white mr-6"
      to="/"
    >
      <haiafara-logo />
      <span class="font-semibold text-xl ml-1">Hai Afară!</span>
    </router-link>
  </nav>
</template>

<script>
import Logo from './Logo'

export default {
  components: {
    'haiafara-logo': Logo
  }
}
</script>

<style>
#navbar {
  height: 56px;
}
</style>
