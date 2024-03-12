import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Widget para un botón de avatar con una imagen y un botón de añadir
class AvatarButton extends StatelessWidget {
  final double imageSize; // Tamaño de la imagen del avatar
  const AvatarButton({super.key, this.imageSize = 100});

  // Método para construir la interfaz de usuario del botón de avatar
  @override
  Widget build(BuildContext context) {
    // Retorna un stack que contiene la imagen del avatar y el botón de añadir
    return Stack(
      children: [
        // Contenedor para la imagen del avatar con sombra
        Container(
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    blurRadius: 20,
                    color: Colors.black26,
                    offset: Offset(0, 20))
              ]),
          child: ClipOval(
            // Imagen del avatar
            child: Image.network(
              'https://thumbs.dreamstime.com/b/d-avatar-illustration-smiling-happy-girl-cartoon-close-up-portrait-standing-isolated-transparent-png-background-generative-272798686.jpg',
              width: imageSize,
              height: imageSize,
            ),
          ),
        ),
        // Botón de añadir en la esquina superior derecha
        Positioned(
          right: 0,
          bottom: 5,
          child: CupertinoButton(
              onPressed: () {}, // Acción al presionar el botón
              padding: const EdgeInsets.all(0),
              borderRadius: BorderRadius.circular(30),
              // Contenedor del icono de añadir
              child: Container(
                // ignore: sort_child_properties_last
                child: const Icon(
                  Icons.add, // Icono de añadir
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  color: Colors.pink,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(3),
              )),
        ),
      ],
    );
  }
}
