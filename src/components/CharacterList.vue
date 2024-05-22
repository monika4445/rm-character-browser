<template>
    <div>
      <Filters @apply-filters="applyFilters" />
      <div v-if="characters.length > 0">
        <div class="character-row" v-for="(chunk, index) in characterChunks" :key="index">
          <CharacterCard v-for="character in chunk" :key="character.id" :character="character" />
        </div>
      </div>
      <p v-else>{{ notFoundMessage }}</p>
      <Pagination v-if="characters.length > 0" :page="page" :totalPages="totalPages" @change-page="changePage" />
    </div>
  </template>
  
  <script>
  import { ref, computed, onMounted } from 'vue';
  import axios from 'axios';
  import CharacterCard from './CharacterCard.vue';
  import Filters from './FiltersOptions.vue';
  import Pagination from './PaginationControl.vue';
  
  export default {
    components: { CharacterCard, Filters, Pagination },
    setup() {
      const characters = ref([]);
      const page = ref(1);
      const totalPages = ref(1);
      const filters = ref({ name: '', status: '' });
      const notFoundMessage = ref('');
  
      const fetchCharacters = async () => {
        try {
          const { data } = await axios.get('https://rickandmortyapi.com/api/character', {
            params: {
              page: page.value,
              name: filters.value.name,
              status: filters.value.status,
            },
          });
          characters.value = data.results;
          totalPages.value = data.info.pages;
          notFoundMessage.value = characters.value.length === 0 ? 'No characters match your search criteria.' : '';
        } catch (error) {
          handleError(error);
        }
      };
  
      const handleError = (error) => {
        console.error('Error fetching characters:', error);
        characters.value = [];
        totalPages.value = 1;
        notFoundMessage.value = 'No characters match your search criteria.';
      };
  
      const applyFilters = (newFilters) => {
        filters.value = newFilters;
        page.value = 1;
        fetchCharacters();
      };
  
      const changePage = (newPage) => {
        page.value = newPage;
        fetchCharacters();
      };
  
      const characterChunks = computed(() => {
        const chunkSize = 3;
        return characters.value.reduce((acc, _, index) => {
          if (index % chunkSize === 0) {
            acc.push(characters.value.slice(index, index + chunkSize));
          }
          return acc;
        }, []);
      });
  
      onMounted(fetchCharacters);
  
      return { characterChunks, page, totalPages, applyFilters, changePage, characters, notFoundMessage };
    },
  };
  </script>
  
  <style scoped>
  .character-row {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
  }
  </style>
  