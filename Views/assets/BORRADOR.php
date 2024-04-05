<?php

require_once "../sidebar/sidebar.php"
?>
    <!--EL CONTENIDO INICIA-->
    <div class="height-100 bg-light">
        <div class="m-4 bg-white">

            <div class="p-2 header-gradient">
                <h2 class="m-2 text-white"><strong id="cabezera">LOTES - </strong></h1>
            </div>

            <div class="content ma-4">
                <div class="mt-4">

                    <div class="row">
                        <!-- BOTNES DEL NAVBAR -->
                        <div class="btn-group">

                            <div class="col-md-6">
    
                                <button class="tablink active" id="btn-DGeneral">Datos Generales</button>
                            </div>
                            <div class="col-md-6">
    
                                <button class="tablink" id="btn-description" disabled>Descripción</button>
                            </div>
                        </div>
                        
                    </div>

                    <div id="DGeneral" class="tabcontent" style="display: block;">
                    <form class="row needs-validation" id="form-client" novalidate>
                                
                                <!-- CLIENTE PRINCIPAL -->

                                <h4>CLIENTE</h4>
                                <div class="row">
                                    <div class="col-md-6">
                                        
                                        <!-- DOCUMENTO TIPO -->
                                        <div class="mt-4">
                                            <label for="documento_tipo" class="form-label">Tipo de documento</label>
                                            <select class="form-select custom-select-scroll" id="documento_tipo" required>
                                                <option selected disabled value="">Tipo de documento</option>                                            
                                                <option disabled value="DNI">DNI</option>                                            
                                                <option disabled value="Carnet de extranjería">Carnet de extranjería</option>                                            
                                            </select>
                                            <div class="invalid-feedback">
                                                Necesitas escojer un tipo de documento.
                                            </div>
                                            <div class="valid-feedback">
                                                Tipo de documento escojido correctamente.
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        
                                        <!-- DOCUMENTO NÚMERO -->
                                        
                                        <div class="mt-4">
                                            <label for="documento_nro" class="form-label">Nº de documento</label>
                                            <div class="input-group">
                                                <input type="text" class="form-control" id="documento_nro" placeholder="Nº de documento" required autofocus>
                                                <button type="button" class="btn btn-primary btn-sm">Buscar</button>
                                            </div>
                                            <div class="invalid-feedback">
                                                Necesitas ingresar un nº de documento.
                                            </div>
                                            <div class="valid-feedback">
                                                Nº de documento registrado correctamente.
                                            </div>                                                    
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        
                                        <!-- ESTADO CIVIL -->
                                        <div class="mt-4">
                                            <label for="estado_civil" class="form-label">Estado civil</label>
                                            <select class="form-select custom-select-scroll" id="estado_civil" required>
                                                <option selected disabled value="">Estado civil</option>                                            
                                                <option disabled value="">Soltero</option>                                            
                                                <option disabled value="">Estado civil</option>                                            
                                            </select>
                                            <div class="invalid-feedback">
                                                Necesitas escojer el estado civil.
                                            </div>
                                            <div class="valid-feedback">
                                                Estado civil escojido correctamente.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        
                                        <!-- DIRECCIÓN -->
                                        <div class="mt-4 mb-4">
                                            <label for="direccion" class="form-label">Dirección</label>
                                            <input type="text" class="form-control" id="direccion" placeholder="Dirección" required>
                                            <div class="invalid-feedback">
                                                Necesitas ingresar una dirección.
                                            </div>
                                            <div class="valid-feedback">
                                                Dirección ingresada correctamente.
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        
                                        <!-- NOMBRES -->
                                        <div class="mt-4">
                                            <label for="nombres" class="form-label">Nombres</label>
                                            <input type="text" class="form-control" id="nombres" placeholder="Nombres" required>
                                            <div class="invalid-feedback">
                                                Necesitas ingresar los nombres.
                                            </div>
                                            <div class="valid-feedback">
                                                Nombres ingresados correctamente.
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-md-6">
                                        
                                        <!-- APELLIDOS -->
                                        <div class="mt-4">
                                            <label for="apellidos" class="form-label">Apellidos</label>
                                            <input type="text" class="form-control" id="apellidos" placeholder="Apellidos" required>
                                            <div class="invalid-feedback">
                                                Necesitas ingresar los apellidos.
                                            </div>
                                            <div class="valid-feedback">
                                                Apellidos ingresados correctamente.
                                            </div>
                                        </div>
                                    </div>
                                </div>



                                <!-- DEPARTEMENTO -->
                                <div class="mt-4">
                                  <label for="iddepartamento" class="form-label">Departamento</label>
                                    <select class="form-select custom-select-scroll" id="iddepartamento" required>
                                        <option selected disabled value="">Departamento</option>
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
                                        <option selected disabled value="">Provincia</option>
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
                                        <option selected disabled value="">Distrito</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Necesitas escojer un distrito.
                                    </div>
                                    <div class="valid-feedback">
                                        Distrito escojido correctamente.
                                    </div>
                                </div>
                            </form>
                    </div>

                    <div id="Description" class="tabcontent">
                        <div>
                            <form class="row needs-validation" id="form-asset-desc" novalidate>
                            <div class="row">
                                <div class="col-md-6">

                                    <!-- DESCRPCIÓN -->
                                    
                                    <!-- ÁREA -->
                                    <div>
                                      <label for="area" class="form-label">Área (m2)</label>
                                        <input type="number" class="form-control" id="area" min="0" value="000.00" placeholder="Àrea (m2)" required>

                                    </div>

                                    <!-- ZONAS COMUNES -->
                                    <div class="mt-4">
                                      <label for="z-comunes" class="form-label">Zonas comunes (%)</label>
                                        <input type="number" class="form-control" id="z-comunes" min="0" max="100" placeholder="Zonas comúnes (%)" required>

                                    </div>

    
                                    <!-- MONEDA VENTA -->
                                    <div class="mt-4">
                                      <label for="moneda-venta" class="form-label">Moneda de venta</label>
                                        <select class="form-control custom-select-scroll" id="moneda-venta" required>
                                            <option value="">Tipo moneda</option>
                                            <option value="USD">Dólares</option>
                                            <option value="SOL">Soles</option>
                                        </select>

                                    </div>
    
                                    
                                    <!-- PRECIO VENTA -->
                                    <div class="mt-4">
                                        <label for="precio-venta" class="form-label">Precio de venta</label>
                                        <input type="number" class="form-control" id="precio-venta" placeholder="Precio venta" value="000000.00" required autofocus>
                                        <div class="invalid-feedback">
                                            Necesitas ingresar un código.
                                        </div>
                                        <div class="valid-feedback">
                                            Código registrado correctamente.
                                        </div>
                                    </div>
    
                                    <!-- SUBLOTE -->
                                    <div class="mt-4">
                                        <label for="partida-elect" class="form-label">Partida electrónica</label>
                                        
                                        <textarea name="partida-elect" class="form-control" id="partida-elect" cols="38" rows="3" required></textarea>
                                        <div class="invalid-feedback">
                                            Necesitas ingresar la partida electrónica.
                                        </div>
                                        <div class="valid-feedback">
                                        Partida electrónica registrada correctamente.
                                        </div>
                                    </div>

                                    
                                </div>
                                
                                
                                <div class="col-md-6">
                                    
                                    <!-- LATITUD -->
                                    <div class="mt-4">
                                        <label for="latitud" class="form-label">Latitud</label>
                                        
                                        <input type="text" name="partida-elect" class="form-control" id="latitud" placeholder="Latitud">
                                        <div class="invalid-feedback">
                                            Necesitas ingresar la latitud.
                                        </div>
                                        <div class="valid-feedback">
                                            Latitud registrada correctamente.
                                        </div>
                                    </div>
    
                                    <!-- LONGITUD -->
                                    <div class="mt-4">
                                        <label for="longitud" class="form-label">Longitud</label>
                                        
                                        <input type="text" name="longitud" class="form-control" id="longitud" placeholder="Longitud">
                                        <div class="invalid-feedback">
                                            Necesitas ingresar la longitud.
                                        </div>
                                        <div class="valid-feedback">
                                            Longitud registrada correctamente.
                                        </div>
                                    </div>
                                    <!-- PERIMTETRO -->
                                    <label for="longitud" class="form-label">Perímetro</label>
                                    <div id="perimetro-asset">
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
                                    </div>                                    
                                </div>
                            </div>                                                                 
                                                        
                            <div style="display: flex; justify-content: center; margin: 1rem;">
                        
                                <button class="btn btn-primary btn-lg" type="submit" id="guardar">guardar</button>
                            </div>
                        </form>
                        </div>
                        
                    </div>
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

    <!-- CHART JS -->

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- CLASE DATA -->
    <script src="../../js/data.js"></script>

    <!-- CLASE ALERT -->
    <script src="../../js/sweetAlert.js"></script>

    <!-- SIDEBAR -->
    <script src="../../js/sidebar.js"></script>
    <script src="../../js/assets/interactionForms.js"></script>
    <script>
