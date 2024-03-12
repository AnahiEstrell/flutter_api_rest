import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/circle.dart';
import 'package:flutter_api_rest/widgets/icon_container.dart';
import 'package:flutter_api_rest/widgets/login_forms.dart';

class HomePage extends StatefulWidget { // Define la clase HomePage, que es un StatefulWidget.
  static const routeName = 'home'; // Nombre de la ruta de la página de inicio.
  const HomePage({super.key}); // Constructor de la clase HomePage.

  @override
  State<HomePage> createState() => _HomePageState(); // Crea el estado de la página de inicio.
}

class _HomePageState extends State<HomePage> { // Define el estado de la página de inicio.
  @override
  Widget build(BuildContext context) { // Método para construir la interfaz de usuario de la página de inicio.
    final Responsive responsive = Responsive.of(context); // Obtiene un objeto Responsive a partir del contexto.
    final double pinkSize = responsive.wp(80); // Calcula el tamaño del círculo rosa.
    final double orangeSize = responsive.wp(57); // Calcula el tamaño del círculo naranja.
    return Scaffold( // Devuelve un Scaffold que proporciona una estructura básica de la página.
      body: GestureDetector( // Un widget para detectar gestos.
        onTap: () {
          FocusScope.of(context).unfocus(); // Oculta el teclado virtual cuando se toca fuera de los campos de texto.
        },
        child: SingleChildScrollView( // Un widget para desplazarse verticalmente.
          child: Container( // Contenedor principal de la página.
            width: double.infinity, // Ocupa todo el ancho disponible.
            height: responsive.height, // Toma la altura de la pantalla.
            color: Colors.white, // Fondo blanco.
            child: Stack( // Un widget que apila los widgets hijos.
              alignment: Alignment.center, // Alinea los widgets hijos al centro.
              children: <Widget>[ // Lista de widgets hijos.
                Positioned( // Posiciona el widget hijo en una posición específica.
                  right: -pinkSize * 0.2, // Posición del círculo rosa.
                  top: -pinkSize * 0.4,
                  child: Circle( // Widget de círculo.
                    size: pinkSize, // Tamaño del círculo.
                    colors: const [Colors.pinkAccent, Colors.pink], // Colores del círculo.
                  ),
                ),
                Positioned( // Posiciona el widget hijo en una posición específica.
                  left: -orangeSize * 0.15, // Posición del círculo naranja.
                  top: -orangeSize * 0.55,
                  child: Circle( // Widget de círculo.
                    size: orangeSize, // Tamaño del círculo.
                    colors: const [Colors.orange, Colors.deepOrangeAccent], // Colores del círculo.
                  ),
                ),
                Positioned( // Posiciona el widget hijo en una posición específica.
                  top: pinkSize * 0.35, // Posición de los elementos de texto.
                  child: Column( // Un widget para organizar widgets hijos en una columna.
                    children: [ // Lista de widgets hijos.
                      IconContainer( // Widget de contenedor de icono.
                        size: responsive.wp(17), // Tamaño del icono.
                      ),
                      SizedBox( // Un widget para establecer un espacio en blanco de tamaño específico.
                        height: responsive.dp(3), // Altura del espacio en blanco.
                      ),
                      Text( // Widget de texto.
                        "Hello Again\nWelcome Back", // Texto a mostrar.
                        textAlign: TextAlign.center, // Alineación del texto al centro.
                        style: TextStyle(fontSize: responsive.dp(1.6)), // Estilo del texto.
                      ),
                    ],
                  ),
                ),
                const LoginForm(), // Widget del formulario de inicio de sesión.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
