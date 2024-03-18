<?php

require_once "../Models/Client.php";

if(isset($_POST["action"])){

    $client = new Client();

    switch($_POST["action"]){

        case "listClient": 
            
                echo json_encode($client->listClients());
            
            break;

        case "listClientDnro": 
            
                $documento_nro = $_POST["documento_nro"];

                echo json_encode($client->listClientsDnro($documento_nro));
            
            break;

        case "listClientDrop": 
            
                echo json_encode($client->listInactiveClients());
            
            break;
        
        case "listClientDropDnro":
            
                $documento_nro = $_POST["documento_nro"];

                echo json_encode($client->listInactiveClientsDnro($documento_nro));

            break;

        case "addClient": 
            
                $dataObtained = [

                    "nombres"         => $_POST["nombres"],
                    "apellidos"       => $_POST["apellidos"],
                    "documento_tipo"  => $_POST["documento_tipo"],
                    "documento_nro"   => $_POST["documento_nro"],
                    "estado_civil"    => $_POST["estado_civil"],
                    "iddistrito"      => $_POST["iddistrito"],
                    "direccion"       => $_POST["direccion"],
                    "idusuario"       => $_POST["idusuario"]
                    
                ];

                echo json_encode($client->addClient($dataObtained));
            
            break;

        case "setClient": 
            
                $dataObtained = [

                    "idcliente"       => $_POST["idcliente"],
                    "nombres"         => $_POST["nombres"],
                    "apellidos"       => $_POST["apellidos"],
                    "documento_tipo"  => $_POST["documento_tipo"],
                    "documento_nro"   => $_POST["documento_nro"],
                    "estado_civil"    => $_POST["estado_civil"],
                    "iddistrito"      => $_POST["iddistrito"],
                    "direccion"       => $_POST["direccion"],
                    "idusuario"       => $_POST["idusuario"]
                    
                ];
                
                echo json_encode($client->setClient($dataObtained));

            break;

        case "inactiveClient": 
            
                $idcliente = $_POST["idcliente"];

                echo json_encode($client->inactiveClient($idcliente));

            break;

        case "restoreClient": 
            
                $idcliente = $_POST["idcliente"];

                echo json_encode($client->restoreClient($idcliente));

            break;
    }
}
?>