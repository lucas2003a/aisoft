<?php

require_once "../Models/Project.php";

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

                $dataObtained = [
                    "idproyecto"    => $_POST["idproyecto"],
                    "tipo_activo"   => $_POST["tipo_activo"],
                    "imagen"        => $_POST["imagen"], //se tiene que modificar el proceso de subir una imagen
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
                    "idusuario"     => $_POST["idusuario"]
                ];

                echo json_encode($asset->addAsset($dataObtained));
            break;

        case "setAsset": 
            
                $dataObtained = [
                    "idactivo"      => $_POST["idactivo"],
                    "idproyecto"    => $_POST["idproyecto"],
                    "tipo_activo"   => $_POST["tipo_activo"],
                    "imagen"        => $_POST["imagen"], //se tiene que modificar el proceso de subir una imagen
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
                    "idusuario"     => $_POST["idusuario"]
                ];

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