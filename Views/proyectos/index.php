<?php

require_once "../sidebar/sidebar.php";
?>
    <!--EL CONTENIDO INICIA-->
    <div class="height-100 bg-light">
        <div class="mt-4 bg-white" id="content-py">

            <div class="p-2 header-gradient">
                <h2 class="m-2 text-white"><strong>PROYECTOS</strong></h1>
            </div>

            <div class="contaier m-4">
                <div class="row" id="card-project">
                <!-- RENDER DE PROYECTOS -->
                <h2><strong>Cargando información..</strong></h2>
                    
                </div>
            </div>
        </div>
    </div>
    <!--EL CONTENIDO TERMINA-->
    <script src="../../js/sidebar.js"></script>
    <script>

    document.addEventListener("DOMContentLoaded",()=>{

        const $ = id=> document.querySelector(id);
        const cardProject = $("#card-project");
        function listProyects(){

            params = new FormData();

            params.append("action","listProject");

            fetch(`../../controllers/project.controller.php`,{

                method: "POST",
                body: params
            })
                .then(result => result.json())
                .then(projects => {
                    
                    if(projects.length > 0){

                        console.log(projects);

                        cardProject.innerHTML = "";

                        projects.forEach(project => {
                            
                            let newCard = ``;

                            newCard = `
                                <div class="col-md-6 col-sm-12">
                                    <div class="card">
                                        <div class="card-img" style="padding: 2rem;">
                                            <img src="../../logos_proyectos/${project.imagen}" style="width: 90%; height: 90%;" alt="${project.imagen}">
                                        </div>
                                        <div class="card-body">
                                            <h5 class="card-title"><strong>${project.denominacion}</strong></h5>
                                            <p class="card-text"><strong>Dirección: </strong>${project.direccion}</p>
                                            <p class="card-text">${project.distrito}-${project.provincia}-${project.departamento}</p>
                                            <p class="card-text"><strong>Lotes no vendidos:     </strong>${project.lotes_NoVendidos}</p>
                                            <p class="card-text"><strong>Lotes separados:       </strong>${project.lotes_separados}</p>
                                            <p class="card-text"><strong>Lotes vendidos:        </strong>${project.lotes_vendidos}</p>
                                            <p class="card-text"><strong>Total de lotes:        </strong>${project.total_lotes}</p>
                                            <a href="#" class="button-verinfo" data-idpr="${project.idproyecto}"><strong>Ver más..</strong></a>
                                        </div>
                                    </div>
                                </div>
                            `;

                            cardProject.innerHTML += newCard;
                        });
                    }
                })
                .catch(e => {
                    console.error(e);
                });
        }

        listProyects();

/*         window.addEventListener("scroll",()=>{

            if((window.innerHeight + window.scrollY) >= document.body.offsetHeight){
                listProyects();
            }
        }); */
    });
    </script>
</body>
</html>
