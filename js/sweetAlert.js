class Alert{

    /**
     * MUESTRA MENSAJE DE ERROR
     * @param {string} text 
     * @param {string} footer 
     */
    sweetError(text, footer){
        
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: text,
            footer: footer,
            showConfirmButton: false,
            timer:  1500
          });
    };

    /**
     * MUESTRA MENSAJE DE "SUCCESS"
     * @param {string} text 
     * @param {string} footer 
     * @param {function} callback 
     */
    sweetSuccess(text, footer, callback){
        
        Swal.fire({
            icon: "success",
            title: "Éxito",
            text: text,
            footer: footer,
            showConfirmButton: false,
            timer:  1500,
            timerProgressBar: true, //MUESTRA UNA BARRA DE PROGRESO
            didClose: () =>{ //CUANDO ACABE EL TIEMPO O CIERRE EL MODAL

              if(typeof(callback) == "function"){

                callback();
              }
            }
          });
    };
    
    /**
     * MUESTRA UN ALERTA TIPO WARNING
     * @param {string} text 
     * @param {string} footer 
     */
    sweetWarning(text, footer){
        
      Swal.fire({
          icon: "info",
          title: "Oops...",
          text: text,
          footer: footer,
          showConfirmButton: false,
          timer:  3500
        });
  };

    /**
     * MUESTTRA MENSAJE DE ÉXITO CON PREGUNTA
     * @param {string} ask 
     * @param {string} alert 
     * @param {function} callback 
     */
    sweetConfirm(ask, alert, callback){

        Swal.fire({
            title: ask,
            text: alert,
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#003473",
            cancelButtonColor: "#FF284A",
            confirmButtonText: "Si, seguro!",
            cancelButtonText: "No"
          }).then((result) => {
            if (result.isConfirmed) {
                
                if(callback && typeof(callback) == "function"){
                    callback();
                }
                Swal.fire({
                  title: "Bien hecho!",
                  text: "La operación se ha logrado ejecutar",
                  icon: "success",
                  showConfirmButton: false,
                  timer: 1500
                });
            }    
        });
    };

    /**
     * ALERTA DE EXITO QUE PIDE CONFIRMAR PARA REALIZAR UNA TAREA
     * @param {string} mss 
     * @param {string} text 
     * @param {function} callback 
     * @param {function} resetCallback 
     */
    sweetConfirmAdd(mss,text,callback,resetCallback){
        Swal.fire({
            title: mss,
            text: text,
            icon: "success",
            showConfirmButton: true,
            confirmButtonText: "Si",
            cancelButtonText: "No",
            showCancelButton: true,
            confirmButtonColor: "#FF284A",
            cancelButtonColor: "#003473",
          }).then(result=>{

              if(result.isConfirmed){
                callback()
              }else{
                resetCallback()
              }
          });
    }
}