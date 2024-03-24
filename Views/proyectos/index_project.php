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
    <script>

    document.addEventListener("DOMContentLoaded",()=>{


        const $ = id=> document.querySelector(id);

        const cardProject = $("#card-project");
        const inCodigo = $("#in-codigo");

        let dataProject;            //VARIABLE QUE ALMACENA LOS DATOS OBTENIDOS DE LA CONSULTA
        let numerCards = 3;         //VARIBLEQUE ALMACENA LOS CARDS
        let timer;

        /**
         * FUNCION QUE CONTIENE EL RENDER DE LOS CARDS
         */
        function asyncRenderCard(item){
            
            let newCard = ``;
        
            let newImage = item.imagen == null ? "NoImage.jpg" : item.imagen;
        
                newCard = `
                    <div class="col-md-6 col-sm-12">
                        <div class="card project">
                            <div class="card-img" style="padding: 2rem;">
                                <img src="../../logos_proyectos/${newImage}" style="width: 90%; height: 90%;" alt="${item.imagen}">
                                <p class="card-text" style="margin: 15px">${item.codigo}</p>
                            </div>
                            <div class="card-body">
                                <div class="dropdown dropup">
                                    <button type="button" class="button-edit" data-idSet="${item.idproyecto}"></button>
            
                                    
                                    <ul class="dropdown-menu-admin">
                                        <li class="dropdown-item-admin" ><a href="./set_project.php?id=${item.idproyecto}"><img src="../../iconos/lapiz-blue.png" style="width: 24px;"> Editar</a></li>
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
                        </div>
                    </div>
                `;
                cardProject.innerHTML += newCard;

        }

        /**
         * RENDERIZA EL CARD DE ERROR (ALERTA)
         */
        function renderCardError(header,body){
            let newCardErr = ``;

            newCardErr = `
                <div class="alert alert-danger m-4" role="alert">
                    <strong>${header}</strong> ${body}
                </div>
                `;
                cardProject.innerHTML += newCardErr;   
        }
            
        /**
         * RENDERIZA LO CARDS RESTANTES
         */
        function moreCards(array, index){
            
            project = array[index];
            
            asyncRenderCard(project);
        }
        

        /**
         * RENDERIZA EL PRIMER GRUPO DE CARDS
         */
        function renderCard(array, index){

            if(index < 4 ){

                for(i = 0; i < 4; i++){
                    project = array[i];
    
                    asyncRenderCard(project);

                    }
                    numerCards++;
                    console.log(index);
    
            
            } else if(index > 3){

                    moreCards(array, index);
                    
                    watch();

                    numerCards++;
                    console.log(index); 
            }
        
        }
        
        /**
         * Función para listar los proyectos
         */
        function listProyects(counter){

            params = new FormData();

            params.append("action","listProject");

            fetch(`../../controllers/project.controller.php`,{

                method: "POST",
                body: params
            })
                .then(result => result.json())
                .then(projects => {
                    
                    dataProject = projects;

                    if(dataProject.length > 0){

                        console.log(dataProject);

                        cardProject.innerHTML = "";
                        
                        renderCard(dataProject, numerCards);
                        
                        watch();
                    }else{
                        renderCardError("Hemos tenido porblemas con la conexión","Recarga la página o vuelve a intentarlo después.")
                    }            
                    
                })
                .catch(e => {
                    console.error(e);
                });
        }
        
        /**
         *EJECUTA AL OBSERVADOR
         * 
         */
        function watch(){
                
            let cardsRender = document.querySelectorAll(".card"); //OBTENGO TODOS LOS CARDS EN PANTALLA

            //numerCards = cardsRender.length;
            let lastCard = cardsRender[cardsRender.length -1];  
            observer.observe(lastCard); // => EL OBSERVADOR
        }

        /**
         * Función para renderizar los cards según su código
         */
        function searchProject(code){

            let params = new FormData();

            params.append("action","listProjectCode");
            params.append("codigo",code);

            fetch(`../../Controllers/project.controller.php`,{

                method: "POST",
                body: params
            })
                .then(result => result.json())
                .then(data =>{

                    if(data.length > 0){

                        for(i = 0; i < data.length; ++i){

                            //console.log(data);
                            moreCards(data , i);
                        }
                    }else{

                        renderCardError("El código ingresado no existe","Asgurate de haber el escrito el código correcto.")
                    }
                })
                .catch(e=>{
                    console.error(e);
                });
        }


        /**
         * Evento input en la caja de texto "in-codigo" => Ejecuta el debounce
         */
        $("#in-codigo").addEventListener("input",()=>{

            clearTimeout(timer);

            timer = setTimeout(()=>{

                let codigo = $("#in-codigo").value;
                console.log("buscando: " +  codigo);

                if(codigo != ""){

                    cardProject.innerHTML = "";
                    searchProject(codigo);
                }else{

                    numerCards = 3;
                    listProyects();
                }

            }, 500);
        });

        /**
         * OBSERVADOR => 2 PARÁMETROS
         */
        const observer = new IntersectionObserver((entries, obser)=>{

            console.log(entries)
            
            if(dataProject.length != numerCards){ // SI LA LONGITUD DE DATOS DE PROJECTOS NO ES IGUAL AL DE LOS CARDS
                
                
                entries.forEach(entri => {
                    if(entri.isIntersecting){
                        
                        console.log(entri); 
    
                        console.log(`Esta es la carga número`);
    
                        renderCard(dataProject, numerCards);
    
                    }
    
                });
            }
            else{

                console.log("No hay más registros");
                    
                }
        },{
            //CONFIGURACION DEL OBSERVADOR
            rootMargin: "0% 0% 0% 0%", //TAMAÑO DEL VIEWPORT => PANTALLA VISUAL 
            threshold: 0.2  
        });

        listProyects();

        


    });
    </script>
</body>
</html>
