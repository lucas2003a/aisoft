    
    const $ = id => document.querySelector(id);
    /**
     * FUNCÓN PARA RENDERIZAR LOS DEPARTAMENTOS
     */
    function renderDepartaments(){

        data.getDepartaments()
        .then(
            departamens=>{
                    departamens.forEach(departamen=>{
                        
                        let newOption = document.createElement("option");
                        newOption.value = departamen.iddepartamento; 
                        newOption.innerText = departamen.departamento;
                        
                        $("#iddepartamento").appendChild(newOption);
                    });
                }
            )
    }
    
    /**
     * FUNCÓN PARA RENDERIZAR LAS PROVINCIAS
     */
    function renderProvinces(){

        let idDepartamento = $("#iddepartamento").value;

        data.getProvinces(idDepartamento)
            .then(
                provinces =>{

                    provinces.forEach(province =>{
                        let newOption = document.createElement("option");
                        newOption.value = province.idprovincia; 
                        newOption.innerText = province.provincia;
                        
                        $("#idprovincia").appendChild(newOption);
                    });
                }
            )
            .catch(e=>{
                console.error(e);
            })
    };

     /**
     * FUNCIÓN PARA RENDERIZAR LOS DISTRITOS
     */
    function renderDistricts(){

        let idProvincia = $("#idprovincia").value;

        data.getDistricts(idProvincia)
            .then(
                districts =>{

                    districts.forEach(district =>{
                        let newOption = document.createElement("option");
                        newOption.value = district.iddistrito; 
                        newOption.innerText = district.distrito;
                        
                        $("#iddistrito").appendChild(newOption);
                    });
                }
            )
            .catch(e=>{
                console.error(e);
            })
    };

    /**
     * FUNCIÓN PARA RENDERIZAR LAS SEDES
     */
    function renderSedes(){

        let idDistrito = $("#iddistrito").value;

        data.getSede(idDistrito)
            .then(
                addresses =>{
                    addresses.forEach(address=>{
                        let newOption = document.createElement("option");
                        newOption.value = address.iddireccion;
                        newOption.innerText = address.direccion;

                        $("#iddireccion").appendChild(newOption);
                    });
                }
            ).catch(e=>{
                console.error(e);
            })
    };

    /**
     * FUNCIÓN PARA RESETEAR LOS INPUTS
     */
    function resetSelect(id,text, callback){
        
        $(id).innerHTML = "";

        const defaultOption = document.createElement("option");
        defaultOption.value = ""; 
        defaultOption.innerText = text;
        
        $(id).appendChild(defaultOption);

        callback();
    }

    $("#iddistrito").addEventListener("change",()=>{

        resetSelect("#iddireccion","Sedes",renderSedes);
    });

    $("#idprovincia").addEventListener("change",()=>{
        
        resetSelect("#iddistrito","Distritos",renderDistricts);
    });

    $("#iddepartamento").addEventListener("change",()=>{
        
        resetSelect("#idprovincia","Provincias",renderProvinces);
    });