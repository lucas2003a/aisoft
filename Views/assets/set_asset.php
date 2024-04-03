<?php

require_once "../sidebar/sidebar.php"
?>
    <!--EL CONTENIDO INICIA-->
    <div class="height-100 bg-light">
        <div class="m-4 bg-white">

            <div class="p-2 header-gradient">
                <h2 class="m-2 text-white"><strong id="cabezera">LOTE </strong></h1>
            </div>

            <div class="content ma-4">
                <div class="mt-4">
                    <button class="tablink active" id="btn-DGeneral">Datos Generales</button>
                    <button class="tablink" id="btn-description" disabled>Descripción</button>
                    <button class="tablink" id="btn-build" disabled>Construcción</button>
                    <button class="tablink" id="btn-client" disabled>Cliente</button>

                    <div id="DGeneral" class="tabcontent" style="display: block;">
                        <form class="row needs-validation" id="form-asset-gen" novalidate>
                            <div class="row">
                                <div class="col-md-6">

                                    <!-- DATOS GENERALES -->
                                    
                                    <!-- UBIGEO -->
                                    <div >
                                      <label for="ubigeo" class="form-label">Ubigeo</label>
                                        <input type="text" class="form-control" id="ubigeo" readonly>

                                    </div>

                                    <!-- ESTADO -->
                                    <div class="mt-4">
                                      <label for="estado" class="form-label">Estado</label>
                                        <input type="text" class="form-control" id="estado" readonly>

                                    </div>
    
                                    <!-- ESTADO -->
                                    <div class="mt-4">
                                      <label for="tipo-activo" class="form-label">Tipo activo</label>
                                        <input type="text" class="form-control" id="tipo-activo" readonly>

                                    </div>
    
                                    
                                    <!-- CODIGO -->
                                    <div class="mt-4">
                                        <label for="codigo" class="form-label">Código</label>
                                        <input type="text" class="form-control" id="codigo" placeholder="Código" maxlength="7" minlength="7" required autofocus>
                                        <div class="invalid-feedback">
                                            Necesitas ingresar un código.
                                        </div>
                                        <div class="valid-feedback">
                                            Código registrado correctamente.
                                        </div>
                                    </div>
    
                                    <!-- SUBLOTE -->
                                    <div class="mt-4">
                                        <label for="sublote" class="form-label">Sublote</label>
                                        <input type="text" class="form-control" id="sublote" placeholder="Sublote" required>
                                        <div class="invalid-feedback">
                                            Necesitas ingresar el sublote.
                                        </div>
                                        <div class="valid-feedback">
                                            Sublote registrado correctamente.
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


                                <div class="col-md-6" style="display: flex; align-items: center;">
                                    <img src="" alt="" id="view-image">
                                </div>
                            </div>                                                                 
                                                        
                            <div style="display: flex; justify-content: center; margin: 1rem;">
                        
                                <button class="btn btn-primary btn-lg" type="submit" id="validar">Validar</button>
                            </div>
                        </form>
                    </div>

                    <div id="Description" class="tabcontent">
                        <h3>News</h3>
                        <p>Some news this fine day!</p>
                        <div>
                            <form class="row needs-validation" id="form-asset-gen" novalidate>
                            <div class="row">
                                <div class="col-md-6">

                                    <!-- DATOS GENERALES -->
                                    
                                    <!-- ÁREA -->
                                    <div class="mt-4">
                                      <label for="area" class="form-label">Área</label>
                                        <input type="number" class="form-control" id="area" min="0" value="000.00">

                                    </div>

                                    <!-- ZONAS COMUNES -->
                                    <div >
                                      <label for="z-comunes" class="form-label">Zonas comunes</label>
                                        <input type="number" class="form-control" id="z-comunes" min="0" max="100">

                                    </div>

    
                                    <!-- MONEDA VENTA -->
                                    <div class="mt-4">
                                      <label for="moneda-venta" class="form-label">Moneda de venta</label>
                                        <select class="form-control" id="moneda-venta">
                                            <option value="0">Seleccione</option>
                                            <option value="USD">Dólares</option>
                                            <option value="SOL">Soles</option>
                                        </select>

                                    </div>
    
                                    
                                    <!-- PRECIO VENTA -->
                                    <div class="mt-4">
                                        <label for="precio-venta" class="form-label">Precio de venta</label>
                                        <input type="text" class="form-control" id="precio-venta" placeholder="Código" maxlength="7" minlength="7" required autofocus>
                                        <div class="invalid-feedback">
                                            Necesitas ingresar un código.
                                        </div>
                                        <div class="valid-feedback">
                                            Código registrado correctamente.
                                        </div>
                                    </div>
    
                                    <!-- SUBLOTE -->
                                    <div class="mt-4">
                                        <label for="sublote" class="form-label">Sublote</label>
                                        <input type="text" class="form-control" id="sublote" placeholder="Sublote" required>
                                        <div class="invalid-feedback">
                                            Necesitas ingresar el sublote.
                                        </div>
                                        <div class="valid-feedback">
                                            Sublote registrado correctamente.
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


                                <div class="col-md-6" style="display: flex; align-items: center;">
                                    <img src="" alt="" id="view-image">
                                </div>
                            </div>                                                                 
                                                        
                            <div style="display: flex; justify-content: center; margin: 1rem;">
                        
                                <button class="btn btn-primary btn-lg" type="submit" id="validar">Validar</button>
                            </div>
                        </form>
                        </div>
                        
                    </div>

                    <div id="Build" class="tabcontent">
                        <h3>Contact</h3>
                        <p>Get in touch, or swing by for a cup of coffee.</p>
                    </div>

                    <div id="Client" class="tabcontent">
                        <h3>About</h3>
                        <p>Who we are and what we do.</p>
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
    <script>
