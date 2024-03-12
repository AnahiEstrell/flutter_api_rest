// Ignora las advertencias sobre comparaciones innecesarias con null
// Importa el paquete material.dart de Flutter
import 'package:flutter/material.dart';

// Widget para un círculo con un gradiente de colores
class Circle extends StatelessWidget {
  final double size; // Tamaño del círculo
  final List<Color> colors; // Lista de colores para el gradiente
  const Circle({super.key, required this.size, required this.colors})
      // Constructor con validaciones de parámetros
      : assert(size > 0), // Asegura que el tamaño no sea null y sea mayor que 0
        assert(colors.length >=
            2); // Asegura que la lista de colores no sea null y tenga al menos 2 colores

  // Método para construir la interfaz de usuario del círculo
  @override
  Widget build(BuildContext context) {
    // Retorna un contenedor con forma de círculo y un gradiente de colores
    return Container(
      width: size, // Ancho del contenedor igual al tamaño del círculo
      height: size, // Altura del contenedor igual al tamaño del círculo
      decoration: BoxDecoration(
          shape: BoxShape.circle, // Forma del contenedor como círculo
          gradient: LinearGradient(
              colors: colors, // Colores del gradiente
              begin: Alignment.topCenter, // Punto de inicio del gradiente
              end: Alignment.bottomCenter)), // Punto final del gradiente
    );
  }
}
