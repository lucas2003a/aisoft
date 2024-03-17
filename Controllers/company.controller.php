<?php

require_once "../Models/Company.php";

if(isset($_POST["action"])){

    $company = new Company();

    switch($_POST["action"]){

        case "list": 
            
            echo json_encode($company->list_companies());

        break;

        case "list-ruc": 

            $rucObtained = $_POST["ruc"];

            echo json_encode($company->list_companies_ruc($rucObtained));

        break;
    }
}
?>