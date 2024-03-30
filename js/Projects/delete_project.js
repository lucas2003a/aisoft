document.addEventListener("DOMContentLoaded",()=>{

    /* INSTANCIAS */
    const data = new Data();
    const sweetAlert = new Alert();

    
    const queryString = window.location.search;
    
    const url = new URLSearchParams(queryString);
    
    const code = url.get("id");
    const idProyecto = atob(code);

    const $ = id => document.querySelector(id);
    

    function renderInput(keys, values){

        keys.forEach((key, index)=>{
    
            let value = values[index];
    
            if(key != "" || value != ""){
    
                let newText = ``;
    
                newText = `
                    <div class="row">
                        <div class="col-md-6">
                            <h4>${key}</h4>
                        </div>
                        <div class="col-md-6">
                            <h4>${key}</h4>
                        </div>
                    </div>
                `;
    
                $("#perimetro").innerHTML += newText;
            }
        });
    }
    
    function getData(id){

        let url = "../../Controllers/project.controller.php";

        let params = new FormData();

        params.append("action","listProjectId");
        params.append("idproyecto",id);

        data.sendAction(url, params)
            .then(result => {

                let perimetro = JSON.parse(result.perimetro);

                let keys = perimetro.clave;
                let values = perimetro.valor;
                
                renderInput(keys, values);

                $("#card-title").innerText = result.denominacion;
                $("#codigo").innerText = result.codigo;
                $("#denominacion").innerText = result.denominacion;
                $("#ubigeo").innerText = `${result.departamento} - ${result.provincia} - ${result.distrito}`;
                $("#latitud").innerText = result.latitud;
                $("#longitud").innerText = result.longitud;
            })
            .catch(e => {
                console.error(e);
            });
    }

    /**
     * FUNCIÓN PARA ELIMINAR UN PROYECTO
     */
    function deleteProject(){

        let url = "../../Controllers/project.controller.php";

        let params = new FormData();

        params.append("action","inactiveProject");
        params.append("idproyecto",idProyecto);

        data.sendAction(url, params)
            .then(result => {
                console.log(result);
                if(result.filasAfect > 0){

                    sweetAlert.sweetSuccess("Se elminó el registro","El registro se ha eliminado de forma exitosa",()=>{

                        window.location.href = "./index_project.php";
                    });                    
                    
                }else{

                    sweetAlert.sweetError("No se eliminó el registro","Vuelve a intentarlo");
                }
            })
            .catch(e => {
                console.error(e);
            })
    }

    $("#eliminar").addEventListener("click",()=>{

        deleteProject();
    });

    $("#cancelar").addEventListener("click",()=>{

        window.location.href = "./index_project.php";
    });
    getData(idProyecto);
});