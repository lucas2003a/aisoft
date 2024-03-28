<?php

require_once "../sidebar/sidebar.php";
?>
    <!--EL CONTENIDO INICIA-->
    <div class="height-100 bg-light">
        <div class="mt-4 bg-white" id="content-py">

            <div class="p-2 header-gradient">
                <h2 class="m-2 text-white"><strong>PROYECTOS</strong></h1>
            </div>

            <div class="content ma-4">
                <!-- CAJA DE BUSQUEDA -->
                <div class="m-4">

                    <h2><strong>REGISTRO</strong></h2>
                    <hr>

                    <div>
                        <form class="row needs-validation" id="fomr-add-project" novalidate>
                            <div class="row">
                                <div class="col-md-6">

                                    <!-- DATOS GENERALES -->
                                    
                                    <!-- DEPARTEMENTO -->
                                    <div class="mt-4">
                                      <label for="iddepartamento" class="form-label">Departamento</label>
                                        <select class="form-select custom-select-scroll" id="iddepartamento" required>
                                            <option selected disabled value="0">Departamento</option>
                                        </select>
                                        <div class="invalid-feedback">
                                            Necesitas escojer un departamento.
                                        </div>
                                        <div class="valid-feedback">
                                            Departamento escojido correctamente.
                                        </div>
                                    </div>
    
                                    <!-- PROVINCIA -->
                                    <div class="mt-4">
                                        <label for="idprovincia" class="form-label">Provincia</label>
                                        <select class="form-select custom-select-scroll" id="idprovincia" required>
                                            <option selected disabled value="0">Provincia</option>
                                        </select>
                                        <div class="invalid-feedback">
                                            Necesitas escojer una provincia.
                                        </div>
                                        <div class="valid-feedback">
                                            Provincia escojida correctamente.
                                        </div>
                                    </div>
    
                                    <!-- DISTRITO -->
                                    <div class="mt-4">
                                        <label for="iddistrito" class="form-label">Distrito</label>
                                        <select class="form-select custom-select-scroll" id="iddistrito" required>
                                            <option selected disabled value="0">Distrito</option>
                                        </select>
                                        <div class="invalid-feedback">
                                            Necesitas escojer un distrito.
                                        </div>
                                        <div class="valid-feedback">
                                            Distrito escojido correctamente.
                                        </div>
                                    </div>

                                    <!-- IDDIRECCIÓN -->
                                    <div class="mt-4">
                                        <label for="iddireccion" class="form-label">Sede</label>
                                        <select class="form-select custom-select-scroll" id="iddireccion" required>
                                            <option selected disabled value="0">Sede</option>                                            
                                        </select>
                                        <div class="invalid-feedback">
                                            Necesitas escojer una sede.
                                        </div>
                                        <div class="valid-feedback">
                                            Sede escojida correctament
                                        </div>
                                    </div>

                                    <!-- CODIGO -->
                                    <div class="mt-4">
                                        <label for="codigo" class="form-label">Código</label>
                                        <input type="text" class="form-control" id="codigo" placeholder="Código" required>
                                        <div class="invalid-feedback">
                                            Necesitas ingresar un código.
                                        </div>
                                        <div class="valid-feedback">
                                            Código registrado correctamente.
                                        </div>
                                    </div>
    
                                    <!-- DENOMINACÓN -->
                                    <div class="mt-4">
                                        <label for="denominacion" class="form-label">Denominación</label>
                                        <input type="text" class="form-control" id="denominacion" placeholder="Denominación" required>
                                        <div class="invalid-feedback">
                                            Necesitas ingresar una denominación.
                                        </div>
                                        <div class="valid-feedback">
                                            Denominación ingresada correctamente.
                                        </div>
                                    </div>
    
                                    <!-- DIRECCIÓN -->
                                    <div class="mt-4">
                                        <label for="direccion" class="form-label">Dirección</label>
                                        <input type="text" class="form-control" id="direccion" placeholder="Dirección" required>
                                        <div class="invalid-feedback">
                                            Necesitas ingresar una dirección.
                                        </div>
                                        <div class="valid-feedback">
                                            Dirección ingresada correctamente.
                                        </div>
                                    </div>
    
    
                                    <!-- IMAGEN -->
                                    <div class="form-group">
                                        <label for="in-image" class="label-img">
                                            <i class="material-icons"></i>
                                            <span class="title">Agregar imagen</span>
                                            <input type="file" accept=".jpg" id="in-image">
                                        </label>
                                    </div>
                                </div>
    
                                <div class="col-md-6">

                                    <!-- UBICACIÓN Y MEDIDAS-->
    
                                    <!-- LATITUD -->
                                    <div class="mt-4">
                                        <label for="latitud" class="form-label">Latitud</label>                                  
                                        <input type="text" class="form-control" id="latitud">
                                        <div class="valid-feedback">
                                            <!-- -- -->
                                        </div>
                                    </div>
        
                                    <!-- LONGITUD -->
                                    <div class="mt-4">
                                        <label for="longitud" class="form-label">Longitud</label>
                                        <input type="text" class="form-control" id="longitud">
                                        <div class="valid-feedback">
                                            <!-- -- -->
                                        </div>
                                    </div>
        
                                    <!-- PERÍMETRO -->                                    
                                    <div class="mt-4" id="perim">
                                        <label for="perimetro" class="form-label">Perímetro (Coordenadas)</label>
                                        <hr>
                                        <div id="patern">
                                            <div class="row">
                                                <div class="col-md-11">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <input type="text" class="form-control perim-key" name="clave" id="clave">
                                                        </div>
                                                        <div class="col-md-6">
                                                            <input type="text" class="form-control perim-value" name="valor" id="valor">
                                                        </div>
                                                    </div>                                               
                                                </div>
                                                <div class="col-md-1">
                                                    <button type="button" class="button-addPlus" id="add-textBox">+</button>
                                                </div>
                                            </div>
                                            <div class="valid-feedback">
                                                <!-- -- -->
                                            </div>
                                        </div>
                                        </div>
                                    <div class="m-4 col-12">
                                        <button class="btn btn-primary" type="submit">Guardar</button>
                                    </div>
                                    
                                </div>                                    

                                
                                <div class="row">
                                    
                                    <!-- COTENEDOR DE IMAGEN -->
                                    <div class="col-md-6">
                                        <!-- <img src="" alt="" id="file-input"> -->
                                        <button type="button" class="btn btn-primary" style="display: none;" id="see-image">Ver imagen</button>
                                    </div>

                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL -->
    <div class="modal-project">
        <div class="modal-form">
            <div class="modal-content">
                <div class="modal-title">
                    <div class="modal-head">
                        <div>
                            <button type="button" class="close" id="close"><strong>X</strong></button>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <img src="" alt="" id="file-input">
                </div>
            </div>
        </div>
    </div>
    <!--EL CONTENIDO TERMINA-->

    <!-- Bootstrap JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
    integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
    crossorigin="anonymous"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
    integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
    crossorigin="anonymous"></script>

    <!-- SWEET ALERT -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- SWEET ALERT CLASS -->
    <script src="../../js/sweetAlert.js"></script>

    <!-- CLASE DATA -->
    <script src="../../js/data.js"></script>
    
    <script src="../../js/sidebar.js"></script>
    <script>

    //INSTANCIA PARA LAS ALERTAS
    const sweetAlert = new Alert();

    //INSTACIA DE LA CASE DATA
    const data = new Data();

    const $ = id => document.querySelector(id);

    let Patern = $("#patern");
    let viewImage = $("#file-input");
    let setData = false;

    /**
     * Función que verifica los campos vacíos
     */
    function checkValues(array){
        let hasValue = false;


        array.forEach(element =>{

            if(element.value != ""){
                console.log(element);
                hasValue = true;

            }else{

                hasValue = false;
                
                //GENERA LA ALERTA
                sweetAlert.sweetError("Campos vacíos","Debes de completa todos los campos");
            }
        });

        return hasValue;
    }

    /**
     * FUNCIÓN PARA CREAR INPUTS
     */
    function renderInputs(){
        
        //BOTÓN "+" Y SU CONTENEDOR
        let buttonPluss = document.createElement("Button");
        buttonPluss.classList.add("button-addPlus","mt-2","active");
        buttonPluss.setAttribute("id","add-textBox");
        buttonPluss.setAttribute("type","button");
        buttonPluss.innerText = "+";

        let contentButton = document.createElement("div");
        contentButton.classList.add("col-md-1");

        contentButton.appendChild(buttonPluss); //=> SE AGREGA AL CONTENEDOR

        // DIV ROW{DIV(COL-MD-11) - DIV(CONTENT BUTTON)}
        let dataPerim = document.createElement("div");
        dataPerim.classList.add("row");


        dataPerim.appendChild(divPatern);
        dataPerim.appendChild(contentButton);

        //CONTENEDOR (LLAVE)
        let containerKey = document.createElement("div");
        containerKey.classList.add("col-md-6","mt-2");
        
        //CAJA DE TEXTO PARA LA CLAVE NUEVA EN EL INPUT
        let newInputKey = document.createElement("input");
        newInputKey.classList.add("form-control","perim-key"); 

        containerKey.appendChild(newInputKey);  //=> SE AGREGA EL INPUT AL CONTENEDOR

        //CONTENDEDOR (VALOR)
        let containerValue = document.createElement("div");
        containerValue.classList.add("col-md-6","mt-2");        
        
        //CAJA DE TEXTO PARA EL NUEVO VALOR EN EL INPUT
        let newInputValue = document.createElement("input");
        newInputValue.classList.add("form-control","perim-value");

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

        Patern.appendChild(dataPerim); //SE AGREGA AL CONTENEDOR PADRE (DEFINIDO AL INICIO)

    }

    /**
     * FUNCIÓN QUE REEMPLAZA AL BOTON "+" POR "-"
     */
    function replaceButton(event){

        if(event.target.classList.contains("button-addPlus")){
            event.target.classList.remove("button-addPlus");

            event.target.classList.add("button-less");
            event.target.innerText = "-";
        }
    }

    /**
     * FUNCIÓN PARA ELIMINAR INPUTS
     */
    function dropInputs(event){

        let row = event.target.closest(".row"); //=> OTBTIENE EL CONTEDOR ANCESTRO MÁS PRÓXIMO

        row.remove();   //=> LO ELIMINA
    }

    /**
     * FUNCION PARA LEER LA IMAGEN
     */
    function readFile(event){

        const file = event.target.files[0];
        const reader = new FileReader();

        reader.onload = (event)=>{

            //ESTABLECE LA RUTA DE LA IMAGEN (RUTA TEMPORAL)
            viewImage.setAttribute("src",`${event.target.result}`);
            viewImage.style.width = "100%";
            viewImage.style.height = "20rem";

        };

        reader.readAsDataURL(file);
    }

    /**
     * FUNCÓN PARA RENDERIZAR LOS DEPARTAMENTOS
     */
    function renderDepartaments(){

        data.getDepartaments()
        .then(
            departamens=>{
                    departamens.forEach(departamen=>{
                        
                        let newOption = document.createElement("option");
                        newOption.value = departamen.iddepartamento; 
                        newOption.innerText = departamen.departamento;
                        
                        $("#iddepartamento").appendChild(newOption);
                    });
                }
            )
    }
    
    /**
     * FUNCÓN PARA RENDERIZAR LAS PROVINCIAS
     */
    function renderProvinces(){

        let idDepartamento = $("#iddepartamento").value;

        data.getProvinces(idDepartamento)
            .then(
                provinces =>{

                    provinces.forEach(province =>{
                        let newOption = document.createElement("option");
                        newOption.value = province.idprovincia; 
                        newOption.innerText = province.provincia;
                        
                        $("#idprovincia").appendChild(newOption);
                    });
                }
            )
            .catch(e=>{
                console.error(e);
            })
    };

     /**
     * FUNCIÓN PARA RENDERIZAR LOS DISTRITOS
     */
    function renderDistricts(){

        let idProvincia = $("#idprovincia").value;

        data.getDistricts(idProvincia)
            .then(
                districts =>{

                    districts.forEach(district =>{
                        let newOption = document.createElement("option");
                        newOption.value = district.iddistrito; 
                        newOption.innerText = district.distrito;
                        
                        $("#iddistrito").appendChild(newOption);
                    });
                }
            )
            .catch(e=>{
                console.error(e);
            })
    };

    /**
     * FUNCIÓN PARA RENDERIZAR LAS SEDES
     */
    function renderSedes(){

        let idDistrito = $("#iddistrito").value;

        data.getSede(idDistrito)
            .then(
                addresses =>{
                    addresses.forEach(address=>{
                        console.log(address)
                        let newOption = document.createElement("option");
                        newOption.value = address.iddireccion;
                        newOption.innerText = address.direccion;

                        $("#iddireccion").appendChild(newOption);
                    });
                }
            ).catch(e=>{
                console.error(e);
            })
    };

    /**
     * FUNCIÓN PARA RESETEAR LOS INPUTS
     */
    function resetSelect(id,text, callback){
        
        $(id).innerHTML = "";

        const defaultOption = document.createElement("option");
        defaultOption.value = 0; 
        defaultOption.innerText = text;
        
        $(id).appendChild(defaultOption);

        callback();
    }

    function sendData(){

        let params = new FormData()
        let idproyecto = 0;
        if(setData){
            params.append("action","setProject");
            params.append("idproyecto",idproyecto);
        }else{
            params.append("action","addProject");
        }

        params.append("imagen",$("#in-image").files[0]);
        params.append("iddireccion",$("#iddireccion"));
        params.append("codigo",$("#codigo"));
        params.append("denominacion",$("#denominacion"));
        params.append("latitud",$("#latitud"));
        params.append("longitud",$("#logitud"));
        /* params.append("perimetro",$("#")); */
        params.append("iddistrito",$("#iddistrito"));
        params.append("direccion",$("#direccion"));

        data.sendData(params)
            .then(result =>{
                console.log(result);
                /* if(senData.filasAfect > 0){

                } */
            })
            .catch()
    }

    $("#iddistrito").addEventListener("change",()=>{

        resetSelect("#iddireccion","Sedes",renderSedes);
    });

    $("#idprovincia").addEventListener("change",()=>{
        
        resetSelect("#iddistrito","Distritos",renderDistricts);
    });

    $("#iddepartamento").addEventListener("change",()=>{
        
        resetSelect("#idprovincia","Provincias",renderProvinces);
    });

    $("#in-image").addEventListener("change",(e)=>{

        console.log(e);
        if(e.target.files.length > 0){
            
            console.log(e);
            readFile(e);
            $("#see-image").setAttribute("style","display: show;");
        }else{
            
        }
    });

    $("#see-image").addEventListener("click",()=>{

        $(".modal-form").classList.add("show");

    });
    
    $("#close").addEventListener("click", ()=>{

        $(".modal-form").classList.remove("show");

    });

    $("#perim").addEventListener("click",(e)=>{

        console.log(sweetAlert);

        if(e.target.classList.contains("button-addPlus")){

            let perimData = false;
            
            //ITERACIÓN POR CADA INPUT (CLAVE)
            let perimDataKey = document.querySelectorAll(".form-control.perim-key");
            let dataKey = Array.from(perimDataKey);
            console.log(dataKey.length);
            let returnKey = checkValues(dataKey); 
    
            //ITERACIÓN POR CADA INPUT (CLAVE)
            let perimDataValue = document.querySelectorAll(".form-control.perim-value");
            let dataValue = Array.from(perimDataValue);
            let returnValue = checkValues(dataValue);
    
            if(returnKey && returnValue){
                renderInputs();
                console.log(e);
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

    renderDepartaments();

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

                sendData();
            }

            form.classList.add('was-validated') //=> AGREGA ESTA CLASE A LOS ELEMENTOS DEL FORMULARIO(MUESTRA LOS COMENTARIOS)
            }, false) //=> ESTE TERCER ARGUMENTO INDICA QUE EL EVENTO NO SE ESTA CAPTURANDO EN LA ""FASE DE CAPTURA" SINO EN "PROPAGACIÓN NORMAL"
        })
    })()


    </script>