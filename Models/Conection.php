<?php

class Conection{
    
    private $server     = "localhost";
    private $port       = "3306";
    private $dataBase   = "AISOFT";
    private $user       = "root";
    private $password   = "";


    /**
    * Método de conexión a la base de datos
    */
    public function getConection(){

        try{

            $pdo = new PDO(

                //mysql:host  = {$this->server}; -> ¿DEBERÍA CAMBIARLO POR mariadb?
                //MANTENLO SIN ESPACIOS, ESO LO DETECTA Y TRAE ERRORES
                "mysql:host={$this->server}; 
                port={$this->port};
                dbname={$this->dataBase};
                charset=UTF8",
                $this->user,
                $this->password
            );

            //MANEJO DE ERRORES
            //ATTR_ERRMODE => CONFIGURA EL MANEJO DE ERRORES
            //ERRMODE_EXCEPTION => CONFIGURA LOAS EXEPCIONES AL IDENTIFICAR ERRORES

            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            return $pdo;
        }
        catch(Exception $e){

            die($e->getMessage());

        }
    }
}
?>