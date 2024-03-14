<?php

require_once __DIR__ . "/../Conection.php";

class Departamento extends Conection{

    //El objeto de conexión
    private $conection;

    //constructor => indica que es lo que hará el al ser iniciado
    public function __construct(){

        $this->conection = parent::getConection();
    }

    //Public funtion => en POO se les conoce como métodos    
    /**
     * Método para listar los departamentos
     */
    public function list_departament(){

        try{

            $query = $this->conection->prepare("CALL spu_list_departaments()");
            $query->execute();

            return $query->fetchAll(PDO::FETCH_ASSOC);
        }
        catch(Exception $e){

            die($e->getMessage());

        }
    }
}
?>