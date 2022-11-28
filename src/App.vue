<script setup>
import { RouterView} from 'vue-router'
import Navbar from './components/Navbar.vue'
</script>

<template>
  <div>
    <Navbar />

    <div class="container shadow rounded mt-3 p-2 bg-light border">
      <RouterView />
    </div>
  </div>
</template>