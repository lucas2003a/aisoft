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

                echo json_encode($project->listProjectId($idProyecto));
            
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
            
                $today = date("dmYhis");
                
                $nombre_img = null;

                $dataObtained = [
                    "imagen"        =>  $nombre_img,
                    "iddireccion"   =>  $_POST["iddireccion"],
                    "codigo"        =>  $_POST["codigo"],
                    "denominacion"  =>  $_POST["denominacion"],
                    "latitud"       =>  $_POST["latitud"],
                    "longitud"      =>  $_POST["longitud"],
                    "perimetro"     =>  $_POST["perimetro"],
                    "iddistrito"    =>  $_POST["iddistrito"],
                    "direccion"     =>  $_POST["direccion"],
                    "idusuario"     =>  1
                    /* "idusuario"     =>  $_POST["idusuario"] */
                ];
                
                if(isset($_FILES["imagen"]) && $_FILES["imagen"]["size"] > 0){
                    
                    $nombre_img = sha1($today). ".jpg";
                    
                    $rutaImg =  "../logos_proyectos/" . $nombre_img;

                    if(move_uploaded_file($_FILES["imagen"]["tmp_name"],$rutaImg)){

                        $dataObtained["imagen"] = $nombre_img;
    
                    }

                }else{
                    
                    $dataObtained["imagen"] = $nombre_img;
                }
                

                echo json_encode($project->addProject($dataObtained));
            break;
        
        case "setProject": 
            
            $today = ("dmYhis");

            $nombre_img = null;

                $dataObtained = [
                    "idproyecto"    =>  $_POST["idproyecto"],
                    "imagen"        =>  $nombre_img,
                    "iddireccion"   =>  $_POST["iddireccion"],
                    "codigo"        =>  $_POST["codigo"],
                    "denominacion"   =>  $_POST["denominacion"],
                    "latitud"       =>  $_POST["latitud"],
                    "longitud"      =>  $_POST["longitud"],
                    "perimetro"     =>  $_POST["perimetro"],
                    "iddistrito"    =>  $_POST["iddistrito"],
                    "direccion"     =>  $_POST["direccion"],
                    "idusuario"     =>  1
                    /* "idusuario"     =>  $_POST["idusuario"] */
                ];
                
                if(isset($_FILES["imagen"]) && $_FILES["imagen"]["size"] > 0){
                    
                    $nombre_img = sha1($today) . ".jpg";

                    $ruta_img = "../logos_proyectos/". $nombre_img;

                    if(move_uploaded_file($_FILES["imagen"]["tmp_name"], $ruta_img)){

                        $dataObtained["imagen"] = $nombre_img;
                    }
                }
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