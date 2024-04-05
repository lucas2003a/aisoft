document.addEventListener("DOMContentLoaded",()=>{

const $ = id => document.querySelector(id);

//OBTIENE EL ID DEL URL
const stringQuery = window.location.search;

const url = new URLSearchParams(stringQuery);

const code = url.get("id");

const idProyecto = atob(code);

//INSTANCIA A LA CLASE DATA
const data = new Data();

const sweetAlert = new Alert();

let Patern = $("#patern");

let oldImage;


function renderInputs(keyValue, valValue){
    
    //BOTÓN "-" Y SU CONTENEDOR
    let buttonLess = document.createElement("Button");
    buttonLess.classList.add("button-less","mt-2","active");
    buttonLess.setAttribute("id","add-textBox");
    buttonLess.setAttribute("type","button");
    buttonLess.innerText = "-";

    let contentButton = document.createElement("div");
    contentButton.classList.add("col-md-1");

    contentButton.appendChild(buttonLess); //=> SE AGREGA AL CONTENEDOR

    // DIV ROW{DIV(COL-MD-11) - DIV(CONTENT BUTTON)}
    let dataPerim = document.createElement("div");
    dataPerim.classList.add("row");

    //CONTENEDOR (LLAVE)
    let containerKey = document.createElement("div");
    containerKey.classList.add("col-md-6","mt-2");
    
    //CAJA DE TEXTO PARA LA CLAVE NUEVA EN EL INPUT
    let newInputKey = document.createElement("input");
    newInputKey.classList.add("form-control","perim-key"); 
    newInputKey.value = keyValue;                           //=> SE LE ASIGNA VALOR OBTENIDO

    containerKey.appendChild(newInputKey);  //=> SE AGREGA EL INPUT AL CONTENEDOR

    //CONTENDEDOR (VALOR)
    let containerValue = document.createElement("div");
    containerValue.classList.add("col-md-6","mt-2");        
    
    //CAJA DE TEXTO PARA EL NUEVO VALOR EN EL INPUT
    let newInputValue = document.createElement("input");
    newInputValue.classList.add("form-control","perim-value");
    newInputValue.value = valValue;                          //=> SE LE ASIGNA VALOR OBTENIDO

    containerValue.appendChild(newInputValue);  //=> SE AGREGA EL INPUT AL CONTENEDOR

    //ROW (CONTIENE A LOS CONTENEDORES DE LLAVES Y VALORES)
    let row = document.createElement("div");
    row.classList.add("row");

    row.appendChild(containerKey);
    row.appendChild(containerValue);

    //CONTENEDOR PADRE
    let divPatern = document.createElement("div");
    divPatern.classList.add("col-md-11");                   
 
    divPatern.appendChild(row); //SE AGREAGA EL ROW DE CONTENEDORES AL ULTIMO DIV

    dataPerim.appendChild(divPatern);
    dataPerim.appendChild(contentButton);

    let firstIntputs = Patern.firstChild; //=> OBTIENE EL PRIMER NODO(ELEMENTO) DEL CONTENEDOR EN LA VARIABLE PATERN

    Patern.insertBefore(dataPerim, firstIntputs); //AGREGA DATEPERIM ANTES DEL PRIMER ELEMENTO EN PATERN

};

function getDataId(id){

    let url = "../../Controllers/project.controller.php";

    let params = new FormData();
    
    params.append("action","listProjectId");
    params.append("idproyecto",id);

    data.sendAction(url, params)
        .then(project => {

            console.log(project);
            const perimetro = JSON.parse(project.perimetro);

            const keys = perimetro.clave;
            const values = perimetro.valor;

            oldImage = project.imagen;

            $("#codigo").value = project.codigo;
            $("#denominacion").value = project.denominacion;
            $("#direccion").value = project.direccion;
            $("#latitud").value = project.latitud;
            $("#longitud").value = project.longitud;

            keys.forEach((key, index) => {
                const value = values[index];

                if(key != ""|| value != ""){

                    renderInputs(key,value);
                }
            });



        })
        .catch(e => {
            console.error(e);
        });

};

function setData(){

    let perim = data.getJson(".form-control.perim-key",".form-control.perim-value")
    let url = `../../Controllers/project.controller.php`;
    let params = new FormData();

    let img = $("#in-image").files[0] ? $("#in-image").files[0] : oldImage;

    params.append("action","setProject");
    params.append("idproyecto",idProyecto);
    params.append("imagen",img);
    params.append("iddireccion",$("#iddireccion").value);
    params.append("codigo",$("#codigo").value);
    params.append("denominacion",$("#denominacion").value);
    params.append("latitud",$("#latitud").value);
    params.append("longitud",$("#longitud").value);
    params.append("perimetro",perim);
    params.append("iddistrito",$("#iddistrito").value);
    params.append("direccion",$("#direccion").value);

    data.sendData(url, params)
        .then(result => {

            console.log(result);
            if(result.filasAfect > 0){

                sweetAlert.sweetSuccess("Registro actualizado","El registro se ha actualizado correctamente",()=>{

                    window.location.href = "./index_project.php";
                });
            }else{
                sweetAlert.alertError("No se actualizó el registro","Vuelve a intentarlo");
            }
        })
        .catch(e =>{
            console.error(e);
        })
};

// FUNCIÓN DE BOOTSTRAP PARA LAVALIDACIÓN

//ESTA EESTRUCTUARA INDICA AL NAVEGADOR QUE CUANDO LEA ESTA FUNCION, LA EJECUTE INMEDIATAMENTE
(() => {
    'use strict' //=> USO ESTRICTO POR POLITICAS DE SEGURIDAD EN EL FORMULARIO

     //SELECCIONA TODOS LOS ELEMENTOS DEL FORMULARIO QUE TIENE LA CLASE "needs-validation
    const forms = document.querySelectorAll('.needs-validation')

    // TOMA EL ELEMENTO "FORMS" Y LO CONVIERTE A UN ARRAY
    // SE INCLUYE EN UN FOREAH PARA ITERAR SOBRE SUS ELEMENTOS

    Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {

            //SI LA VALIDACIÓN DEL FORMULARIO ES FALSE
            if (!form.checkValidity()) {
            event.preventDefault()      //=> FRENA EL ENVÍO DEL FORMULARIO
            event.stopPropagation()     //=> FRENA LA PROPAGACIÓN DE DATOS EN EL FORMULARIO
        }else{
            event.preventDefault();
            sweetAlert.sweetConfirm("Datos nuevos","¿Deseas actualizar el registro?",()=>{
                
                setData();
            });
        }

        form.classList.add('was-validated') //=> AGREGA ESTA CLASE A LOS ELEMENTOS DEL FORMULARIO(MUESTRA LOS COMENTARIOS)
        }, false) //=> ESTE TERCER ARGUMENTO INDICA QUE EL EVENTO NO SE ESTA CAPTURANDO EN LA ""FASE DE CAPTURA" SINO EN "PROPAGACIÓN NORMAL"
    })  
})();
getDataId(idProyecto);

});
