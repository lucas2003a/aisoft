<?php

require_once "../Models/Address.php";

if(isset($_POST["action"])){

    $address = new Address();

    switch($_POST["action"]){

        case "list": 
        
            echo json_encode($address->list_addresses());
        
        break;

        case "list-ruc": 
            
            $rucObtained = $_POST["ruc"];

            echo json_encode($address->list_addresses_ruc($rucObtained));
        break;
    }
}
?>