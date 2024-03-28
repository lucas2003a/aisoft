class Alert{

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

    sweetConfirm(ask, alert, callback){

        Swal.fire({
            title: ask,
            text: alert,
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#FF284A",
            cancelButtonColor: "#003473",
            confirmButtonText: "Si, seguro!",
            cancelButtonText: "No"
          }).then((result) => {
            if (result.isConfirmed) {
                
                if(callback && typeof(callback) == "function"){
                    callback(event);
                }
                Swal.fire({
                  title: "Borrado!",
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
            confirmButton: "Si",
            cancelButton: "No",
            showCancelButton: true,
          }).then(result=>{

              if(result.isConfirmed){
                callback()
              }else{
                resetCallback()
              }
          });
    }
}