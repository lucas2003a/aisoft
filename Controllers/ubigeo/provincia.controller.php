<?php

require_once "../../Models/ubigeo/Provincia.php";

if(isset($_POST["action"])){

    $prov = new Provincia();

    switch ($_POST["action"]){

        case "list": 
        
            $iddepartamento = $_POST["iddepartamento"];

            echo json_encode($prov->list_provinces($iddepartamento));
        break;
    }
}
?>