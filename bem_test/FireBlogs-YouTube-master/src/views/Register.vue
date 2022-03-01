<template>
    <div class="form-wrap">
        <form class="register">
            <p class="login-register">
                Already have an account?
                <router-link class="router-link" :to="{name: 'Login'}">
                Login
                </router-link>                
            </p>
            <h2>Create Your FireBlog Account</h2>
            <div class="inputs">
                <div class="input">
                    <input type="text" placeholder="First Name" v-model="firstName" >
                    <user class="icon"></user>
                </div>
                <div class="input">
                    <input type="text" placeholder="Last Name" v-model="lastName" >
                    <user class="icon"></user>
                </div>
                <div class="input">
                    <input type="email" placeholder="Email" v-model="email" >
                    <email class="icon"></email>
                </div>
                <div class="input">
                    <input type="text" placeholder="Username" v-model="username" >
                    <user class="icon"></user>
                </div>
                <div class="input">
                    <input type="password" placeholder="Password" v-model="password" >
                    <password class="icon"></password>
                </div>
                <div v-show="error" class="error">{{errMsg}}</div>
            </div>
            <button @click.prevent="register">Sign Up</button>
            <div class="angle"></div>
        </form>
        <div class="background"></div>
    </div>
</template>

<script>
import email from "../assets/Icons/envelope-regular.svg";
import password from "../assets/Icons/lock-alt-solid.svg";
import user from "../assets/Icons/user-alt-light.svg";
import firebase from "firebase/app"
import "firebase/auth";
import db from "../firebase/firebaseInit";

    export default {
        name: "Register",
        components: {
            email,
            password,
            user
        },
        data() {
            return {
                firstName: "",
                lastName: "",
                email: "",
                username: "",
                password: "",
                error: null,
                errMsg: ""
            }
        },
        methods: {
            async register() {
                if(this.email !== "" &&
                    this.firstName !== "" &&
                    this.lastName !== "" &&
                    this.username !== "" &&
                    this.password !== ""
                ) {
                    this.error = false
                    this.errMsg = ""
                    const firebaseAuth = await firebase.auth();
                    const createUser = await firebaseAuth.createUserWithEmailAndPassword(this.email, this.password);
                    const result = await createUser;
                    const dataBase = db.collection("users").doc(result.user.uid);
                    await dataBase.set({
                        firstName: this.firstName,
                        lastName: this.lastName,
                        username: this.username,
                        email: this.email
                    }
                    );
                    this.$router.push({name: "Home"})
                    return;
                }
                this.error = true
                this.errMsg = "Please fill out the fields!"
                return
            }
        }
    }
</script>

<style lang="less" scoped>
    .register {
        h2{
            max-width: 350px;
        }
    }
</style>