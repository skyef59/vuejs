<script setup>
  import Snake from '@/components/Snake.vue'
</script>

<template>
  <div>
    <div class="h1"><span class="text-primary">A</span>bout</div>
    <hr>
    <div class="d-flex justify-content-center">
      <Snake 
        :heigthBox="500" 
        :widthBox="500" 
        :speed="50" 
      />
    </div>
  </div>
</template>