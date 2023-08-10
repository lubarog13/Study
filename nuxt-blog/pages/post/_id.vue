<template>
  <article class="post">
    <header class="post-header">
      <div class="post-title">
        <h1>Post title</h1>

      </div>
    </header>
    <main>

    </main>

  </article>
</template>

<script>
export default {
  validate({params}) {
    return Boolean(params.id)
  }
}
</script>

<style scoped lang="less">
.post {

}
</style>
