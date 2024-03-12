// Importa los paquetes necesarios de Flutter
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Widget para contenedor de icono con sombra
class IconContainer extends StatelessWidget {
  final double size; // Tamaño del contenedor y del icono
  const IconContainer({super.key, required this.size})
      // Constructor con validaciones de parámetros
      : assert(size > 0); // Asegura que el tamaño no sea null y sea mayor que 0

  // Método para construir la interfaz de usuario del contenedor de icono
  @override
  Widget build(BuildContext context) {
    // Retorna un contenedor con un icono SVG en el centro
    return Container(
      width: size, // Ancho del contenedor igual al tamaño especificado
      height: size, // Altura del contenedor igual al tamaño especificado
      decoration: BoxDecoration(
        color: Colors.white, // Color de fondo del contenedor
        borderRadius: BorderRadius.circular(size * 0.15), // Borde redondeado del contenedor
        boxShadow: const [ // Sombra del contenedor
          BoxShadow(
            color: Colors.black12, // Color de la sombra
            blurRadius: 25, // Radio de desenfoque de la sombra
            offset: Offset(0, 15), // Desplazamiento de la sombra
          ),
        ],
      ),
      padding: EdgeInsets.all(size * 0.15), // Relleno del contenedor
      child: Center(
        child: SvgPicture.asset( // Icono SVG en el centro del contenedor
          'assets/icono.svg', // Ruta del archivo SVG
          width: size * 0.6, // Ancho del icono
          height: size * 0.6, // Altura del icono
        ),
      ),
    );
  }
}
