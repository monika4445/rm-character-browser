<template>
    <div class="character-card">
      <h3>{{ character.name }}</h3>
      <img :src="character.image" :alt="character.name" style="max-width: 100%;" />
      <p>{{ character.status }} - {{ character.species }}</p>
      <p>Last known location:</p>
      <p>{{ character.location.name }}</p>
      <p>First seen in:</p>
      <p>{{ firstEpisode }}</p>
    </div>
  </template>
  
  <script>
  import { ref, watchEffect } from 'vue';
  import axios from 'axios';
  
  export default {
    props: ['character'],
    setup(props) {
      const firstEpisode = ref('');
  
      watchEffect(async () => {
        if (props.character.episode.length > 0) {
          try {
            const response = await axios.get(props.character.episode[0]);
            firstEpisode.value = response.data.name;
          } catch (error) {
            console.error('Error fetching episode:', error);
          }
        }
      });
  
      return { firstEpisode };
    },
  };
  </script>
  
  <style scoped>
  .character-card {
    border: 1px solid #ccc;
    padding: 10px;
    margin: 10px;
    border-radius: 5px;
    width: 30%;
  }
  </style>
  