import 'package:logger/logger.dart'; // Importa el paquete de logger para manejar registros.

class Logs { // Define la clase Logs.
  Logs._internal(); // Constructor privado para evitar instanciar la clase directamente.

  final Logger _logger = Logger(); // Instancia un objeto Logger para manejar registros.

  static final Logs _instance = Logs._internal(); // Instancia única de la clase Logs.

  static Logger get p => _instance._logger; // Método estático para obtener el objeto Logger.

}
