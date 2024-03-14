<?php

require_once __DIR__ . "/../Conection.php";

class Provincia extends Conection{

    private $conection;

    public function __construct(){

        $this->conection = parent::getConection();
    
    }

    public function list_provinces($iddepartamento = 0){

        try{
            $query = $this->conection->prepare("CALL spu_list_provinces(?)");
            $query->execute(array($iddepartamento));

            return $query->fetchAll(PDO::FETCH_ASSOC);
        }
        catch(Exception $e){

            die($e->getMessage());
        }
    }
}
?>