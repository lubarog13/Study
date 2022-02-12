<template>
  <div id="app" :class="typeof weather.main != 'undefined' && weather.main.temp > 16 ? 'warm' : ''">
    <main>
      <div class="search">
        <input type="text" class="search__bar" placeholder="Search..." v-model="query" @keypress="fetchWeather">

      </div>
      <div class="weather" v-if="typeof weather.main != 'undefined'">
        <div class="weather__location location">
          <div class="location__place">{{weather.name}}, {{weather.sys.country}}</div>
          <div class="location__date">{{dateParse()}}</div>
        </div>
        <div class="weather__info">
          <div class="weather__info-temp">{{ Math.round(weather.main.temp) }}°С</div>
          <div class="weather__info-weather">{{ weather.weather[0].main }}</div>
        </div>
        <div class="weather__forecast forecast" v-if="typeof forecast !='undefined'">
          <div class="forecast__title">Weather forecast for 7 days</div>
          <div v-for="day in forecast" :key="day.dt" class="forecast__day-block">
            <div class="forecast__day-image">
              <img v-bind:src="require('./assets/' + day.weather[0].main + '.png')" class="day__img">
              <div class="forecast__day-weather">
              {{ day.weather[0].main }}
            </div>
            </div>
            <div class="forecast__day-main">
            <div class="forecast__day-temp">
              <b>Day: </b>{{ Math.round(parseTemp(day.temp.day)) }}°С<br>
              <b>Night: </b>{{ Math.round(parseTemp(day.temp.night)) }}°С
            </div>
            <div class="forecast__day-date">{{ parseDayDate(day.dt) }}</div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script>

export default {
  name: 'App',

  data() {
    return {
      api_key: "728abff1d97171ab28a008e3e5800944",
      url_base: 'https://api.openweathermap.org/data/2.5/',
      query: '',
      weather: {},
      forecast: []
    }
  },
  methods: {
    dateParse() {
      return new Date().toDateString()
    },
    fetchWeather(e) {
      if (e.key == "Enter") {
        fetch(`${this.url_base}weather?q=${this.query}&units=metric&APPID=${this.api_key}`)
        .then(res => {
          return res.json();
        }).then(this.setResults)
      }
    },

    setResults(results) {
      this.weather = results
      this.fetchForecast()
    },

    fetchForecast () {
      fetch(`${this.url_base}onecall?lat=${this.weather.coord.lat}&lon=${this.weather.coord.lon}&exclude=current,hourly&appid=${this.api_key}`)
      .then(res => {
        return res.json();
      }).then(this.setForecast)
    },

    setForecast(result) {
      this.forecast = result.daily
    }, 

    parseTemp(temp) {
      return temp - 273.15
    },
    parseDayDate(dt) {
      console.log(dt)
      let date = new Date( dt * 1000)
      console.log(date)
      return date.toDateString()
    }
  },
  created() {
    this.fetchWeather("London")
  }
}
</script>

<style>
body {
  font-family: 'montserrat', sans-serif;
}
#app {
  background: url(./assets/cold-bg.jpg);
  background-size: cover;
  background-position: bottom;
  transition: 0.4s;
}

#app.warm {
  background-image: url('./assets/warm-bg.jpg');
}

main {
  height: 100vh;
  padding: 25px;
  overflow: auto;
  background-image: linear-gradient(to bottom, rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.75)) ;
}

.search {
  width: 100%;
  margin-bottom: 30px;
  display: flex
}

.search .search__bar {
  display: block;
  padding: 15px;
  flex: 1;
  border: none;
  appearance: none;
  outline: none;
  background: none;
  color: #313131;
  font-size: 20px;
  box-shadow: 0 0 8px rgba(0, 0, 0, 0.25);
  background-color: rgba(255, 255, 255, 0.5);
  border-radius: 0px 16px 0px 16px;
  transition: 0.4s;
}

.search .search__bar:focus {
  box-shadow: 0 0 16px rgba(0, 0, 0, 0.25);
  background-color: rgba(255, 255, 255, 0.75);
  border-radius: 16px 0px 16px 0px; 
}

.location {
  color: white;
}

.location__place {
  font-size: 32px;
  font-weight: 500;
  text-align: center;
  text-shadow: 1px 3px rgba(0, 0, 0, 0.25);
}

.location__date {
  font-size: 20px;
  font-weight: 300;
  font-style: italic;
  text-align: center;
}

.weather__info {
  text-align: center;
  color: white;

}

.weather__info-temp {
  display: inline-block;
  padding: 10px 25px;
  color: white;
  font-size: 102px;
  font-weight: 900;
  text-shadow: 3px 6px rgba(0, 0, 0, 0.25);
  background-color: rgba(255, 255, 255, 0.25);
  border-radius: 16px ;
  margin: 30px 0px;
  box-shadow: 3px 6px rgba(0, 0, 0, 0.25);
}

.weather__info-weather {
  font-size: 48px;
  font-weight: 700;
  font-style: italic;
  text-shadow: 3px 6px rgba(0, 0, 0, 0.25);
}

.weather__forecast {
  margin-top: 60px;
}

.forecast__day-block{
  display: flex;
  background: rgba(255, 255, 255, 0.5);
  border-radius: 10px;
  box-shadow: 3px 6px rgba(0, 0, 0, 0.25);
  margin-bottom: 10px;
  padding: 20px 10px;
  align-items: center;
}

.forecast__day-image {
  display: block;
  width: 40%;
}

.forecast__day-main {
  display: block;
  flex: 1;
  padding-left: 20px;
}

.forecast__title {
  color: white;
  font-size: 22px;
  font-weight: 600;
  margin-bottom: 30px;
}

.forecast__day-temp {
  font-size: 20px;
  font-weight: 500;
  text-shadow: 1px 1px rgba(0, 0, 0, 0.25);
}

.forecast__day-weather {
  width: 100%;
  text-align: center;
  font-weight: 600;
  font-style: italic;
}

.forecast__day-date {
  font-size: 16px;
  color: #464545;
  padding-top: 10px;
}
.day__img {
  width: 100%;
  
}

</style>
