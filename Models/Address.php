<?php

require_once "Conection.php";

class Address extends Conection{

    private $conection;

    public function __construct()
    {
        $this->conection = parent::getConection();
    }

    /**
     * Método para devolver las DIRECCIONES de una empresas
     */
    public function list_addresses($iddistrito = 0){

        try{

            $query = $this->conection->prepare("CALL spu_list_addresses(?)");
            $query->execute(array($iddistrito));

            return $query->fetchAll(PDO::FETCH_ASSOC);
        }
        catch(Exception $e){

            die($e->getMessage());
        }
    }

    /**
     * Método para devolver las DIRECCIONES de una empresas POR SU RUC
     */
    public function list_addresses_ruc($ruc = ""){

        try{

            $query = $this->conection->prepare("CALL spu_list_addresses_ruc(?)");
            $query->execute(array($ruc));

            return $query->fetchAll(PDO::FETCH_ASSOC);
        }
        catch(Exception $e){

            die($e->getMessage());
        }
    }
}
?>