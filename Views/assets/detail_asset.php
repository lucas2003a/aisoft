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

                    <div class="card-center" style="width:100%;flex-direction:row;">
                        <div class="card-img" style="padding:1rem;">
                            <img src="../../logos_proyectos/san_blas.png" alt="" style="width:500px;" id="imagen">
                        </div>
                        <div class="card-body">
                            <h4><strong>Tipo : </strong></h4>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Iure molestiae tempore quidem illo, repellat quae hic, earum voluptas quia corrupti perferendis tenetur, aliquid facere voluptate deserunt commodi atque fugit quibusdam.</p>
                            <div class="col-md-6 col-sm-12" id="detail-first">
                            </div>
                        </div>
                    </div>

                        <div id="details">

                            <div class="card-detail" style="margin-top: 5rem;">
                                <div class="card-body">
                                    <div class="card-title">
                                    Lorem ipsum dolor sit amet consectetur
                                    </div>
                                    Lorem ipsum dolor sit amet consectetur adipisicing elit. Officiis, qui ex hic quaerat laudantium tempora nesciunt libero alias aliquid praesentium provident voluptatum sequi quis rem doloribus sint culpa. Assumenda, ducimus?
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

    <!-- CLASE DATA -->
    <script src="../../js/data.js"></script>

    <!-- CLASE ALERT -->
    <script src="../../js/sweetAlert.js"></script>

    <!-- SIDEBAR -->
    <script src="../../js/sidebar.js"></script>
    <script>
document.addEventListener("DOMContentLoaded",()=>{
    
    const sweetAlert = new Alert();
    const data = new Data();

    const $ = id => document.querySelector(id);
    const $All = id => document.querySelectorAll(id);

    const stringQuery = window.location.search;
    const url = new URLSearchParams(stringQuery);
    const code = url.get("id");
    const idActivo = atob(code);

    console.log(idActivo);

    function getDetailAsset(id){

        let url = "../../Controllers/asset.controller.php";
        let params = new FormData();

        params.append("action","listAssetId");
        params.append("idactivo",id);

        data.sendAction(url,params)
            .then(asset =>{
                console.log(asset);
                $("#cabezera").innerText += ` ${asset.denominacion}`;

            })
            .catch(e => {
                console.error(e);
            });
    };

    getDetailAsset(idActivo);
});
    </script>

</body>
</html>