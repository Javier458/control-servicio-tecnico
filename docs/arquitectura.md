# Arquitectura del Sistema

> 📌 ## Capa de conexión a base de datos

   - `config/database.example.php`: plantilla pública de credenciales.
   - `config/database.php`: credenciales reales (ignorado por Git).
   - `config/Conexion.php`: clase Singleton que entrega la conexión PDO
     a cualquier modelo que la necesite, evitando conexiones redundantes.