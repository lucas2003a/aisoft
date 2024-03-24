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

                    <div>
                        <input type="text" id="in-codigo" class="input-form"  placeholder="Ingrese el código del proyecto">
                    </div>
                    <div>
                        <a type="button" href="../proyectos/add_project.php" class="button-add"><i class="bi bi-plus-circle"></i> Agregar</a>
                    </div>
                    
                    <div class="row" id="card-project">
                        
                        <!-- RENDER DE PROYECTOS -->
                        <h2 class="m-4"><strong>Cargando información..</strong></h2>

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