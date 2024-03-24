<?php

require_once "../Models/Project.php";

if(isset($_POST["action"])){

    $project = new Project();

    switch($_POST["action"]){

        case "listProject": 
            
                echo json_encode($project->listProject());
            
            break;
        case "listProjectId": 
            
                $idProyecto = $_POST["idproyecto"];

                echo json_encode($project->listProject($idProyecto));
            
            break;
        
        case "listProjectCode": 

                $codeObtained = $_POST["codigo"];

                echo json_encode($project->listProjectCode($codeObtained));
            break;
        
        case "listProjectDrop": 

                echo json_encode($project->listProjectDrop());
            break;
        
        case "listProjectDrop": 
            
                $codeObtained = $_POST["codigo"];

                echo json_encode($project->listProjectDropCode($codeObtained));
            break;

        case "addProject": 
            
                $dataObtained = [
                    "imagen"        =>  $_POST["imagen"],
                    "iddireccion"   =>  $_POST["iddireccion"],
                    "codigo"        =>  $_POST["codigo"],
                    "denominacion"  =>  $_POST["denominacion"],
                    "latitud"       =>  $_POST["latitud"],
                    "longitud"      =>  $_POST["longitud"],
                    "perimetro"     =>  $_POST["perimetro"],
                    "iddistrito"    =>  $_POST["iddistrito"],
                    "direccion"     =>  $_POST["direccion"],
                    "idusuario"     =>  $_POST["idusuario"]
                ];

                echo json_encode($project->addProject($dataObtained));
            break;
        
        case "setProject": 
            
                $dataObtained = [
                    "idproyecto"    =>  $_POST["idproyecto"],
                    "imagen"        =>  $_POST["imagen"],
                    "iddireccion"   =>  $_POST["iddireccion"],
                    "codigo"        =>  $_POST["codigo"],
                    "denominacion"   =>  $_POST["denominacion"],
                    "latitud"       =>  $_POST["latitud"],
                    "longitud"      =>  $_POST["longitud"],
                    "perimetro"     =>  $_POST["perimetro"],
                    "iddistrito"    =>  $_POST["iddistrito"],
                    "direccion"     =>  $_POST["direccion"],
                    "idusuario"     =>  $_POST["idusuario"]
                ];
                
                echo json_encode($project->setProject($dataObtained));
            break;
        
        case "inactiveProject": 
            
                $idproyecto = $_POST["idproyecto"];

                echo json_encode($project->inactiveProject($idproyecto));
            break;

        case "restoreProject": 

                $idproyecto = $_POST["idproyecto"];

                echo json_encode($project->restoreProject($idproyecto));
            break;
    }
}
?>