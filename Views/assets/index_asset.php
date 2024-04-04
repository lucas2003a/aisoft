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
                <div class="m-4">
                    <div>
                        <input type="text" id="in-codigo" class="input-form"  placeholder="Ingrese el código del proyecto">
                    </div>
                    <div>
                        <a type="button" href="#" class="button-add" id="agregar"><i class="bi bi-plus-circle"></i> Agregar</a>
                    </div>

                    <table class="mt-4 table table-sm table-stripped table-primary table-hover border-primary text-center" id="table-assets">
                        <thead>
                            <th><strong>#</strong></th>                            
                            <th><strong>CÓDIGO</strong></th>                            
                            <th><strong>SUBLOTE</strong></th>                            
                            <th><strong>ESTADO</strong></th>                            
                            <th><strong>DIRECCIÓN</strong></th>                            
                            <th><strong>USUARIO</strong></th>                            
                            <th><strong>OPERACIONES</strong></th>                            
                        </thead>
                        <tbody>

                            <!-- RENDER TABLA -->
                            <tr>
                                <td> -- </td>
                                <td> -- </td>
                                <td> -- </td>
                                <td> -- </td>
                                <td> -- </td>
                                <td> -- </td>
                                <td> -- </td>
                            </tr>
                        </tbody>
                    </table>
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

    /* VALOR EN LA URL */
    const stringQuery = window.location.search;
    const url = new URLSearchParams(stringQuery);
    const code = url.get("id");
    const codeName = url.get("name");

    const idProyecto = atob(code); //DECOFICA EL VALOR
    const name = atob(codeName);
    console.log(idProyecto,name);

    const $ = id => document.querySelector(id);
    const $All = id => document.querySelectorAll(id);

    function getAssets(id){

        let url ="../../Controllers/asset.controller.php";
        let params = new FormData();

        params.append("action","listAssetProjectId");
        params.append("idproyecto",id);

        data.sendAction(url,params)
            .then(assets => {
                
                $("#cabezera").innerText +=` ${name}`;

                let numberRow = 1;
                $("#table-assets tbody").innerHTML = "";


                assets.forEach(asset =>{

                    let newRow = ``;
                    let code = btoa(asset.idactivo) //CODIFICACIÓN

                    newRow = `
                            <tr>
                                <td>${numberRow}</td>
                                <td>${asset.codigo}</td>
                                <td>${asset.sublote}</td>
                                <td>${asset.estado}</td>
                                <td>${asset.direccion}</td>
                                <td>${asset.usuario}</td>
                                <td>
                                    <div class="btn-group">
                                    <a type="button" href="./delete_asset.php?id=${code}" class="btn btn-danger btn-sm" id="btn-delete"><i class="bi bi-trash-fill"></i></a>
                                    <a type="button" href="./set_asset.php?id=${code}" class="btn btn-primary btn-sm" id="btn-edit"><i class="bi bi-pencil-fill"></i></a>
                                    <a type="button" href="./detail_asset.php?id=${code}" class="btn btn-success btn-sm"><i class="bi bi-arrow-right-square"></i></a>
                                    </div>
                                </td>
                            </tr>            
                    `;
                    numberRow ++;

                    $("#table-assets tbody").innerHTML += newRow;
                });
            })
            .catch(e => {
                console.error(e);
            });
    }

    $("#agregar").addEventListener("click",()=>{

        window.location.href = `./add_asset.php?id=${code}`;
    });

    getAssets(idProyecto);
});
    </script>

</body>
</html>