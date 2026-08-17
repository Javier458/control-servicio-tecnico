<?php

require_once __DIR__ . '/database.php';

/**
 * Clase encargada de crear y entregar la conexión PDO
 * a la base de datos, usando el patrón Singleton para
 * evitar abrir múltiples conexiones innecesarias.
 */


class Conexion{
    private static ?PDO $instancia = null;

    //Constructor privado: nadie puede hacer "new Conexion()"

    private function __construct(){
        
    }

    public static function getConexion(): PDO{
        if (self::$instancia === null){
            $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;

            $opciones = [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
            ];
            try{
                self::$instancia = new PDO($dsn, DB_USER, DB_PASS, $opciones);
            }catch (PDOException $e){
                die("Error de conexión a la base de datos: " . $e -> getMessage());
            }
        }

        return self::$instancia;
    }
}