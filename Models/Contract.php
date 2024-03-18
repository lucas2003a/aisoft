<?php

require_once "../Models/Conection.php";

class Contract extends Conection{

    private $conection;

    public function __construct()
    {
        $this->conection = parent::getConection();
    }

    /**
     * Método para listar el constrato completo por el idcontrato
     */
    public function listContractId($idcontrato = 0){

        try{

            $query = $this->conection->prepare("CALL spu_lits_contracts_full_by_id(?)");
            $query->execute(array($idcontrato));

            return $query->fetch(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para registrar un contrato
     */
    public function addContract($dataContract = []){

        try{

            $query = $this->conection->prepare("CALL spu_add_contracts(?,?,?,?,?,?,?,?,?)");
            $query->execute(
                array(
                    $dataContract["idcliente"],
                    $dataContract["idconyugue"],
                    $dataContract["idrepresentante_primario"],
                    $dataContract["idrepresentante_secundario"],
                    $dataContract["tipo_cambio"],
                    $dataContract["estado"],
                    $dataContract["detalles"],
                    $dataContract["fecha_contrato"],
                    $dataContract["idusuario"]
                )
            );

            return $query->fetch(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para actualizar un contrato
     */
    public function setContract($dataContract = []){

        try{

            $query = $this->conection->prepare("CALL spu_set_contracts(?,?,?,?,?,?,?,?,?,?)");
            $query->execute(
                array(
                    $dataContract["idcontrato"],
                    $dataContract["idcliente"],
                    $dataContract["idconyugue"],
                    $dataContract["idrepresentante_primario"],
                    $dataContract["idrepresentante_secundario"],
                    $dataContract["tipo_cambio"],
                    $dataContract["estado"],
                    $dataContract["detalles"],
                    $dataContract["fecha_contrato"],
                    $dataContract["idusuario"]
                )
            );

            return $query->fetch(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para inactivar un contrato
     */
    public function inactiveContract($idcontrato = 0){

        try{
            
            $query = $this->conection->prepare("CALL spu_inactive_contracts(?)");
            $query->execute(array($idcontrato));

            return $query->fetch(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para listar los detalles de un contrato por el idactivo
     */
    public function listDetContract($idactivo = 0){

        try{

            $query = $this->conection->prepare("CALL CALL spu_list_det_contracts(?)");
            $query->execute(array($idactivo));

            return $query->fetchAll(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para registrar un nuevo detalle a los detalles del contrato
     */
    public function addDetContract($dataDetCont = []){

        try{

            $query = $this->conection->prepare("CALL spu_add_det_contracts(?,?,?)");
            $query->execute(
                array(
                    $dataDetCont["idactivo"],
                    $dataDetCont["idcontrato"],
                    $dataDetCont["idusuario"]
                )
            );

            return $query->fetch(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para actualizar los registros del detalle de los contratos
     */
    public function setDetContract($dataDetCont = []){

        try{

            $query = $this->conection->prepare("CALL spu_set_det_contracts(?,?,?,?)");
            $query->execute(
                array(
                    $dataDetCont["iddetalle_contrato"],
                    $dataDetCont["idactivo"],
                    $dataDetCont["idcontrato"],
                    $dataDetCont["idusuario"]
                )
            );

            return $query->fetch(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para inactivar un registro del detalle de los contratos
     */
    public function inactiveDetCont($iddetalle_contrato = 0){

        try{

            $query = $this->conection->prepare("CALL spu_inactive_det_contracts(?)");
            $query->execute(array($iddetalle_contrato));

            return $query->fetch(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }
}

?>