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

        let dataProject;            //VARIABLE QUE ALMACENA LOS DATOS OBTENIDOS DE LA CONSULTA
        let numerCards = 3;         //VARIBLEQUE ALMACENA LOS CARDS


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
                    }            
                    
                })
                .catch(e => {
                    console.error(e);
                });
        }
           
        //EJEECUTA AL OBSERVADOR
        function watch(){
                
            let cardsRender = document.querySelectorAll(".card"); //OBTENGO TODOS LOS CARDS EN PANTALLA

            //numerCards = cardsRender.length;
            let lastCard = cardsRender[cardsRender.length -1];  
            observer.observe(lastCard); // => EL OBSERVADOR
        }
            
        //RENDERIZA LO CARDS RESTANTES
        function moreCards(array, index){

            
                    project = array[index];
    
                    let newCard = ``;
        
                    let newImage = project.imagen == null ? "NoImage" : project.imagen;
        
                    newCard = `
                        <div class="col-md-6 col-sm-12">
                            <div class="card project">
                                <div class="card-img" style="padding: 2rem;">
                                    <img src="../../logos_proyectos/${newImage}" style="width: 90%; height: 90%;" alt="${project.imagen}">
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
        }
        

        //REDERIZA EL PRIMER GRUPO DE CARDS
        function renderCard(array, index){

            if(index < 4 ){

                for(i = 0; i < 4; i++){
                    project = array[i];
    
                    let newCard = ``;
        
                    let newImage = project.imagen == null ? "NoImage" : project.imagen;
        
                    newCard = `
                        <div class="col-md-6 col-sm-12">
                            <div class="card project">
                                <div class="card-img" style="padding: 2rem;">
                                    <img src="../../logos_proyectos/${newImage}" style="width: 90%; height: 90%;" alt="${project.imagen}">
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

        //OBSERVADOR => 2 PARÁMETROS

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
            rootMargin: "0px 350px  350px  20px ", //TAMAÑO DEL VIEWPORT => PANTALLA VISUAL 
            threshold: 1.0
        });
        listProyects();

        


    });
    </script>
</body>
</html>
