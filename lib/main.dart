import 'package:flutter/material.dart';
import 'package:flutter_api_rest/helpers/dependency_injection.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_rest/pages/register_pages.dart';
import 'package:flutter_api_rest/pages/splash_pages.dart';

void main() {
  DependencyInjection.initialize(); // Inicializa la inyección de dependencias.
  runApp(const MyApp()); // Ejecuta la aplicación Flutter MyApp.
}

class MyApp extends StatelessWidget {
  // Define la clase MyApp que extiende StatelessWidget.
  const MyApp({super.key}); // Constructor de MyApp.

  // Este widget es la raíz de tu aplicación.
  @override
  Widget build(BuildContext context) {
    // Método para construir el árbol de widgets de la aplicación.
    SystemChrome.setPreferredOrientations([
      // Establece las orientaciones preferidas de la pantalla.
      DeviceOrientation.portraitUp, // Orientación vertical hacia arriba.
      DeviceOrientation.portraitDown, // Orientación vertical hacia abajo.
    ]);
    return MaterialApp(
      // Devuelve un MaterialApp, que es el widget raíz de la aplicación Flutter.
      title: 'Flutter Demo', // Título de la aplicación.
      theme: ThemeData(
        // Define el tema de la aplicación.
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors
                .deepPurple), // Define el esquema de colores de la aplicación.
        useMaterial3: true, // Habilita Material Design 3.
      ),
      home:
          const SplashPage(), // Define la página de inicio de la aplicación como SplashPage.
      routes: {
        // Define las rutas de la aplicación.
        RegisterPage.routeName: (_) =>
            const RegisterPage(), // Ruta para la página de registro.
        LoginPage.routeName: (_) =>
            const LoginPage(), // Ruta para la página de inicio.
        Home.routeName: (_) => const Home() // Ruta para la página de inicio.
      },
    );
  }
}
