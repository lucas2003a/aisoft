document.addEventListener("DOMContentLoaded",()=>{
    
    //INSTANCIA PARA LAS ALERTAS
    const sweetAlert = new Alert();

    //INSTACIA DE LA CASE DATA
    const data = new Data();

    const $ = id => document.querySelector(id);

    let Patern = $("#patern");
    let viewImage = $("#file-input");

    /**
     * Función que verifica los campos vacíos
     */
    function checkValues(array){
        let hasValue = false;


        array.forEach(element =>{

            if(element.value != ""){
                hasValue = true;

            }else{

                hasValue = false;
                
                //GENERA LA ALERTA
                sweetAlert.sweetError("Campos vacíos","Debes de completa todos los campos");
            }
        });

        return hasValue;
    }

    /**
     * FUNCIÓN PARA CREAR INPUTS
     */
    function renderInputs(){
        
        //BOTÓN "+" Y SU CONTENEDOR
        let buttonPluss = document.createElement("Button");
        buttonPluss.classList.add("button-addPlus","mt-2","active");
        buttonPluss.setAttribute("id","add-textBox");
        buttonPluss.setAttribute("type","button");
        buttonPluss.innerText = "+";

        let contentButton = document.createElement("div");
        contentButton.classList.add("col-md-1");

        contentButton.appendChild(buttonPluss); //=> SE AGREGA AL CONTENEDOR

        // DIV ROW{DIV(COL-MD-11) - DIV(CONTENT BUTTON)}
        let dataPerim = document.createElement("div");
        dataPerim.classList.add("row");

        //CONTENEDOR (LLAVE)
        let containerKey = document.createElement("div");
        containerKey.classList.add("col-md-6","mt-2");
        
        //CAJA DE TEXTO PARA LA CLAVE NUEVA EN EL INPUT
        let newInputKey = document.createElement("input");
        newInputKey.classList.add("form-control","perim-key"); 

        containerKey.appendChild(newInputKey);  //=> SE AGREGA EL INPUT AL CONTENEDOR

        //CONTENDEDOR (VALOR)
        let containerValue = document.createElement("div");
        containerValue.classList.add("col-md-6","mt-2");        
        
        //CAJA DE TEXTO PARA EL NUEVO VALOR EN EL INPUT
        let newInputValue = document.createElement("input");
        newInputValue.classList.add("form-control","perim-value");

        containerValue.appendChild(newInputValue);  //=> SE AGREGA EL INPUT AL CONTENEDOR

        //ROW (CONTIENE A LOS CONTENEDORES DE LLAVES Y VALORES)
        let row = document.createElement("div");
        row.classList.add("row");

        row.appendChild(containerKey);
        row.appendChild(containerValue);

        //CONTENEDOR PADRE
        let divPatern = document.createElement("div");
        divPatern.classList.add("col-md-11");                   
     
        divPatern.appendChild(row); //SE AGREAGA EL ROW DE CONTENEDORES AL ULTIMO DIV

        dataPerim.appendChild(divPatern);
        dataPerim.appendChild(contentButton);

        Patern.appendChild(dataPerim); //SE AGREGA AL CONTENEDOR PADRE (DEFINIDO AL INICIO)

    }

    /**
     * FUNCIÓN QUE REEMPLAZA AL BOTON "+" POR "-"
     */
    function replaceButton(event){

        if(event.target.classList.contains("button-addPlus")){
            event.target.classList.remove("button-addPlus");

            event.target.classList.add("button-less");
            event.target.innerText = "-";
        }
    }

    /**
     * FUNCIÓN PARA ELIMINAR INPUTS
     */
    function dropInputs(event){

        let row = event.target.closest(".row"); //=> OTBTIENE EL CONTEDOR ANCESTRO MÁS PRÓXIMO

        row.remove();   //=> LO ELIMINA
    }

    /**
     * FUNCION PARA LEER LA IMAGEN
     */
    function readFile(event){

        const file = event.target.files[0];
        const reader = new FileReader();

        reader.onload = (event)=>{

            //ESTABLECE LA RUTA DE LA IMAGEN (RUTA TEMPORAL)
            viewImage.setAttribute("src",`${event.target.result}`);
            viewImage.style.width = "100%";
            viewImage.style.height = "20rem";

        };

        reader.readAsDataURL(file);
    }



    $("#in-image").addEventListener("change",(e)=>{

        console.log(e);
        if(e.target.files.length > 0){
            
            console.log(e);
            readFile(e);
            $("#see-image").setAttribute("style","display: show;");
        }
    });

    $("#see-image").addEventListener("click",()=>{

        $(".modal-form").classList.add("show");

    });
    
    $("#close").addEventListener("click", ()=>{

        $(".modal-form").classList.remove("show");

    });

    $("#perim").addEventListener("click",(e)=>{

        if(e.target.classList.contains("button-addPlus")){
            
            //ITERACIÓN POR CADA INPUT (CLAVE)
            let perimDataKey = document.querySelectorAll(".form-control.perim-key");
            let dataKey = Array.from(perimDataKey);
            let returnKey = checkValues(dataKey); 
    
            //ITERACIÓN POR CADA INPUT (CLAVE)
            let perimDataValue = document.querySelectorAll(".form-control.perim-value");
            let dataValue = Array.from(perimDataValue);
            let returnValue = checkValues(dataValue);
    
            if(returnKey && returnValue){
                renderInputs();
                replaceButton(e);
            }
        
        }else if(e.target.classList.contains("button-less")){

            let ask = "¿Seguro de borrar los atributos?";
            let alert = "No se podrán recuperar una vez ejecutado";

            sweetAlert.sweetConfirm(ask,alert,()=>{
                dropInputs(e);
            });
        }

    });


    renderDepartaments();

});