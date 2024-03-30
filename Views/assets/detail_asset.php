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
                    <!-- <iframe src="../../modeloAIF.png" frameborder="25" style="width: 100%;"></iframe> -->
                    <div class="card-detail">
                        <div class="card-img-detail" style="padding:5rem;">
                            <img src="../../logos_proyectos/san_blas.png" alt="" style="width:90%;"  id="imagen">
                        </div>
                        <div class="card-body">
                            <h4><strong>Tipo : </strong><spam id="tipo-activo"></spam></h4>
                            <h4><strong>Sublote : </strong><spam id="sublote"></spam></h4>
                            <h4><strong>Código : </strong><spam id="codigo"></spam></h4>
                            <h4><strong>Dirección : </strong><spam id="direccion"></spam></h4>
                            <h4><strong>Ubigeo : </strong><spam id="ubigeo"></spam></h4>                             
                            <div id="estado" style="height: 10px;">
                                
                            </div>
                            <div class="m-2">

                                <p>
                                    <button type="button" class="btn btn-danger btn-lg" id="btn-pdf"><i class="bi bi-filetype-pdf"></i></button>
                                    <button type="button" class="btn btn-success btn-lg" id="btn-excel"><i class="bi bi-file-earmark-excel-fill"></i></button>
                                    <button type="button" class="btn btn-primary btn-lg" id="btn-edit"><i class="bi bi-pencil-fill"></i></button>
                                    <button type="button" class="btn btn-danger btn-lg" id="btn-delete"><i class="bi bi-trash-fill"></i></button>
                                    <button type="button" class="btn btn-primary btn-lg" id="btn-plussClient"><i class="bi bi-person-fill-add"></i></button>
                                </p>
                            </div>    
                            <!-- <h4><strong>Estado : </strong><spam ></spam></h4> -->
                        </div>                    
                    </div>
                    <div style="margin-top: 5rem; width:70%; display: flex; margin:0 auto;">
                        <canvas id="myChart"></canvas>
                    </div>
                        <div class="row">
                            <div class="col-md-6">
                                
                                <div id="details">
        
                                    <div class="card-detail" style="margin-top: 5rem; height: 300px;">
                                        <div class="card-body">
                                            <div class="card-title">
                                                <strong>Descripción</strong>
                                                <hr>
                                            </div>
                                            <h5><strong>Área : </strong><spam id="area"></spam></h5>
                                            <h5><strong>Zonas comunes : </strong><spam id="z-comun"></spam></h5>                                            
                                            <h5><strong>Moneda de venta : </strong><spam id="moneda-venta"></spam></h5>
                                            <h5><strong>Precio de venta : </strong><spam id="precio-venta"></spam></h5>
                                            <h5><strong>Partida Electrónica : </strong><spam id="partida-elect"></spam></h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div id="clientes">
        
                                    <div class="card-detail" style="margin-top: 5rem; height: 300px;">
                                        <div class="card-body">
                                            <div class="card-title">
                                                <strong>Cliente</strong>
                                                <hr>
                                            </div>
                                            <h5><strong>Apellidos : </strong><spam id="apellidos"></spam></h5>
                                            <h5><strong>Nombres : </strong><spam id="nombres"></spam></h5>
                                            <h5><strong>Tipo de documento : </strong><spam id="documento-tipo"></spam></h5>
                                            <h5><strong>Nº documento : </strong><spam id="documento-nro"></spam></h5>
                                            <h5><strong>Estado civil : </strong><spam id="estado-civil"></spam></h5>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="card-detail" style="margin-top: 5rem;">
                                <div class="card-body">
                                    <div class="card-title">
                                        <strong>Detalle de construcción</strong>
                                        <hr>
                                    </div>
                                    <div id="det-casa">

                                        <!-- RENDER DETALLES -->

                                    </div>                                
                                </div>
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
    
    const sweetAlert = new Alert();
    const data = new Data();

    const $ = id => document.querySelector(id);
    const $All = id => document.querySelectorAll(id);

    const stringQuery = window.location.search;
    const url = new URLSearchParams(stringQuery);
    const code = url.get("id");
    const idActivo = atob(code);

    console.log(idActivo);

      const ctx = document.getElementById('myChart');

  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
      datasets: [{
        label: '# of Votes',
        data: [12, 19, 3, 5, 2, 3],
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });
  
  function getClient(id){

      let url = "../../Controllers/separation.controller.php";

      let params = new FormData();

      
      params.append("action","listSeparaction");
      params.append("idactivo",id);
      
      data.sendAction(url, params)
      .then(client => {
          if(client.length > 0){
              
              console.log(client);
              $("#apellidos").innerText = client.apellidos;
              $("#nombres").innerText = client.nombres;
              $("#documento-tipo").innerText = client.documento_tipo;
              $("#documento-nro").innerText = client.documento_nro;
              $("#estado-civil").innerText = client.estado_civil;
          }else{
                $("#apellidos").innerHTML = "";
              $("#nombres").innerHTML = "";
              $("#documento-tipo").innerHTML = "";
              $("#documento-nro").innerHTML = "";
              $("#estado-civil").innerHTML = "";
          }
      })
      .catch(e => {
          console.error(e);
      });
  }
  

    function renderJson(json){
        
        let keys = json.clave;
        let values = json.valor;

        keys.forEach((key, index) => {

            let value = values[index];

            let newDet = ``;

            newDet = `
            <div class="m-2">
                <h5><strong>${key}</strong></h5>
                <div class="m-2">
                    <p class="m-4">${value}</p>
                </div>
            </div>
            `;

            $("#det-casa").innerHTML += newDet; 
        });
    };

    function renderDescription(asset){

        $("#moneda-venta").innerText = asset.moneda_venta;
        $("#precio-venta").innerText = asset.precio_venta;
        $("#partida-elect").innerText = asset.partida_elect;
        $("#area").innerText = asset.area_terreno;
        $("#z-comun").innerText = asset.zcomunes_porcent;
    };

    function getDetailAsset(id){

        let url = "../../Controllers/asset.controller.php";
        let params = new FormData();

        params.append("action","listAssetId");
        params.append("idactivo",id);

        data.sendAction(url,params)
            .then(asset =>{
                console.log(asset);

                if(asset.estado == "VENDIDO"){

                    $("#estado").classList.add("mark-green");

                }else if(asset.estado == "SIN VENDER"){

                    $("#estado").classList.add("mark-red");

                }else{
                    $("#estado").classList.add("mark-warning");
                }

                $("#cabezera").innerText += ` ${asset.denominacion}`;

                $("#tipo-activo").innerText = asset.tipo_activo;
                $("#codigo").innerText = asset.codigo;
                $("#estado").innerText = asset.estado;
                $("#sublote").innerText = asset.sublote;
                $("#direccion").innerText = asset.direccion;
                $("#ubigeo").innerText = `${asset.distrito} - ${asset.provincia} - ${asset.departamento}`;

                
                const det_casa = JSON.parse(asset.det_casa);
                console.log(det_casa);
                
                renderDescription(asset);
                renderJson(det_casa);
                getClient(idActivo);

            })
            .catch(e => {
                console.error(e);
            });
    };

    $("#btn-edit").addEventListener("click",()=>{

        window.location.href = `./add_asset.php?id=${code}`;
    });

    getDetailAsset(idActivo);
});
    </script>

</body>
</html>