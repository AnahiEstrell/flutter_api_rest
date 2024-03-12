import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/avatar_button.dart';
import 'package:flutter_api_rest/widgets/circle.dart';
import 'package:flutter_api_rest/widgets/register_form.dart';

class RegisterPage extends StatefulWidget {
  // Define la clase RegisterPage, que es un StatefulWidget.
  static const routeName =
      'register'; // Nombre de la ruta de la página de registro.
  const RegisterPage({super.key}); // Constructor de la clase RegisterPage.

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState(); // Crea el estado de la página de registro.
}

class _RegisterPageState extends State<RegisterPage> {
  // Define el estado de la página de registro.
  @override
  Widget build(BuildContext context) {
    // Método para construir la interfaz de usuario de la página de registro.
    final Responsive responsive = Responsive.of(
        context); // Obtiene un objeto Responsive a partir del contexto.
    final double pinkSize =
        responsive.wp(88); // Calcula el tamaño del círculo rosa.
    final double orangeSize =
        responsive.wp(57); // Calcula el tamaño del círculo naranja.
    return Scaffold(
      // Devuelve un Scaffold que proporciona una estructura básica de la página.
      body: GestureDetector(
        // Un widget para detectar gestos.
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Oculta el teclado virtual cuando se toca fuera de los campos de texto.
        },
        child: SingleChildScrollView(
          // Un widget para desplazarse verticalmente.
          child: Container(
            // Contenedor principal de la página.
            width: double.infinity, // Ocupa todo el ancho disponible.
            height: responsive.height, // Toma la altura de la pantalla.
            color: Colors.white, // Fondo blanco.
            child: Stack(
              // Un widget que apila los widgets hijos.
              alignment:
                  Alignment.center, // Alinea los widgets hijos al centro.
              children: <Widget>[
                // Lista de widgets hijos.
                Positioned(
                  // Posiciona el widget hijo en una posición específica.
                  right: -pinkSize * 0.2, // Posición del círculo rosa.
                  top: -pinkSize * 0.3,
                  child: Circle(
                    // Widget de círculo.
                    size: pinkSize, // Tamaño del círculo.
                    colors: const [
                      Colors.pinkAccent,
                      Colors.pink
                    ], // Colores del círculo.
                  ),
                ),
                Positioned(
                  // Posiciona el widget hijo en una posición específica.
                  left: -orangeSize * 0.15, // Posición del círculo naranja.
                  top: -orangeSize * 0.35,
                  child: Circle(
                    // Widget de círculo.
                    size: orangeSize, // Tamaño del círculo.
                    colors: const [
                      Colors.orange,
                      Colors.deepOrangeAccent
                    ], // Colores del círculo.
                  ),
                ),
                Positioned(
                  // Posiciona el widget hijo en una posición específica.
                  top: pinkSize * 0.22, // Posición de los elementos de texto.
                  child: Column(
                    // Un widget para organizar widgets hijos en una columna.
                    children: [
                      // Lista de widgets hijos.
                      Text(
                        // Widget de texto.
                        "Hello\nSign up to get started.", // Texto a mostrar.
                        textAlign:
                            TextAlign.center, // Alineación del texto al centro.
                        style: TextStyle(
                          // Estilo del texto.
                          fontSize: responsive.dp(1.6), // Tamaño del texto.
                          color: Colors.white, // Color del texto.
                        ),
                      ),
                      SizedBox(
                        // Un widget para establecer un espacio en blanco de tamaño específico.
                        height:
                            responsive.dp(4.5), // Altura del espacio en blanco.
                      ),
                      AvatarButton(
                        // Widget del botón de avatar.
                        imageSize:
                            responsive.wp(25), // Tamaño del botón de avatar.
                      )
                    ],
                  ),
                ),
                const RegisterForm(), // Widget del formulario de registro.
                Positioned(
                  // Posiciona el widget hijo en una posición específica.
                  top: 15, // Posición vertical del botón de retroceso.
                  left: 15, // Posición horizontal del botón de retroceso.
                  child: SafeArea(
                    // Un widget que coloca sus hijos en una región segura.
                    child: CupertinoButton(
                      // Un botón con estilo de iOS.
                      onPressed: () {
                        // Manejador de eventos para cuando se presiona el botón.
                        Navigator.pop(
                            context); // Cierra la página de registro y vuelve a la página anterior.
                      },
                      color: Colors.black26, // Color del botón.
                      padding: const EdgeInsets.all(10), // Relleno del botón.
                      borderRadius: BorderRadius.circular(
                          30), // Borde redondeado del botón.
                      child: const Icon(
                          Icons.arrow_back), // Icono de flecha hacia atrás.
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
