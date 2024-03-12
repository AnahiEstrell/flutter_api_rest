import 'package:flutter/cupertino.dart'; // Importa el paquete de Cupertino para widgets específicos de iOS.
import 'package:flutter/material.dart'; // Importa el paquete de Material Design para widgets de Flutter.

// Clase abstracta para definir métodos de diálogos genéricos.
abstract class Dialogs {
  // Método estático para mostrar un diálogo de alerta.
  static alert(
    BuildContext context, {
    // Contexto de la aplicación.
    required String title, // Título del diálogo de alerta.
    required String? description, // Descripción opcional del diálogo de alerta.
  }) {
    showDialog(
      // Muestra el diálogo.
      context: context, // Contexto del diálogo.
      builder: (_) => AlertDialog(
        // Constructor del diálogo de alerta.
        title: Text(title), // Título del diálogo de alerta.
        content: Text(description!), // Contenido del diálogo de alerta.
        actions: [
          // Acciones del diálogo de alerta.
          ElevatedButton(
              // Botón elevado de acción.
              onPressed: () {
                Navigator.pop(_); // Cierra el diálogo al presionar el botón.
              },
              child: const Text("OK")) // Texto del botón de acción.
        ],
      ),
    );
  }
}

// Clase abstracta para definir métodos de diálogos de progreso.
abstract class ProgressDialog {
  // Método estático para mostrar un diálogo de progreso.
  static show(BuildContext context) {
    showCupertinoDialog(
        // Muestra el diálogo de Cupertino.
        context: context, // Contexto del diálogo.
        builder: (_) {
          // Constructor del diálogo.
          // ignore: deprecated_member_use
          return WillPopScope(
            // Retorna un widget que gestiona si el usuario puede cerrar el diálogo.
            onWillPop: () async =>
                false, // Evita que el diálogo se cierre al tocar fuera de él.
            child: Container(
              // Contenedor del diálogo.
              width: double
                  .infinity, // Ancho del contenedor igual al ancho de la pantalla.
              height: double
                  .infinity, // Alto del contenedor igual al alto de la pantalla.
              color: Colors.white
                  .withOpacity(0.9), // Color de fondo del contenedor.
              child: const Center(
                // Centra el contenido del contenedor.
                child:
                    CircularProgressIndicator(), // Muestra un indicador de progreso circular.
              ),
            ),
          );
        });
  }

  // Método estático para cerrar el diálogo de progreso.
  static dissmiss(BuildContext context) {
    Navigator.pop(context); // Cierra el diálogo.
  }
}
