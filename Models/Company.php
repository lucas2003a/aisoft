<?php

require_once "Conection.php";

class Company extends Conection{

    private $conection;

    public function __construct()
    {
        $this->conection = parent::getConection();
    }

    /**
     * Método para listar todas las empresas
     */
    public function list_companies(){

        try{

            $query = $this->conection->prepare("CALL spu_list_companies()");
            $query->execute();

            return $query->fetchAll(PDO::FETCH_ASSOC);
        }
        catch(Exception $e){

            die($e->getMessage());

        }
    }

    /**
    * Método para listar las empresas por RUC
    */
    public function list_companies_ruc($ruc = ""){

        try{

            $query = $this->conection->prepare("CALL spu_list_companies_ruc(?)");
            $query->execute(array($ruc));

            return $query->fetchAll(PDO::FETCH_ASSOC);
        }
        catch(Exception $e){

            die($e->getMessage());

        }
    }
}
?>