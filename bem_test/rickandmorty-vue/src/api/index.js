import axios from "axios";

const axiousInstance = axios.create({
    baseURL: "https://rickandmortyapi.com/api/"
});

export default axiousInstance