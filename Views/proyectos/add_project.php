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

                                    <!-- IDDIRECCIÓN -->
                                    <div class="mt-4">
                                        <label for="sede" class="form-label">Sede</label>
                                        <select class="form-select" id="iddireccion" required>
                                            <option selected disabled value="">Sede</option>
                                            <option>...</option>
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
                                        <label for="idcodigo" class="form-label">Código</label>
                                        <input type="text" class="form-control" id="idcodigo" placeholder="Código" required>
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
    
                                    <!-- DEPARTEMENTO -->
                                    <div class="mt-4">
                                      <label for="iddepartamento" class="form-label">Departamento</label>
                                        <select class="form-select" id="iddepartamento" required>
                                            <option selected disabled value="">Departamento</option>
                                            <option>...</option>
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
                                        <select class="form-select" id="idprovincia" required>
                                            <option selected disabled value="">Provincia</option>
                                            <option>...</option>
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
                                        <select class="form-select" id="iddistrito" required>
                                            <option selected disabled value="">Distrito</option>
                                            <option>...</option>
                                        </select>
                                        <div class="invalid-feedback">
                                            Necesitas escojer un distrito.
                                        </div>
                                        <div class="valid-feedback">
                                            Distrito escojido correctamente.
                                        </div>
                                    </div>
    
                                    <!-- IMAGEN -->
                                    <div class="form-group">
                                        <label for="in-imagen" class="label-img">
                                            <i class="material-icons"></i>
                                            <span class="title">Agregar imagen</span>
                                            <input type="file" accept=".jpg" id="in-imagen">
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
                                    <div class="mt-4">
                                        <label for="perimetro" class="form-label">Perímetro (Coordenadas)</label>
                                        <hr>
                                        <div class="row">
                                            <div class="col-md-11">
                                                <input type="text" class="form-control form-coor" id="perimetro">
                                            </div>
                                            <div class="col-md-1">
                                                <button type="button" class="button-addPlus" id="add-textBox">+</button>
                                            </div>
                                        </div>
                                        <div class="valid-feedback">
                                            <!-- -- -->
                                        </div>
                                    </div>
                                    <div class="m-4 col-12">
                                        <button class="btn btn-primary" type="submit">Guardar</button>
                                    </div>
                                    
                                </div>                                    

                                
                                <div class="row">

                                    <div class="col-md-12">
                                        <img src="" alt="">
                                    </div>

                                </div>
                            </div>
                        </form>
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

    <script src="../../js/sidebar.js"></script>
    <script>

    const $ = id => document.querySelector(id);

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
            }

            form.classList.add('was-validated') //=> AGREGA ESTA CLASE A LOS ELEMENTOS DEL FORMULARIO(MUESTRA LOS COMENTARIOS)
            }, false) //=> ESTE TERCER ARGUMENTO INDICA QUE EL EVENTO NO SE ESTA CAPTURANDO EN LA ""FASE DE CAPTURA" SINO EN "PROPAGACIÓN NORMAL"
        })
    })()


    </script>