document.addEventListener("DOMContentLoaded",()=>{

    /* INSTANCIAS */
    const sweetAlert = new Alert();
    const data = new Data();

    const $ = id => document.querySelector(id);
    const $All = id => document.querySelectorAll(id);

    /**URL*/
    const stringQuery = window.location.search;
    const params = new URLSearchParams(stringQuery);
    const code = params.get("id");
    const idProyecto = atob(code);

    let dataAssets;
    let oldImage;
    let dataProject;

    /**
     * FUNCIÓN PARA OBTENER LA DATA DE LOS ACTIVOS POR IDPROYECTO
     */
    function getAssets(id){

        let url ="../../Controllers/asset.controller.php";
        let params = new FormData();

        params.append("action","listAssetProjectId");
        params.append("idproyecto",id);

        data.sendAction(url,params)
            .then(assets => {
                
                dataAssets = assets;
                console.log(dataAssets);
            })
            .catch(e => {
                console.error(e);
            });
    }

    function getProject(id){

        let url = "../../Controllers/project.controller.php";

        let params = new FormData();

        params.append("action","listProjectId");
        params.append("idproyecto",id);

        data.sendAction(url, params)
            .then(project => {

                dataProject = project;

                $("#cabezera").innerHTML += project.codigo;
                $("#ubigeo").value = `${project.distrito} - ${project.provincia} - ${project.departamento}`;
    
        })
        .catch(e => {
            console.error(e);
        });

    }

    /**
     * FUNCIÓN PARA COMPARAR INFORMACIÓN
     */
    function searchInfo(array, column, param){
    
        if(column == "codigo"){
    
            for(let element of array){
    
    
                if(element[column] == param){
    
                    sweetAlert.sweetWarning("Se ha encontrado coincidencias", `"${param}" ya existe, ingresa otro`);
                    $("#sublote").setAttribute("readonly",true);
                }else{
                    
                    $("#codigo").removeAttribute("autofocus");
                    $("#sublote").removeAttribute("readonly");
                    $("#sublote").focus();
                }
    
                
            }
    
    
        }else if(column = "sublote"){
    
            for(let element of array){
    
    
                if(element[column] == param){
    
                    sweetAlert.sweetWarning("Se ha encontrado coincidencias", `"${param}" ya existe, ingresa otro`);
                    $("#direccion").setAttribute("readonly",true);
                }else{

                    $("#sublote").removeAttribute("autofocus");
                    $("#direccion").removeAttribute("readonly");
                    $("#direccion").focus();
                }
                
            }
    
        }
         
    };


    /**
     * FUNCIÓN PARA ENVIAR TODOS LOS DATOS DE LOS FORMUALARIOS
     */
    function sendDataForm(id, callback){
        'use strict'

        const form = $(id);

            form.addEventListener('submit', event => {
            
                if (!form.checkValidity()) {
                    event.preventDefault()      //=> FRENA EL ENVÍO DEL FORMULARIO
                    event.stopPropagation()     //=> FRENA LA PROPAGACIÓN DE DATOS EN EL FORMULARIO
                }else{

                    if(form.checkValidity()){
                        
                        event.preventDefault();
                        sweetAlert.sweetConfirm("Datos nuevos","¿Deseas actualizar el registro?",()=>{
                            callback();
                            
                        }); 
                    }
            }

            form.classList.add('was-validated') //=> AGREGA ESTA CLASE A LOS ELEMENTOS DEL FORMULARIO(MUESTRA LOS COMENTARIOS)
            }, false) //=> ESTE TERCER ARGUMENTO INDICA QUE EL EVENTO NO SE ESTA CAPTURANDO EN LA ""FASE DE CAPTURA" SINO EN "PROPAGACIÓN NORMAL"
         
    }
    
    function addAsset(){

        const keyClass = ".form-control.perim-key";
        const keyValue = ".form-control.perim-key";

        const json = data.getJson(keyClass, keyValue)

        let url = "../../Controllers/asset.controller.php";

        let params = new FormData();

        params.append("action","addAsset");
        params.append("idproyecto",idProyecto);
        params.append("tipo_activo",$("#tipo-activo").value);
        params.append("imagen",$("#in-image").files[0]);
        params.append("codigo",$("#codigo").value);
        params.append("estado",$("#estado").value);
        params.append("sublote",$("#sublote").value);
        params.append("direccion",$("#direccion").value);
        params.append("moneda_venta",$("#moneda-venta").value);
        params.append("precio_venta",$("#precio-venta").value);
        params.append("area_terreno",$("#area").value);
        params.append("zcomunes_porcent",$("#z-comunes").value);
        params.append("partida_elect",$("#partida-elect").value);
        params.append("latitud",$("#latitud").value);
        params.append("longitud",$("#longitud").value);
        params.append("perimetro",json);
        params.append("det_casa",`{"clave" :[""], "valor":[""]}`);
         

        data.sendAction(url,params)
            .then(result =>{

                console.log(result);
                if(result.filasAfect > 0){
                   
                    let codeName = btoa(dataProject.denominacion)
                    let codeid = btoa(idProyecto);
                    sweetAlert.sweetConfirmAdd("El registro fué exitoso","¿Deseas volver a registrar?",
                        ()=>{
                            $("#form-asset-gen").reset();
                            $("#form-asset-desc").reset();
                            $("#form-asset-gen").classList.remove("was-validated");
                            $("#view-image").setAttribute("src","");

                            $("#form-asset-desc").classList.remove("was-validated");
    
                        },()=>{
                            window.location.href = `./index_asset.php?id=${code}`;
                        })
                }else{
                    sweetAlert.alertError("No se termiado el registro","Vuelve a intentarlo");
                }                
            })
            .catch(e=>{
                console.error(e);
            });
    }


    $("#form-asset-desc").addEventListener("submit",(e)=>{

        let id ="#form-asset-desc";

        e.preventDefault();
        sendDataForm(id,()=>{

            addAsset();
        });
    })
    

    $("#sublote").addEventListener("keypress",(e)=>{
    
        if(e.keyCode == 13){

            let sublote = $("#sublote").value;
    
                if(code != ""){

                    searchInfo(dataAssets,"sublote",sublote);
                }   
        } 

    });


    $("#codigo").addEventListener("keypress",(e)=>{
    
        if(e.keyCode == 13){

            let code = $("#codigo").value;
        
                if(code != ""){

                    searchInfo(dataAssets,"codigo",code);
                }
        }  

    });

    getProject(idProyecto);
    getAssets(idProyecto);
    
});
    </script>
  </body>
</html>