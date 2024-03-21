<?php

require_once "../sidebar/sidebar.php";
?>
    <!--EL CONTENIDO INICIA-->
    <div class="height-100 bg-light">
        <div class="mt-4 bg-white" id="content-py">

            <div class="p-2 header-gradient">
                <h2 class="m-2 text-white"><strong>PROYECTOS</strong></h1>
            </div>

            <div class="content m-4">
                <!-- CAJA DE BUSQUEDA -->
                <div class="m-4">
                    <form action="">
                        <input type="text" id="in-codigo" class="input-form"  placeholder="Ingrese el código del proyecto">
                        <!-- <div class="p-4 form-check form-switch">
                            <input
                            class="form-check-input"
                            type="checkbox"
                            id="btn-administrar"
                            checked
                            />
                            <label class="form-check-label" for="flexSwitchCheckChecked">Administrar</label>
                        </div> -->
                    </form>
                    
                    
                    
                    
                    <div class="row" id="card-project">
                        
                        <!-- RENDER DE PROYECTOS -->
                        <h2><strong>Cargando información..</strong></h2>
                    </div>
                    
                    <div class="modal-project">
                        <div class="modal-form">
                            <div class="modal-content">
                                <div class="modal-title">
                                    <div class="modal-head">
                                        <div>
                                            <button class="close"><strong>X</strong></button>
                                        </div>
                                        Mantenimiento
                                        <hr>
                                    </div>
                                </div>
                                <div class="modal-body">
                                    <form action="">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <input type="text" id="in-codigo" class="input-form-modal"  placeholder="Ingrese el código del proyecto" autofocus>
                                            </div>
                                            <div class="col-md-8">
                                                <input type="text" id="in-denominacion" class="input-form-modal"  placeholder="Ingrese la denominaciòn" autofocus>
                                            </div>
                                        </div>
                                        <div>
                                            <input type="file" accept=".jpg" id="in-imagen" class="input-form-modal">
                                        </div>
                                        <div>
                                            <select name="" id="in-direccion" class="input-form-modal">
                                                <option value="0">Sede</option>
                                            </select>                                            
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <input type="text" id="in-latitud" class="input-form-modal"  placeholder="Coordenadas de latitud" autofocus>
                                            </div>
                                            <div class="col-md-6">
                                                <input type="text" id="in-longitud" class="input-form-modal"  placeholder="Coordenadas longitud" autofocus>
                                            </div>
                                        </div>
                                        <div>
                                            <input type="text" id="in-perimetro" class="input-form-modal"  placeholder="Ingrese el perìmetro (JSON)" autofocus>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <select name="" id="in-departamento" class="input-form-modal">
                                                    <option value="0">Departamento</option>
                                                </select>                                            
                                            </div>
                                            <div class="col-md-4">
                                                <select name="" id="in-provincia" class="input-form-modal">
                                                    <option value="0">Provincia</option>
                                                </select>                                            
                                            </div>
                                            <div class="col-md-4">
                                                <select name="" id="in-distrito" class="input-form-modal">
                                                    <option value="0">Distrito</option>
                                                </select>                                            
                                            </div>
                                        </div>
                                        <div>
                                            <input type="text" id="in-direccion" class="input-form-modal"  placeholder="Ingrese la direcciòn" autofocus>
                                        </div>
                                        <div>
                                            <input type="text" id="in-idusuario" class="input-form-modal"  placeholder="idusuario" autofocus>
                                        </div>
                                    </form>
                                </div>
                                <hr>
                                <div class="modal-footer">
                                    <button class="btn-guardar" id="guardar">Guardar</button>
                                    <button class="btn-cerrar" id="cerrar">Cerrar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
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
        const inCodigo = $("#in-codigo");

        let dataProject;            //VARIABLE QUE ALMACENA LOS DATOS OBTENIDOS DE LA CONSULTA
        let numerCards = 3;         //VARIBLEQUE ALMACENA LOS CARDS
        let timer;


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
           
        //EJECUTA AL OBSERVADOR
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
        
            let newImage = project.imagen == null ? "NoImage.jpg" : project.imagen;
        
                newCard = `
                    <div class="col-md-6 col-sm-12">
                        <div class="card project">
                            <div class="card-img" style="padding: 2rem;">
                                <img src="../../logos_proyectos/${newImage}" style="width: 90%; height: 90%;" alt="${project.imagen}">
                            </div>
                            <div class="card-body">
                                <button type ="button" class="button-admin" data-idSet="${project.idproyecto}"></button>
                                <h5 class="card-title"><strong>${project.denominacion}</strong></h5>
                                <p class="card-text"><strong>Dirección: </strong>${project.direccion}</p>
                                <p class="card-text"><strong>Código: </strong>${project.codigo}</p>
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
        

        //RENDERIZA EL PRIMER GRUPO DE CARDS
        function renderCard(array, index){

            if(index < 4 ){

                for(i = 0; i < 4; i++){
                    project = array[i];
    
                    let newCard = ``;
        
                    let newImage = project.imagen == null ? "NoImage.jpg" : project.imagen;
        
                    newCard = `
                        <div class="col-md-6 col-sm-12">
                            <div class="card project">
                                <div class="card-img" style="padding: 2rem;">
                                    <img src="../../logos_proyectos/${newImage}" style="width: 90%; height: 90%;" alt="${project.imagen}">
                                </div>
                                <div class="card-body">
                                    <button type ="button" class="button-admin editar" data-idSet="${project.idproyecto}"></button>
                                    <h5 class="card-title"><strong>${project.denominacion}</strong></h5>
                                    <p class="card-text"><strong>Código: </strong>${project.codigo}</p> 
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
                    }
                })
                .catch();
        }

        //DEBOUNCE (POR MEJORAR)
/*         function debounce(func, delay){

            let timer;

            clearTimeout(timer);

            return function(...args){

                timer = setTimeout(()=>{
                    func.apply(this, args);
                },delay);
            };
        }

        //MANEJADOR DE EVENTOS DEL DEBOUNCE
        function handleChange(e){
            //console.log(e);
            let param = e.target.value
            console.log(param);

            //func(param);
        }

        function searchProject(code){

            console.log(code);
        } */

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


        $("#card-project").addEventListener("click",(e)=>{

            if(e.target.classList.contains("editar")){

                //console.log(e);
                console.log("Edita");

                $(".modal-form").classList.toggle("show");

            }

        });

        /* $("#in-codigo").addEventListener("input",()=>{

            console.log($("#in-codigo").value);
        });
 */
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
            rootMargin: "0% 0% 0% 0%", //TAMAÑO DEL VIEWPORT => PANTALLA VISUAL 
            threshold: 0.2  
        });
        listProyects();

        


    });
    </script>
</body>
</html>
