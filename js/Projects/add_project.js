document.addEventListener("DOMContentLoaded",()=>{
    
    const $ = id => document.querySelector(id);
    
    let dataProject;
    const data = new Data();
    const sweetAlert = new Alert();
    
    /**
     * FUNCIÓN PARA OBETENR LOS DATOS DEL PROYECTO
     */
    function getData(){
    
        url = `../../Controllers/project.controller.php`;
        data.getData(url,"listProject")
            .then(data =>{
    
                dataProject = data;
            })
            .catch(e =>{
    
                console.error(e);
            })
    };
    
    /**
     * FUCIÓN PARA COMPARAR LA INFORMACIÓN DE LOS INPUTS
     * @param {array} array 
     * @param {string} column 
     * @param {object} param 
     */
    function searchInfo(array, column, param){
    
        if(column == "codigo"){
    
            for(let element of array){
    
    
                if(element[column] == param){
    
                    sweetAlert.sweetWarning("Se ha encontrado coincidencias", `"${param}" ya existe, ingresa otro`);
                    $("#denominacion").setAttribute("readonly",true);
                }else{
                    
                    $("#codigo").removeAttribute("autofocus");
                    $("#denominacion").removeAttribute("readonly");
                    $("#denominacion").focus();
                }
    
                
            }
    
    
        }else if(column = "denominacion"){
    
            for(let element of array){
    
    
                if(element[column] == param){
    
                    sweetAlert.sweetWarning("Se ha encontrado coincidencias", `"${param}" ya existe, ingresa otro`);
                
                }else{

                    $("#denominacion").removeAttribute("autofocus");
                    $("#direccion").removeAttribute("readonly");
                    $("#direccion").focus();
                }
                
            }
    
        }
         
    };
    
    /**
    * FUNCIÓN PARA ENVIAR DATOS (REGISTRAR O ACTUALIZAR)
    */
        function sendData(){

            let perim = data.getJson(".form-control.perim-key",".form-control.perim-value")
            let params = new FormData()
            let url = `../../Controllers/project.controller.php`;

            params.append("action","addProject");
            params.append("imagen",$("#in-image").files[0]);
            params.append("iddireccion",$("#iddireccion").value);
            params.append("codigo",$("#codigo").value);
            params.append("denominacion",$("#denominacion").value);
            params.append("latitud",$("#latitud").value);
            params.append("longitud",$("#longitud").value);
            params.append("perimetro",perim);
            params.append("iddistrito",$("#iddistrito").value);
            params.append("direccion",$("#direccion").value);
    
            data.sendData(url, params)
                .then(result =>{
    
                    if(result.filasAfect > 0){
                        sweetAlert.sweetConfirmAdd("El registro fué exitoso","¿Deseas volver a registrar?",
                        ()=>{
                            $("#form-add-project").reset();
                            $("#form-add-project").classList.remove("was-validated");
    
                        },()=>{
                            window.location.href = "./index_project.php";
                        })
                    }else{
                        sweetAlert.alertError("No se termiado el registro","Vuelve a intentarlo");
                    }
                })
                .catch(e=>{
                    console.error(e);
                })
        }
    
    $("#direccion").addEventListener("keypress",(e)=>{
        
        if(e.keyCode == 13){ //TECLA ENTER

            $("#guardar").removeAttribute("disabled");
        }
    });
    
    $("#denominacion").addEventListener("keypress",(e)=>{

        if(e.keyCode == 13){

            let denominacion = $("#denominacion").value;
    
            if(denominacion != ""){
    
                searchInfo(dataProject,"denominacion",denominacion);
            }
        }
    });
    
    $("#codigo").addEventListener("keypress",(e)=>{
    
        if(e.keyCode == 13){

            let code = $("#codigo").value;
            
            if(code != ""){
    
                searchInfo(dataProject,"codigo",code);
            }
        } 

    });

    
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
                sweetAlert.sweetConfirm("Datos nuevos","¿Desea crear el nuevo registro?",()=>{

                    sendData();
                })
            }

            form.classList.add('was-validated') //=> AGREGA ESTA CLASE A LOS ELEMENTOS DEL FORMULARIO(MUESTRA LOS COMENTARIOS)
            }, false) //=> ESTE TERCER ARGUMENTO INDICA QUE EL EVENTO NO SE ESTA CAPTURANDO EN LA ""FASE DE CAPTURA" SINO EN "PROPAGACIÓN NORMAL"
        })  
    })()
    
    getData();
});


