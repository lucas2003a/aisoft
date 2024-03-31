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
    };

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
    sendData(url, object){

        return fetch(url ,{
            method: "POST",
            body: object
        })
                .then(result=>result.json())
                .catch(e=>{
                    /* console.error(e); */
                    throw e;
                })
    };
   
    /**
     * GETSON RETORNA UN JSON EN BASE A DOS CLASES
     * @param {string} keyClass 
     * @param {string} valueClass 
     * @returns 
     */
    getJson(keyClass, valueClass){

        let formKeys = document.querySelectorAll(keyClass);
        let formValues = document.querySelectorAll(valueClass);
        /* let fomrKeys = document.querySelectorAll(".form-control.perim-key");
        let formValues = document.querySelectorAll(".form-control.perim-value"); */

        let dataJson ={
            "clave": [],
            "valor": []
        };

        //INDEX SE CREA DE FORMA AUTOMATICA ES EL INDICE DE LA ITERACIÓN
        Array.from(formKeys).forEach((keyInput, index)=>{
            let key = keyInput.value.trim();

            let indexValue = formValues[index]; //=>ASIGANMOS EL "VALOR" CORRESPONDIENTE AL INDICE DE LA ITERACION(GUARDA LA RELACIÓN KEY => VALUE)

            let value = indexValue.value.trim();

            dataJson.clave[index] = key;
            dataJson.valor[index] = value;
        });

        return JSON.stringify(dataJson);
    }


    /**
     * GET OBTIENE LOS DATOS DE UNA URL ESPECIFICANDO LA ACCION
     * @param {string} url 
     * @param {string} action 
     * @returns 
     */
    getData(url,action){

        let params = new FormData();

        params.append("action",action);

        return fetch(url,{
            method: "POST",
            body: params
        })
                .then(result => result.json())
                .catch(e=>{

                    throw e;
                });

    }

    /**
     * SENDACTION OBTIENE DATOS ENVIANDOLE UNA URL Y UN OBJETO
     * @param {string} url 
     * @param {object} object 
     * @returns 
     */
    sendAction(url, object){

        return fetch(url,{
            method: "POST",
            body: object
        })
                .then(result => result.json())
                .catch(e=>{

                    throw e;
                });

    }

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