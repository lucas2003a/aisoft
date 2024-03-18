<?php

require_once "Conection.php";

class Client extends Conection{

    private $conection;

    public function __construct()
    {
        $this->conection = parent::getConection();
    }

    /**
     * Método para listar los clientes activos
     */
    public function listClients(){

        try{

            $query = $this->conection->prepare("spu_list_clients()");
            $query->execute();

            return $query->fetchAll(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Métodos para listar los clientes por su número de documento
     */
    public function listClientsDnro($documento_nro = ""){

        try{

            $query = $this->conection->prepare("CALL spu_list_clients_by_docNro(?)");
            $query->execute(array($documento_nro));

            return $query->fetchAll(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para listar los clientes inactivos
     */
    public function listInactiveClients(){

        try{

            $query = $this->conection->prepare("CALL spu_list_inactive_clients()");
            $query->execute();

            return $query->fetchAll(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para listar a los clientes inactivos por nro de documento
     */
    public function listInactiveClientsDnro($documento_nro = ""){

        try{

            $query = $this->conection->prepare("CALL spu_list_inactive_clients_docNro(?)");
            $query->execute(array($documento_nro));

            return $query->fetchAll(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para registrar cliente
     */
    public function addClient($dataClient = []){

        try{

            $query = $this->conection->prepare("CALL spu_add_clients(?,?,?,?,?,?,?,?)");
            $query->execute(
                array(
                    $dataClient["nombres"],
                    $dataClient["apellidos"],
                    $dataClient["documento_tipo"],
                    $dataClient["documento_nro"],
                    $dataClient["estado_civil"],
                    $dataClient["iddistrito"],
                    $dataClient["direccion"],
                    $dataClient["idusuario"]
                )
            );

            return $query->fetch(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para actualizar los registros de un cliente
     */
    public function setClient($dataClient = []){

        try{

            $query = $this->conection->prepare("spu_set_clients(?,?,?,?,?,?,?,?,?)");
            $query->execute(
                array(
                    $dataClient["idcliente"],
                    $dataClient["nombres"],
                    $dataClient["apellidos"],
                    $dataClient["documento_tipo"],
                    $dataClient["documento_nro"],
                    $dataClient["estado_civil"],
                    $dataClient["iddistrito"],
                    $dataClient["direccion"],
                    $dataClient["idusuario"]
                )
            );

            return $query->fetch(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para inactivar a un cliente
     */
    public function inactiveClient($idcliente = 0){
        
        try{

            $query = $this->conection->prepare("CALL spu_inactve_clients(?)");
            $query->execute(array($idcliente));

            return $query->fetch(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para recuperar a un cliente inactivo(eliminado)
     */
    public function restoreClient($idcliente = 0){

        try{

            $query = $this->conection->prepare("CALL spu_restore_clientes(?)");
            $query->execute(array($idcliente));

            return $query->fetch(PDO::FETCH_ASSOC);
            
        }catch(Exception $e){
            die($e->getMessage());
        }
    }
}

?>