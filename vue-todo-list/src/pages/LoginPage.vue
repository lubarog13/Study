<template>
<div class="login_page">
  <Particles id="tsparticles" :options="particlesConfig"/>
  <div class="login_page__content">
    <h2>{{text[lang].login_message}}</h2>
    <b-form class="form" @submit="signUp" >
      <b-form-input type="email" :state="validationEmail" v-model="login" required :placeholder="text[lang].email"></b-form-input>
      <p class="error" v-if="validationEmail===false">
        {{ text[lang].emailError }}
      </p>
      <b-form-input type="password" :state="validation" v-model="password" required :placeholder="text[lang].password" min="8"/>
      <p class="error" v-if="validation===false">
        {{ text[lang].passwordError }}
      </p>
      <b-button variant="light" @click="loginWithGoogle">{{text[lang].googleSignIn}}</b-button>
      <div class="form__actions">
        <b-button variant="success" type="button" @click="signIn">{{text[lang].signin}}</b-button>
        <b-button variant="info"  type="submit">{{text[lang].signup}}</b-button>
      </div>
      <p class="error" v-if="loginError || signupError">
        {{loginError? text[lang].loginError: text[lang].signupError}}
      </p>
    </b-form>
  </div>
</div>
</template>

<script>
import languageMixin from "@/mixines/languageMixin";
import particlesConfig from '../assets/particles_login.json'
import firebase from "firebase";

export default {
  name: "LoginPage",
  mixins: [languageMixin],
  data() {
    return {
      particlesConfig,
      login: null,
      password: null,
      loginError: false,
      signupError: false
    }
  },
  computed: {
    validation() {
      if(this.password===null) return null
      return  this.password.length > 7
    },
    validationEmail() {
      if (this.login===null) return null
      let mailformat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
      return  this.login.match(mailformat)!==null
    }
  },
  methods: {
    signIn() {
      firebase.auth().signInWithEmailAndPassword(this.login, this.password)
          .then((result) => {
            console.log(result)
            localStorage.setItem("uid", result.user.uid)
            this.$emit('signed', true)
          })
          .catch((err) => {
            this.loginError = true
            console.log(err); // This will give you all the information needed to further debug any errors
          });
    },
    signUp(event) {
      event.preventDefault()
      firebase.auth().createUserWithEmailAndPassword(this.login, this.password)
          .then(() => {
            this.signIn()
          }).catch(err => {
            console.log(err)
            this.signupError = true
      })
    },
    loginWithGoogle() {
      let provider = new firebase.auth.GoogleAuthProvider();
      firebase
          .auth()
          .signInWithPopup(provider)
          .then((result) => {
            let token = result.credential.accessToken;
            localStorage.setItem("token", token)// Token
            localStorage.setItem("uid", result.user.uid)
            this.$emit('signed', true)
          })
          .catch((err) => {
            console.log(err); // This will give you all the information needed to further debug any errors
          });
    }
  }
}
</script>

<style lang="less" scoped>
.login_page {
  #tsparticles {
    position: fixed;
    margin: 0;
    padding: 0;
    left: 0;
    top: 0;
    width: 100%;
    height: 100vh;
  }
  display: flex;
  align-items: center;
  justify-content: center;
  &__content {
    z-index: 1;
    width: 50%;
    height: 50%;
    max-width: 700px;
    max-height: 600px;
    display: flex;
    align-items: center;
    flex-direction: column;
    justify-content: center;
    padding: 30px 40px;
    background: #eeeeee;
    h2 {
      font-size: 28px;
      font-family: Comfortaa;
      text-align: center;
      margin-bottom: 34px;
    }
    .form {
      input {
        margin-bottom: 20px;
      }
      .btn-light {
        background: #eeeeee;
        margin-bottom: 20px;
        &:hover {
          background: #dcdcdc;
        }
      }
      &__actions {
        display: flex;
        width: 100%;
        justify-content: space-between;
        .btn-info {
          background: #a9d2ec;
        }
      }
      .error {
        color: #C60000;
      }
    }
  }
}
</style>