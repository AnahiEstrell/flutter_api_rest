import 'package:dio/dio.dart'; // Importa el paquete Dio para realizar solicitudes HTTP
import 'package:flutter/material.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/pages/home.dart';
import 'package:flutter_api_rest/pages/home_pages.dart';
import 'package:flutter_api_rest/utils/utils.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  // Define la clase SplashPage, que es un StatefulWidget.
  const SplashPage({super.key}); // Constructor de la clase SplashPage.

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() =>
      _SplashPageState(); // Crea el estado de la página splash.
}

class _SplashPageState extends State<SplashPage> {
  // Define el estado de la página splash.
  final _authenticationClient = GetIt.instance<
      AuthenticationClient>(); // Instancia el cliente de autenticación.

  @override
  void initState() {
    // Método que se llama cuando el widget es inicializado.
    super.initState(); // Llama al initState del widget padre.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Agrega un callback que se ejecuta después del primer frame.
      _checkLogin(); // Verifica si el usuario está autenticado.
    });
  }

  Future<void> _checkLogin() async {
    // Método para verificar si el usuario está autenticado.
    final token = await _authenticationClient
        .accessToken; // Obtiene el token de acceso del cliente de autenticación.
    Logs.p.i(CancelToken); // Registra un mensaje de información.
    if (token == null) {
      // Si el token es nulo, el usuario no está autenticado.
      Navigator.pushReplacementNamed(
          // ignore: use_build_context_synchronously
          context,
          HomePage.routeName); // Navega a la página de inicio.
      return;
    }
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context,
        Home.routeName); // Si el usuario está autenticado, navega a la página principal.
  }

  @override
  Widget build(BuildContext context) {
    // Método para construir la interfaz de usuario de la página splash.
    return const Scaffold(
      // Devuelve un Scaffold que proporciona una estructura básica de la página.
      body: Center(
        // Widget para alinear su hijo al centro tanto vertical como horizontalmente.
        child:
            CircularProgressIndicator(), // Muestra un indicador de progreso circular en el centro.
      ),
    );
  }
}
