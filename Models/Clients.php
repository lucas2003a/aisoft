<?php

require_once "Conection.php";

class Clients extends Conection{

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
    public function addCllient($dataClient = []){

        try{

            $query = $this->conection->prepare("");

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * 
     */
    public function (){

        try{

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * 
     */
    public function (){

        try{

        }catch(Exception $e){
            die($e->getMessage());
        }
    }
}

?>