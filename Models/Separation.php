<?php

require_once "Conection.php";

class Separation extends Conection{

    private $conection;

    public function __construct()
    {
        $this->conection = parent::getConection();
    }

    public function listByIdAsset($idactivo = 0){

        try{

            $query = $this->conection->prepare("CALL spu_list_separation_ByIdAsset(?)");
            $query->execute(array($idactivo));

            return $query->fetch(PDO::FETCH_ASSOC);
            
        }
        catch(Exception $e){
            die($e->getMessage());
        }
    }
}
?>