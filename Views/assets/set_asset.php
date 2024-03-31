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
                    <button class="tablink active" id="btn-DGeneral">Datos Generales</button>
                    <button class="tablink" id="btn-description" disabled>Descripción</button>
                    <button class="tablink" id="btn-build" disabled>Construcción</button>
                    <button class="tablink" id="btn-client" disabled>Cliente</button>

                    <div id="DGeneral" class="tabcontent" style="display: block;">
                        <h3>Home</h3>
                        <p>Home is where the heart is..</p>
                        <div>
                        <form class="row needs-validation" id="form-add-project" novalidate>
                            <div class="row">
                                <div class="col-md-6">

                                    <!-- DATOS GENERALES -->
                                    
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

                                    <!-- CODIGO -->
                                    <div class="mt-4">
                                        <label for="codigo" class="form-label">Código</label>
                                        <input type="text" class="form-control" id="codigo" placeholder="Código" required autofocus>
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
                                        <input type="text" class="form-control" id="direccion" placeholder="Dirección" readonly required>
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
                                    <img src="" alt="" id="visor">
                                </div>
                            </div>                                                                 
                                                        
                            <div style="display: flex; justify-content: center; margin: 1rem;">
                        
                                <button class="btn btn-primary btn-lg" type="submit" id="guardar" disabled>Siguiente</button>
                            </div>
                        </form>
                    </div>

                    <div id="Description" class="tabcontent">
                        <h3>News</h3>
                        <p>Some news this fine day!</p>
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

    function renderDepartaments(){

        const url = "../../Controllers/ubigeo/departament.controller.php";
        const action = "list";

        data.getData(url,action)
            .then(departaments => {
                console.log(departaments);
                departaments.forEach(departament => {

                    const newOption = document.createElement("option");
                    newOption.value = departament.iddepartamento;
                    newOption.innerText = departament.departamento;
                    
                    $("#iddepartamento").appendChild(newOption);
                });
            })
            .catch(e => {
                console.error(e);
            });
    }

    function renderProvinces(id){

        const url = "../../Controllers/province.controller.php";
        let params = new FormData();

        params.append("action","list");
        params.append("iddepartamento",$("#iddepartamento").value);

        data.sendAction(result => {

        })
        .catch(e => {
            console.log(e);
        })
    }

    function resetSelect(id,text,callback){

        $(id).innerHTML = "";
        
        let newOption = document.createElement("option");
        newOption.value = "",
        newOption.innerText = text;

        $(id).appendChild(newOption);

        callback();
    }

    $("#iddepartamento").addEventListener("change",()=>{
        resetSelect("#iddepartamento","Departamentos",renderDepartaments);
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

    renderDepartaments();
    btnDGeneral.click();
});
    </script>
  </body>
</html>