<?php

require_once "Conection.php";

class Asset extends Conection{

    private $conection;

    public function __construct()
    {
        $this->conection = parent::getConection();
    }

    /**
     * Método para listar los activos por el idproyecto
     */
    public function listAssetProjectId($idproyecto = 0){

        try{

            $query = $this->conection->prepare("CALL spu_list_assets_short_idpr(?)");
            $query->execute(array($idproyecto));

            return $query->fetchAll(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para listar un activo por el idactivo
     */
    public function listAssetId($idactivo = 0){

        try{

            $query = $this->conection->prepare("CALL spu_list_assets_by_id(?)");
            $query->execute(array($idactivo));

            return $query->fetch(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para lista un activo por el idproyecto y el código del activo
     */
    public function listAssetPAcode($dataAsset = []){

        try{

            $query = $this->conection->prepare("CALL spu_list_assets_by_code(?,?)");
            $query->execute(
                array(
                    $dataAsset["idproyecto"],
                    $dataAsset["codigo"],
                )
            );

            return $query->fetchAll(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para listar los activos que están inactivos
     */
    public function listAssetDrop(){

        try{

            $query = $this->conection->prepare("CALL spu_list_inactive_assets()");
            $query->execute();

            return $query->fetchAll(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para listar los activos que está inactivos (por código)
     */
    public function listAssetDropCode($codigo = ""){

        try{

            $query = $this->conection->prepare("CALL spu_list_inactive_assets_by_code(?)");
            $query->execute(array($codigo));

            return $query->fetchAll(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para registrar un activo
     */
    public function addAsset($dataAsset = []){

        try{

            $query = $this->conection->prepare("CALL spu_add_assets(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            $query->execute(
                array(
                    $dataAsset["idproyecto"],
                    $dataAsset["tipo_activo"],
                    $dataAsset["imagen"],
                    $dataAsset["estado"],
                    $dataAsset["codigo"],
                    $dataAsset["sublote"],
                    $dataAsset["direccion"],
                    $dataAsset["moneda_venta"],
                    $dataAsset["area_terreno"],
                    $dataAsset["zcomunes_porcent"],
                    $dataAsset["partida_elect"],
                    $dataAsset["latitud"],
                    $dataAsset["longitud"],
                    $dataAsset["perimetro"],
                    $dataAsset["precio_venta"],
                    $dataAsset["det_casa"],
                    $dataAsset["idusuario"]
                )
            );

            return $query->fetch(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para actualizar un activo
     */
    public function setAsset($dataAsset = []){
         
        try{

            $query = $this->conection->prepare("CALL spu_set_assets(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            $query->execute(
                array(
                    $dataAsset["idactivo"],
                    $dataAsset["idproyecto"],
                    $dataAsset["tipo_activo"],
                    $dataAsset["imagen"],
                    $dataAsset["estado"],
                    $dataAsset["codigo"],
                    $dataAsset["sublote"],
                    $dataAsset["direccion"],
                    $dataAsset["moneda_venta"],
                    $dataAsset["area_terreno"],
                    $dataAsset["zcomunes_porcent"],
                    $dataAsset["partida_elect"],
                    $dataAsset["latitud"],
                    $dataAsset["longitud"],
                    $dataAsset["perimetro"],
                    $dataAsset["det_casa"],
                    $dataAsset["precio_venta"],
                    $dataAsset["idusuario"]
                )
            );

            return $query->fetch(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para "inactivar" un activo
     */
    public function inactiveAsset($idactivo = 0){

        try{

            $query = $this->conection->prepare("CALL spu_inactive_assets(?)");
            $query->execute(array($idactivo));

            return $query->fetch(PDO::FETCH_ASSOC);

        }catch(Exception $e){
            die($e->getMessage());
        }
    }

    /**
     * Método para recuperar un activo "inactivo"
     */
    public function restoreAsset($idactivo = 0){
         
        try{

            $query = $this->conection->prepare("CALL spu_restore_assets(?)");
            $query->execute(array($idactivo));

            return $query->fetch(PDO::FETCH_ASSOC);
            
        }catch(Exception $e){
            die($e->getMessage());
        }
    }
}
?>