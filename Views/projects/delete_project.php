<?php

require_once "../sidebar/sidebar.php";
?>
    <!--EL CONTENIDO INICIA-->
    <div class="height-100 bg-light">
        <div class="mt-4 bg-white" id="content-py">

            <div class="p-2 header-gradient">
                <h2 class="m-2 text-white"><strong>PROYECTOS</strong></h1>
            </div>

            <div class="content ma-4 ">
                <!-- CAJA DE BUSQUEDA -->
                <div class="m-4">

                    <!-- RENDER DE PROYECTOS -->
                    
                    <div  style ="display: flex;justify-content: center; align-content: center;">
                    <div class="card-center">
                        <div class="card-body">
                            <div  class="card-title m-4"><h2 style="text-align: center; text-transform: uppercase;"><strong  id="card-title"></strong></h2></div>
                            <hr>
                            <div class="row mt-4">
                                <div class="col-md-6">
                                    <h3><strong>Código:</strong></h3>
                                </div>
                                <div class="col-md-6">
                                    <h4 id="codigo"> ---- </h4>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <h3><strong>Denominación: </strong></h3>
                                </div>
                                <div class="col-md-6">
                                    <h4 id="denominacion"> --- </h4>
                                </div>                                    
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <h3><strong>Ubigeo :</strong></h3>
                                </div>
                                <div class="col-md-6">
                                    <h4 id="ubigeo"> ---- </h4>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <h3><strong>Latitud :</strong></h3>
                                </div>
                                <div class="col-md-6">
                                    <h4 id="latitud"> ---- </h4>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <h3><strong>Longitud: </strong></h3>
                                </div>
                                <div class="col-md-6">
                                    <h4 id="longitud"> ---- </h4>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <h3><strong>Perímetro: </strong></h3>
                                </div>
                                <div class="col-md-6">
                                    <div class="m-4" id="perimetro">

                                    </div>                                     
                                </div>
                            </div>
                            <div class="m-4">
                                <h4 class="ask-footer">¿Deseas eliminarlo?</h4>
                            </div>
                            <div>
                                <div class="row">                                    
                                    <button type="button" class="btn-red" id="eliminar">Eliminar</button>
                                    <button type="button" class="btn-blue" id="cancelar">Cancelar</button>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                        </div>
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

    <script src="../../js/sidebar.js"></script>

    <!-- CLASE DATA -->
    <script src="../../js/data.js"></script>

    <!-- CLASE SWEETALERT -->
    <script src="../../js/sweetAlert.js"></script>
 
    <script src="../../js/projects/delete_project.js"></script>
    </body>
</html>
