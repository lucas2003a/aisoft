<?php

require_once __DIR__ . "/../Conection.php";

class Distrito extends Conection{

    private $conection;

    public function __construct()
    {
        $this->conection = parent::getConection();
    }

    public function list_districts($idprovincia = 0){

        try{

            $query = $this->conection->prepare("CALL spu_list_districts(?)");
            $query->execute(array($idprovincia));

            return $query->fetchAll(PDO::FETCH_ASSOC);
        }
        catch(Exception $e){

            die($e->getMessage());
        }
    }
}
?>