<template>
    <div>
      <input v-model="name" placeholder="Name" />
      <select v-model="status">
        <option value="">All</option>
        <option value="alive">Alive</option>
        <option value="dead">Dead</option>
        <option value="unknown">Unknown</option>
      </select>
      <button @click="applyFilters">Apply</button>
    </div>
  </template>
  
  <script>
  import { ref } from 'vue';
  
  export default {
    emits: ['apply-filters'],
    setup(_, { emit }) {
      const name = ref('');
      const status = ref('');
  
      const applyFilters = () => {
        emit('apply-filters', { name: name.value, status: status.value });
      };
  
      return { name, status, applyFilters };
    },
  };
  </script>
  
  <style scoped>
  div {
    margin-bottom: 20px;
  }
  </style>
  