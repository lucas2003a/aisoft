<?php

require_once "../../Models/ubigeo/Distrito.php";

if(isset($_POST["action"])){

    $dist = new Distrito();

    switch($_POST["action"]){

        case "list": 
            
            $idprovincia = $_POST["idprovincia"];

            echo json_encode($dist->list_districts($idprovincia));
        break;
    }
}
?>