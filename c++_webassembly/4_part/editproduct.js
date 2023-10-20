const initialData = {
    name: "Woman Mid Rise Skinny Jeans",
    categoryId: "100"
}

const MAXIMUM_NAME_LENGTH = 50;
const VALID_CATEGORY_IDS = [100, 101];

function initializePage() {
    document.getElementById("name").value = initialData.name;
    const category = document.getElementById("category");
    const count = category.length;
    for (let i = 0; i < count; i++) {
        if(category[i].value === initialData.categoryId) {
            category.selectedIndex = i;
            break;
        }
    }
}

function getSelectedCategoryId() {
    const category = document.getElementById("category");
    const index = category.selectedIndex;
    if(index !==-1) { return category[index].value;}
    return "0";
}

function setErrorMessage(message) {
    let errorMessage = document.getElementById("errorMessage")
    errorMessage.innerHTML = message;
    errorMessage.style.display = (message === ""? "none" : "block");
}

function validateName(name, errorMessagePointer) {
    const isValid = Module.ccall('ValidateName', 'number', ['string', 'number', 'number'], [name, MAXIMUM_NAME_LENGTH, errorMessagePointer]);
    return isValid === 1;
}

function validateCategoryId(categoryId, errorMessagePointer) {
    const arrayLength = VALID_CATEGORY_IDS.length;
    const bytesPerElement = Module.HEAP32.BYTES_PER_ELEMENT;
    const arrayPointer = Module._malloc(arrayLength * bytesPerElement);
    Module.HEAP32.set(VALID_CATEGORY_IDS, arrayPointer / bytesPerElement);
    const isValid = Module.ccall('ValidateCategoryId', 'number', ['string', 'number', 'number', 'number'], [categoryId, arrayPointer, arrayLength, errorMessagePointer]);
    Module._free(arrayPointer);
    return isValid === 1;
}

function onClickSave() {
    let errorMessage = "";
    const errorMessagePointer = Module._malloc(256);
    const name = document.getElementById("name").value;
    const categoryId = getSelectedCategoryId();
    if(!validateName(name, errorMessagePointer) || !validateCategoryId(categoryId, errorMessagePointer)) {
        errorMessage = Module.UTF8ToString(errorMessagePointer);
    }

    Module._free(errorMessagePointer);

    setErrorMessage(errorMessage);
    if(errorMessage === "") {
    }
}
