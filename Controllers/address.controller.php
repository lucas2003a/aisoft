<?php

require_once "../Models/Address.php";

if(isset($_POST["action"])){

    $address = new Address();

    switch($_POST["action"]){

        case "list": 
            
            $iddistrito = $_POST["iddistrito"];
            echo json_encode($address->list_addresses($iddistrito));
        
        break;

        case "list-ruc": 
            
            $rucObtained = $_POST["ruc"];

            echo json_encode($address->list_addresses_ruc($rucObtained));
        break;
    }
}
?>