#include <cstdlib>
#include <cstring>

#ifdef __EMSCRIPTEN__
    #include <emscripten.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

int ValidateValueProvided(const char* value, const char* error_message, char* return_error_message) {
    if (value == NULL || value[0] == '\0') {
        strcpy(return_error_message, error_message);
        return 0;
    } 
    return 1;
}

#ifdef __EMSCRIPTEN__
    EMSCRIPTEN_KEEPALIVE
#endif

int ValidateName(char* name, int maximum_length, char* return_error_message) {
    if(ValidateValueProvided(name, "Name is required", return_error_message) == 0) {
        return 0;
    }

    if (strlen(name) > maximum_length) {
        strcpy(return_error_message, "Name is too long");
        return 0;
    }
    return 1;
}

int isCategoryIdInArray(char* selected_category_id, int* category_ids, int array_length) {
    int category_id = atoi(selected_category_id);
    for (int i = 0; i < array_length; i++) {
        if(category_ids[i] == category_id) {
            return 1;
        }
    }

    return 0;
}

#ifdef __EMSCRIPTEN__
    EMSCRIPTEN_KEEPALIVE
#endif

int ValidateCategoryId(char* selected_category_id, int* category_ids, int array_length, char* return_error_message) {
    if(ValidateValueProvided(selected_category_id, "Category ID must be selected", return_error_message) == 0) {
        return 0;
    }
    if(category_ids == NULL || array_length == 0) {
        strcpy(return_error_message, "There is no categories available");
        return 0;
    }
    return 1;
}


#ifdef __cplusplus
}
#endif