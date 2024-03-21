document.addEventListener("DOMContentLoaded",()=>{

    //DESPLEGAR EL MENÚ

    const $ = id => document.querySelector(id);

    const HButton = $("#HButton");
    const navbar = $("#nav-bar");

    HButton.addEventListener("click", ()=>{
        navbar.classList.toggle("open");
        //console.log(navbar.style);
    });

    const dropdown = document.getElementsByName("dropdown-btn");

    let indice;

    for(indice = 0; indice < dropdown.length; indice++){

        dropdown[indice].addEventListener("click",function(){

            this.classList.toggle("active");

            const dropdownContent = this.nextElementSibling;
            /*Obitiene el contenido del botón*/

            if(dropdownContent.style.display == "block"){

                dropdownContent.style.display = "none";

            }else{

                dropdownContent.style.display = "block";
            }
        }); 
    }


})