document.addEventListener("DOMContentLoaded",()=>{

    /* INSTANCIAS */
    const sweetAlert = new Alert();
    const data = new Data();

    const $ = id => document.querySelector(id);
    const $All = id => document.querySelectorAll(id);

    /* TABLINKS */
    const btnDGeneral = $("#btn-DGeneral");
    const btnDescription = $("#btn-description");
    const btnBuild = $("#btn-build");
    const btnClient = $("#btn-client");

    /* TABCONTENT */
    const contentDGeneral = $("#DGeneral");
    const contentDescription = $("#Description");
    const contentBuild = $("#Build");
    const contentClient = $("#Client");
    const viewImage = $("#view-image");

    /**URL*/
    const stringQuery = window.location.search;
    const params = new URLSearchParams(stringQuery);
    const code = params.get("id");
    const idActivo = atob(code);

    let idProyecto;
    let dataAssets;
    let oldImage;

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

    function getDetailAsset(id){

        let url = "../../Controllers/asset.controller.php";
        let params = new FormData();

        params.append("action","listAssetId");
        params.append("idactivo",id);

        data.sendAction(url,params)
        .then(asset =>{
            console.log(asset);

            idProyecto = asset.idproyecto;

            oldImage = asset.imagen;
            let img = asset.imagen != null ? asset.imagen : "NoImage.jpg";

            $("#cabezera").innerText += ` ${asset.sublote} - ${asset.denominacion}`;

            $("#ubigeo").value = `${asset.distrito} - ${asset.provincia} - ${asset.departamento}`;
            $("#estado").value = asset.estado;
            $("#tipo-activo").value = asset.tipo_activo;
            $("#codigo").value = asset.codigo;
            $("#sublote").value = asset.sublote;
            $("#direccion").value = asset.direccion;
            $("#view-image").setAttribute("src",`../../logos_proyectos/${img}`);

        
            const det_casa = JSON.parse(asset.det_casa);
            console.log(det_casa);

            getAssets(idProyecto);
        
            /* renderDescription(asset);
            renderJson(det_casa); 
            getClient(idActivo);*/

        })
        .catch(e => {
            console.error(e);
        });
    };

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

    function validateForm(id, callback){
        'use strict'
        const form = $(id);



            form.addEventListener('submit', event => {
            
                if (!form.checkValidity()) {
                    event.preventDefault()      //=> FRENA EL ENVÍO DEL FORMULARIO
                    event.stopPropagation()     //=> FRENA LA PROPAGACIÓN DE DATOS EN EL FORMULARIO
                }else{
                    event.preventDefault();
                    sweetAlert.sweetConfirm("Datos nuevos","¿Deseas actualizar el registro?",()=>{
                
                    callback();
                });
            }

            form.classList.add('was-validated') //=> AGREGA ESTA CLASE A LOS ELEMENTOS DEL FORMULARIO(MUESTRA LOS COMENTARIOS)
            }, false) //=> ESTE TERCER ARGUMENTO INDICA QUE EL EVENTO NO SE ESTA CAPTURANDO EN LA ""FASE DE CAPTURA" SINO EN "PROPAGACIÓN NORMAL"
         
    }
    
    $("#form-asset-gen").addEventListener("submit",(e)=>{
        let id = "#form-asset-gen"

        e.preventDefault();
        validateForm(id,()=>{
            btnDescription.removeAttribute("disabled");
            console.log("validar");
            btnDescription.click();
        });
    })

    $("#in-image").addEventListener("change",(e)=>{

        console.log(e)
        readFile(e);
    });

    $("#sublote").addEventListener("keypress",(e)=>{
    
        if(e.keyCode == 13){

            let sublote = $("#sublote").value;
    
                if(code != ""){

                    searchInfo(dataAssets,"sublote",sublote);
                }   
        } 

    });

    $("#codigo").addEventListener("keypress",(e)=>{
    
        /* if(e.keyCode == 13){

            let code = $("#codigo").value;
        
                if(code != ""){

                    searchInfo(dataAssets,"codigo",code);
                }
        }  */

    });

    btnDGeneral.addEventListener("click",function(){
        openTab("#DGeneral", this);
    });
    
    btnDescription.addEventListener("click",function(){
        openTab("#Description", this);
    });

    btnBuild.addEventListener("click",function(){
        openTab("#Build", this);
    });

    btnClient.addEventListener("click",function(){
        openTab("#Client", this);
    });

    getDetailAsset(idActivo);
    btnDGeneral.click();
});
    </script>
  </body>
</html>