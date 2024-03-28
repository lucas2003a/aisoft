class Data{

    /**
     * getDepartaments retorna la data de todos los departamentos
     * @returns 
     */
    getDepartaments(){

        let params = new FormData();

        params.append("action","list");

        return fetch(`../../Controllers/ubigeo/departament.controller.php`,{

            method: "POST",
            body: params
        })
                .then(result => result.json())
                .catch(e=>{
                    console.error(e);
                    throw e;
                })
    };

    /**
     * getProvinces retorna toda la data de las provincias
     * @param {number} iddep 
     * @returns 
     */
    getProvinces(iddep){

        let params = new FormData();

        params.append("action","list");
        params.append("iddepartamento",iddep);

        return fetch(`../../Controllers/ubigeo/province.controller.php`,{

            method: "POST",
            body: params
        })
                .then(result=>result.json())
                .catch(e=>{
                    console.error(e);
                    throw e;
                });
    }

    /**
     * getDistrictis obtiene toda la data de los distritos
     * @param {number} idprov 
     * @returns 
     */
    getDistricts(idprov){

        let params = new FormData();
        
        params.append("action","list");
        params.append("idprovincia",idprov);

        return fetch(`../../Controllers/ubigeo/district.controller.php`,{
            method: "POST",
            body: params
        })
                .then(result=> result.json())
                .catch(e=>{
                    console.error(e);
                    throw e;
                });
    };

    /**
     * getSede retorna la data de todas las sedes
     * @param {number} iddis 
     * @returns 
     */
    getSede(iddis){

        let params = new FormData();

        params.append("action","list");
        params.append("iddistrito",iddis);

        return fetch(`../../Controllers/address.controller.php`,{

            method: "POST",
            body: params
        })
            .then(result => result.json())
            .catch(e=>{
                console.error(e);
                throw e;    //=>LANZA EL ERROR PARA MANEJARLO DE FORMA EXTERNA
            });
    };

    /**
     * sendData envia los datos (REGISTRO O ACTUALIZACIÓN)
     * @param {object} object 
     */
    sendData(object){

        return fetch(`../../Controllers/project.controller.php`,{
            method: "POST",
            body: object
        })
                .then(result=>result.json())
                .catch(e=>{
                    console.error(e);
                    throw e;
                })
    };

        /*
        getProvinces(iddep){

        let params = new FormData();

        return fetch(`../../Controllers/  .controller.php`,{
            method: "POST",
            body: params
        })
                .then()
                .catch();
    }
    */

}