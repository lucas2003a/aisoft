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
    }
}