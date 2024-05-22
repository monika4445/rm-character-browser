<template>
  <div class="home">
    <h1>Rick and Morty Characters</h1>
    <CharacterList />
  </div>
</template>

<script>
import CharacterList from '@/components/CharacterList.vue';

export default {
  name: 'App',
  components: { CharacterList },
};
</script>

<style scoped>
.home {
  text-align: center;
}
</style>
