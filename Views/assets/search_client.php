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

                    <h2><strong>CLIENTES</strong></h2>
                    <hr>

                    <div>
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
                        <div id="Dcliente" class="tabcontent" style="display: block;">
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
                        <div id="Dconyugue" class="tabcontent">
                            <form class="row needs-validation" id="form-conyug" novalidate>
                                <!-- CONYUGUE -->
                                
                                <h4>CONYUGUE (OPCIONAL SI ES CASADO)</h4>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        
                                        <!-- DOCUMENTO TIPO -->
                                        <div class="mt-4">
                                            <label for="documento_tipo" class="form-label">Tipo de documento</label>
                                            <select class="form-select custom-select-scroll" id="documento_tipo" >
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
                                            <label for="cn-documento_nro" class="form-label">Nº de documento</label>
                                            <div class="input-group">
                                                <input type="text" class="form-control" id="cn-documento_nro" placeholder="Nº de documento"  autofocus>
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
                                            <select class="form-select custom-select-scroll" id="estado_civil" >
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
                                            <input type="text" class="form-control" id="direccion" placeholder="Dirección" >
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
                                            <input type="text" class="form-control" id="nombres" placeholder="Nombres" >
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
                                            <input type="text" class="form-control" id="apellidos" placeholder="Apellidos" >
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
                                    <select class="form-select custom-select-scroll" id="iddepartamento" >
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
                                    <select class="form-select custom-select-scroll" id="idprovincia" >
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
                                    <select class="form-select custom-select-scroll" id="iddistrito" >
                                        <option selected disabled value="">Distrito</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Necesitas escojer un distrito.
                                    </div>
                                    <div class="valid-feedback">
                                        Distrito escojido correctamente.
                                    </div>
                                </div>
                                <div class="m-4 col-md-12 d-flex justify-content-center">
                                    <button class="btn btn-primary btn-lg" type="submit" id="guardar">Guardar</button>
                                </div>
                            </form>
                        </div>
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
    <!-- <script src="../../js/projects/interactionForms.js"></script>
    <script src="../../js/projects/add_project.js"></script> -->
    <script src="../../js/renderUbigeo.js"></script>
    <script>

    document.addEventListener("DOMContentLoaded",()=>{

        const data = new Data();

        const $ = id => document.querySelector(id);
        const $All = id => document.querySelectorAll(id);

        function getClient(){

            let url = `../../Controllers/client.controller.php`;

            let params = new FormData();

            params.append("action","listClientDnro"),
            params.append("documento_nro",)
        }

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
    })
    </script>
</body>
</html>
