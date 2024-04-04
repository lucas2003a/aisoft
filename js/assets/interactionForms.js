document.addEventListener("DOMContentLoaded",()=>{

/* INSTANCIAS */
const sweetAlert = new Alert();
const data = new Data();

const $ = id => document.querySelector(id);
const $All = id => document.querySelectorAll(id);
/* TABLINKS */
const btnDGeneral = $("#btn-DGeneral");
const btnDescription = $("#btn-description");
const viewImage = $("#view-image");
const viewImageDesc = $("#view-image-descrip");

/* TABCONTENT */
const contentDGeneral = $("#DGeneral");
const contentDescription = $("#Description");

function renderInputs(){
    
       /*INPUT KEY */
        let inputKey = document.createElement("input");
        inputKey.classList.add("form-control","perim-key")

        /* INPUT VALUE */
        let inputValue = document.createElement("input");
        inputValue.classList.add("form-control","perim-key");        

        /* DIV KEY */
        let divKey = document.createElement("div");
        divKey.classList.add("col-md-6");

        /* DIV VALUE */
        let divValue = document.createElement("div");
        divValue.classList.add("col-md-6");

        divKey.appendChild(inputKey);
        divValue.appendChild(inputValue);

        
        let rowInputs = document.createElement("div");
        rowInputs.classList.add("row","mt.2");
        
        rowInputs.appendChild(divKey);
        rowInputs.appendChild(divValue);

        let divInputs = document.createElement("div");
        divInputs.classList.add("col-md-11","mt-2");

        divInputs.appendChild(rowInputs);

        /* -------------------------------------------------- */

        /* BOTÓN "+" */
        let buttonPluss = document.createElement("button");
        buttonPluss.classList.add("button-addPlus","mt-2","active");
        buttonPluss.setAttribute("id","add-textBox");
        buttonPluss.setAttribute("type","button");
        buttonPluss.innerText = "+";
        
        let divButton = document.createElement("div");
        divButton.classList.add("col-md-1");

        divButton.appendChild(buttonPluss);

        /* -------------------------------------------------- */

        let rowMaster = document.createElement("div");
        rowMaster.classList.add("row");

        rowMaster.appendChild(divInputs);
        rowMaster.appendChild(divButton);

        let firstRow = $("#perimetro-asset").firsChild;
        $("#perimetro-asset").insertBefore(rowMaster,firstRow);

};

/**
 * FUNCIÓN PARA MOSTRAR EL CONTENIDO DEL NAVBAR
 */
function openTab(page, btn){

    let tabContent = $All(".tabcontent");

    for(i=0; i < tabContent.length; i++){

        tabContent[i].style.display = "none";
    }

    let tablink = $All(".tablink");
    
    for(i = 0; i < tablink.length; i++){

        tablink[i].classList.remove("active");
    }

    $(page).style.display = "block";
    btn.classList.add("active");
}

function checkValues(array){

    let hasValue = false;

    array.forEach(element => {

        if(element.value != ""){

            hasValue = true;

        }else{
            hasValue = false;
            sweetAlert.sweetError("Campos vacíos","Debes de completa todos los campos");
        }
    });

    return hasValue;
}

function replaceButton(event){

    if(event.target.classList.contains("button-addPlus")){

        event.target.classList.remove("button-addPlus");

        event.target.classList.add("button-less");
        event.target.innerText = "-";
    }
}

function dropInputs(event){

    let row = event.target.closest(".row"); //=> OTBTIENE EL CONTEDOR ANCESTRO MÁS PRÓXIMO

    row.remove();   //=> LO ELIMINA
}

/**
 * FUNCIÓN PARA VALDAR UN FORMULARIO
*/
function validateForm(id, callback){
    'use strict'

    const form = $(id);

        form.addEventListener('submit', event => {
            
               if (!form.checkValidity()) {
                event.preventDefault()      //=> FRENA EL ENVÍO DEL FORMULARIO
                event.stopPropagation()     //=> FRENA LA PROPAGACIÓN DE DATOS EN EL FORMULARIO
            }else{

                if(form.checkValidity()){
                        
                    event.preventDefault();
                    callback();
                }
        }

        form.classList.add('was-validated') //=> AGREGA ESTA CLASE A LOS ELEMENTOS DEL FORMULARIO(MUESTRA LOS COMENTARIOS)
        }, false) //=> ESTE TERCER ARGUMENTO INDICA QUE EL EVENTO NO SE ESTA CAPTURANDO EN LA ""FASE DE CAPTURA" SINO EN "PROPAGACIÓN NORMAL"
         
}

/**
* FUNCIÓN PARA LEER UNA IMAGEN
*/
function readFile(event){

    const file = event.target.files[0];
    const reader = new FileReader();

    reader.onload = (event)=>{

        viewImage.setAttribute("src",`${event.target.result}`);
        viewImage.style.width = "100%";
        viewImage.style.height = "20rem";
    }

    reader.readAsDataURL(file);
}

$("#in-image").addEventListener("change",(e)=>{

    console.log(e)
    readFile(e);
});

$("#form-asset-gen").addEventListener("submit",(e)=>{
    let id = "#form-asset-gen"

    e.preventDefault();
    validateForm(id,()=>{
        btnDescription.removeAttribute("disabled");
        btnDescription.click();
    });
})

$("#perimetro-asset").addEventListener("click",(e)=>{

    if(e.target.classList.contains("button-addPlus")){

        //ITERACIONES
        const classQueryKey = $All(".form-control.perim-key");
        const arrayKey = Array.from(classQueryKey);
        const returnKey = checkValues(arrayKey);

        const classQueryVal = $All(".form-control.perim-key");
        const arrayValue = Array.from(classQueryVal);
        const returnValue = checkValues(arrayValue);

        if(returnKey && returnValue){
            renderInputs();
            replaceButton(e);

            
        }

    }else if(e.target.classList.contains("button-less")){
    
        let ask = "¿Seguro de borrar los atributos?";
        let alert = "No se podrán recuperar una vez ejecutado";
    
        sweetAlert.sweetConfirm(ask,alert,()=>{
            dropInputs(e);
        });
    }
    });

    btnDGeneral.addEventListener("click",function(){
        openTab("#DGeneral", this);
    });
    
    btnDescription.addEventListener("click",function(){
        openTab("#Description", this);
    });

    btnDGeneral.click();


});