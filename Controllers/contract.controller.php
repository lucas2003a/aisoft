<?php

require_once "../Models/Contract.php";

if(isset($_POST["action"])){

    $contract = new Contract();

    switch($_POST["action"]){

        case "listContractId": 

                $idcontrato = $_POST["idcontrato"];

                echo json_encode($contract->listContractId($idcontrato));

            break;

        case "addContract": 
            
                $dataObtained = [

                    "idcliente"                 => $_POST["idcliente"],
                    "idconyugue"                => $_POST["idconyugue"],
                    "idrepresentante_primario"  => $_POST["idrepresentante_primario"],
                    "idrepresentante_secundario" => $_POST["idrepresentante_secundario"],
                    "tipo_cambio"       => $_POST["tipo_cambio"],
                    "estado"            => $_POST["estado"],
                    "detalles"          => $_POST["detalles"],
                    "fecha_contrato"    => $_POST["fecha_contrato"],
                    "idusuario"         => $_POST["idusuario"]
                ];
                
                echo json_encode($contract->addContract($dataObtained));
            break;

        case "setContract": 
            
                $dataObtained = [

                    "idcontrato"                => $_POST["idcontrato"],
                    "idcliente"                 => $_POST["idcliente"],
                    "idconyugue"                => $_POST["idconyugue"],
                    "idrepresentante_primario"  => $_POST["idrepresentante_primario"],
                    "idrepresentante_secundario" => $_POST["idrepresentante_secundario"],
                    "tipo_cambio"       => $_POST["tipo_cambio"],
                    "estado"            => $_POST["estado"],
                    "detalles"          => $_POST["detalles"],
                    "fecha_contrato"    => $_POST["fecha_contrato"],
                    "idusuario"         => $_POST["idusuario"]
                ];

                echo json_encode($contract->setContract($dataObtained));

            break;
        
        case "inactiveContract": 

                $idcontratoo = $_POST["idcontrato"];

                echo json_encode($contract->inactiveContract($idcontrato));

            break;
        
        case "listDetContract": 
            
                $idactivo = $_POST["idactivo"];

                echo json_encode($contract->listDetContract($idactivo));

            break;

        case "addDetContract": 
            
                $dataObtained = [

                    "idactivo"      => $_POST["idactivo"],
                    "idcontrato"    => $_POST["idcontrato"],
                    "idusuario"     => $_POST["idusuario"]
                ];

                echo json_encode($contract->addDetContract($dataObtained));
            
            break;
        
        case "setDetContract": 
            
                $dataObtained = [

                    "iddetalle_contrato"      => $_POST["iddetalle_contrato"],
                    "idactivo"      => $_POST["idactivo"],
                    "idcontrato"    => $_POST["idcontrato"],
                    "idusuario"     => $_POST["idusuario"]
                ];

                echo json_encode($contract->setDetContract($dataObtained));

            break;

        case "inactiveDetCont": 
            
                $iddetalle_contrato = $_POST["iddetalle_contrato"];

                echo json_encode($contract->inactiveDetCont($iddetalle_contrato));

            break;
    }
}
?>