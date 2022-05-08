import text from "@/text/text";
export default {
    inject: {
        lang: {
            from: 'lang',
            default: 'en'
        }
    },
    data() {
        return {
            text
        }
    }
}