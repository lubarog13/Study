// Import the functions you need from the SDKs you need
import firebase  from "firebase/app";
import  "firebase/firestore"
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyAzgEdeVSOfaNAT4igi2ninVYtyHCu3A3k",
  authDomain: "fireblogsyt-35bd0.firebaseapp.com",
  projectId: "fireblogsyt-35bd0",
  storageBucket: "fireblogsyt-35bd0.appspot.com",
  messagingSenderId: "1090233041096",
  appId: "1:1090233041096:web:c09ba75682e317bd41e5fd"
};

// Initialize Firebase
const firebaseApp = firebase.initializeApp(firebaseConfig);

const timestamp = firebase.firestore.FieldValue.serverTimestamp;

export {timestamp};

export default firebaseApp.firestore();