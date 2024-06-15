<script>
import AnalyticsChart from "@/components/admin/AnalyticsChart.vue";

export default {
  name: "index",
  components: {AnalyticsChart},
  layout: 'admin',
  middleware: ['admin-auth'],
  async asyncData({store}) {
    const analytics = await store.dispatch('post/getAnalytics');
    return {analytics};
  },
}
</script>

<template>
  <div>
    <h1>Аналитика по постам</h1>
    <analytics-chart title="Количество комментариев" :labels="analytics.comments.labels" :data="analytics.comments.data"></analytics-chart>
    <analytics-chart title="Количество просмотров" :labels="analytics.views.labels" :data="analytics.views.data"></analytics-chart>
  </div>
</template>

<style scoped lang="less">

</style>
