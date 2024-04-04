<?php

require_once "../Models/Asset.php";

if(isset($_POST["action"])){

    $asset = new Asset();

    switch($_POST["action"]){

        case "listAssetProjectId": 

                $idPObtained = $_POST["idproyecto"];

                echo json_encode($asset->listAssetProjectId($idPObtained));
            break;
        
        case "listAssetPAcode": 
            
                $dataObtained = [
                    "idproyecto"    =>  $_POST["idproyecto"],
                    "codigo"        =>  $_POST["codigo"]
                ];

                echo json_encode($asset->listAssetPAcode($dataObtained));
            break;

        case "listAssetId":
            
                $idactivo = $_POST["idactivo"];

                echo json_encode($asset->listAssetId($idactivo));

            break;

        case "listAssetDrop": 
            
                echo json_encode($asset->listAssetDrop());

            break;

        case "listAssetDropCode": 
            
                $codigo = $_POST["codigo"];

                echo json_encode($asset->listAssetDropCode($codigo));

            break;
        
        case "addAsset": 

            $today = date("dmYhis");
            $nom_img = null;
            
                $dataObtained = [
                    "idproyecto"    => $_POST["idproyecto"],
                    "tipo_activo"   => $_POST["tipo_activo"],
                    "imagen"        => $nom_img, //se tiene que modificar el proceso de subir una imagen
                    "estado"        => $_POST["estado"],
                    "codigo"        => $_POST["codigo"],
                    "sublote"       => $_POST["sublote"],
                    "direccion"     => $_POST["direccion"],
                    "moneda_venta"  => $_POST["moneda_venta"],
                    "area_terreno"  => $_POST["area_terreno"],
                    "zcomunes_porcent"  => $_POST["zcomunes_porcent"],
                    "partida_elect"     => $_POST["partida_elect"],
                    "latitud"       => $_POST["latitud"],
                    "longitud"      => $_POST["longitud"],
                    "perimetro"     => $_POST["perimetro"],
                    "det_casa"      => $_POST["det_casa"],
                    "precio_venta"  => $_POST["precio_venta"],
                    "idusuario"     => 1
                    /* "idusuario"     => $_POST["idusuario"] */
                ];

                if(isset($_FILES["imagen"]) && $_FILES["imagen"]["size"] > 0){

                    $nom_img = sha1($today) . "jpg";
                    $ruta_img = "../logos_proyectos/" . $nom_img;

                    if(move_uploaded_file($_FILES["imagen"]["tmp_name"], $ruta_img)){

                        $dataObtained["imagen"] = $nom_img;
                    }
                }else{

                    $dataObtained["imagen"] = $nom_img;
                }

                echo json_encode($asset->addAsset($dataObtained));
            break;

        case "setAsset": 

                $today = date("dmYhis");
                $nom_img = null;
            
                $dataObtained = [
                    "idactivo"      => $_POST["idactivo"],
                    "idproyecto"    => $_POST["idproyecto"],
                    "tipo_activo"   => $_POST["tipo_activo"],
                    "imagen"        => $nom_img, //se tiene que modificar el proceso de subir una imagen
                    "estado"        => $_POST["estado"],
                    "codigo"        => $_POST["codigo"],
                    "sublote"       => $_POST["sublote"],
                    "direccion"     => $_POST["direccion"],
                    "moneda_venta"  => $_POST["moneda_venta"],
                    "area_terreno"  => $_POST["area_terreno"],
                    "zcomunes_porcent"  => $_POST["zcomunes_porcent"],
                    "partida_elect"     => $_POST["partida_elect"],
                    "latitud"       => $_POST["latitud"],
                    "longitud"      => $_POST["longitud"],
                    "perimetro"     => $_POST["perimetro"],
                    "det_casa"      => $_POST["det_casa"],
                    "precio_venta"  => $_POST["precio_venta"],
                    "idusuario"     => 1
                    /* "idusuario"     => $_POST["idusuario"] */
                ];

                if(isset($_FILES["imagen"]) && $_FILES["imagen"]["size"] > 0){

                    $nom_img = sha1($today) . ".jpg";

                    $ruta_img = "../logos_proyectos/" . $nom_img;

                    if(move_uploaded_file($_FILES["imagen"]["tmp_name"], $ruta_img)){

                        $dataObtained["imagen"] = $nom_img;
                    }

                }else{

                    $dataObtained["imagen"] = $nom_img;
                }

                echo json_encode($asset->setAsset($dataObtained));

            break;
            
        case "inactiveAsset": 
            
                $idactivo = $_POST["idactivo"];
            
                echo json_encode($asset->inactiveAsset($idactivo));

            break;

        case "restoreAsset": 
            
                $idactivo = $_POST["idactivo"];

                echo json_encode($asset->restoreAsset($idactivo));
            
            break;
    }
}
?>