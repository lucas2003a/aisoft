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

    alertSucces(mss,text,timer){
        Swal.fire({
            title: mss,
            text: text,
            icon: "success",
            showConfirmButton: false,
            timer: timer
          });
    }
}