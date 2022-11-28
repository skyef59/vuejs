<script setup>
import { BIconTree } from 'bootstrap-icons-vue';
import { RouterLink } from 'vue-router'

const items = [
  {view: '/', label: 'Home'},
  {view: '/about', label: 'About'}
]
</script>

<template>
    <nav class="navbar sticky-top navbar-expand-lg bg-light border-bottom border-5 border-primary">
      <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <p class="h2 float-end text-primary d-flex align-items-end"><BIconTree variant="success"/>Expense </p>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav">
            <li class="nav-item" v-for="item in items" :key="item">
              <RouterLink 
                :to="item.view" 
                active-class="active-link" 
                class="nav-link p-2 m-1">
                  {{ item.label }}
              </RouterLink>
            </li>
          </ul>
        </div>
    </div>
  </nav>
</template>

<style>
  .active-link {
    background-color: rgba(177, 176, 176, 0.356);
    border-radius: 5px;
  }
</style>