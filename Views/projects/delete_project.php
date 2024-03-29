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

                    <div>
                        <input type="text" id="in-codigo" class="input-form"  placeholder="Ingrese el código del proyecto">
                    </div>
                    <div>
                        <a type="button" href="../proyectos/add_project.php" class="button-add"><i class="bi bi-plus-circle"></i> Agregar</a>
                    </div>

                    <!-- RENDER DE PROYECTOS -->
                    <h2 class="m-4"><strong>Cargando información..</strong></h2>
                    
                    <div  style ="display: flex;justify-content: center; align-content: center;">
                    <div class="card-center">
                        <div class="card-body">
                            <div class="dropdown dropup">
                                <button type="button" class="button-edit" data-idSet="${item.idproyecto}"></button>
        
                                
                                <ul class="dropdown-menu-admin">
                                    <li class="dropdown-item-admin"><a href='./set_project.php?id=${item.idproyecto}'><img src="../../iconos/lapiz-blue.png" style="width: 24px;"> Editar</a></li>
                                    <li class="dropdown-item-admin"><a  href="./delete_project.php?id=${item.idproyecto}"><img src="../../iconos/delete.png"> Eliminar</a></li>
                                    <li class="dropdown-item-admin"><a  href="./${item.idproyecto}"><img src="../../iconos/planet-earth.png" style="width: 24px;"> Mapa</a></li>
                                </ul>
                            </div>
                            <h5 class="card-title"><strong>${item.denominacion}</strong></h5>
                            <p class="card-text"><strong><i class="bi bi-signpost-2 bt-adress"></i> </strong>${item.direccion}</p>
                            <p class="card-text"><i class="bi bi-flag btn-band"></i>${item.distrito}-${item.provincia}-${item.departamento}</p>
                            <p style="margin-top: 3rem; margin-bottom: 1rem;"><i class="bi bi-building-fill-slash btn-nvend"></i>${item.l_noVendidos} <i class="bi bi-building-fill-lock btn-sep"></i>${item.l_separados} 
                            <i class="bi bi-building-fill-check btn-vend"></i>${item.l_vendidos} <i class="bi bi-houses-fill btn-total"></i>${item.l_total}</p>
                            <a href="#" class="button-verinfo" data-idpr="${item.idproyecto}"><strong>Ver más..</strong></a>
                        </div>
                        <div class="carad-footer">
                            
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

    <script src="../../js/sidebar.js"></script>
