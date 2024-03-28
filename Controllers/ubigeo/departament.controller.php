<?php

require_once "../../Models/ubigeo/Departamento.php";

if(isset($_POST["action"])){

    $dept = new Departamento();

    switch ($_POST["action"]){

        case "list":

            echo json_encode($dept->list_departament());
        break;
    }
}
?>