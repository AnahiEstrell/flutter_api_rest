import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/account_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/models/user.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class Home extends StatefulWidget {
  // Define la clase Home, que es un StatefulWidget.
  static const routeName =
      'homePage'; // Nombre de la ruta de la página de inicio.

  const Home({super.key}); // Constructor de la clase Home.

  @override
  State<Home> createState() =>
      _HomeState(); // Crea el estado de la página de inicio.
}

class _HomeState extends State<Home> {
  // Define el estado de la página de inicio.
  final AccountApi _accountApi =
      GetIt.instance<AccountApi>(); // Instancia el API de la cuenta de usuario.
  // ignore: avoid_init_to_null
  User? _user = null; // Inicializa el usuario como nulo.

  @override
  void initState() {
    // Método que se llama cuando el widget es inicializado.
    super.initState(); // Llama al initState del widget padre.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Agrega un callback que se ejecuta después del primer frame.
      loadUser(); // Carga la información del usuario.
    });
  }

  Future<void> loadUser() async {
    // Método para cargar la información del usuario.
    final response =
        await _accountApi.getUserInfo(); // Obtiene la información del usuario.
    // ignore: unnecessary_null_comparison
    if (response != null) {
      // Si la respuesta no es nula.
      _user = response.data; // Asigna el usuario obtenido.
      setState(() {}); // Actualiza el estado del widget.
    }
  }

  Future<void> _signOut() async {
    // Método para cerrar sesión.
    // ignore: no_leading_underscores_for_local_identifiers
    final _authenticationClient = GetIt.instance<
        AuthenticationClient>(); // Instancia el cliente de autenticación.
    await _authenticationClient.signOut(); // Cierra sesión.
    Navigator.pushAndRemoveUntil(
      // Navega a la página de inicio y elimina todas las rutas anteriores.
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _pickImage() async {
    // Método para seleccionar una imagen.
    final ImagePicker imagePicker =
        ImagePicker(); // Instancia el picker de imágenes.
    final XFile? pickedFile = await imagePicker.pickImage(
        source:
            ImageSource.camera); // Abre la cámara para seleccionar una imagen.

    if (pickedFile != null) {
      // Si se selecciona una imagen.
      final bytes =
          await pickedFile.readAsBytes(); // Lee los bytes de la imagen.
      final filename =
          path.basename(pickedFile.path); // Obtiene el nombre del archivo.
      final response = await _accountApi.updateAvatar(
          bytes, filename); // Actualiza el avatar del usuario en el servidor.
      if (response.data != null) {
        // Si la respuesta no es nula.
        _user = _user?.copyWith(
            avatar:
                response.data); // Actualiza el avatar del usuario localmente.
        setState(() {}); // Actualiza el estado del widget.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Método para construir la interfaz de usuario de la página de inicio.
    // ignore: unused_local_variable, no_leading_underscores_for_local_identifiers
    final _authenticationClient = GetIt.instance<
        AuthenticationClient>(); // Instancia el cliente de autenticación.
    return Scaffold(
      // Devuelve un Scaffold que proporciona una estructura básica de la página.
      // ignore: sized_box_for_whitespace
      body: Container(
        // Contenedor principal de la página.
        width: double.infinity, // Ocupa todo el ancho disponible.
        child: Column(
          // Un widget para organizar widgets hijos en una columna.
          mainAxisAlignment: MainAxisAlignment
              .center, // Alinea los elementos al centro verticalmente.
          children: [
            // Lista de widgets hijos.
            if (_user == null)
              const CircularProgressIndicator(), // Si el usuario es nulo, muestra un indicador de progreso.
            if (_user !=
                null) // Si el usuario no es nulo, muestra información del usuario.
              Column(
                // Un widget para organizar widgets hijos en una columna.
                children: [
                  // Lista de widgets hijos.
                  if (_user?.avatar !=
                      null) // Si el usuario tiene un avatar, muestra la imagen.
                    ClipOval(
                      // Recorta el widget hijo en forma de círculo.
                      child: Image.network(
                        // Widget para mostrar imágenes desde una URL.
                        'http://192.168.0.5:9000${_user?.avatar}', // URL del avatar del usuario.
                        width: 100, // Ancho de la imagen.
                        height: 100, // Alto de la imagen.
                        fit: BoxFit
                            .cover, // Ajusta la imagen al tamaño del contenedor.
                      ),
                    ),
                  Text(_user!.id), // Muestra el ID del usuario.
                  Text(_user!
                      .email), // Muestra el correo electrónico del usuario.
                  Text(_user!.createdAt
                      .toIso8601String()), // Muestra la fecha de creación del usuario.
                ],
              ),
            ElevatedButton(
                onPressed: _pickImage,
                child: const Text(
                    "Update avatar")), // Botón para actualizar el avatar del usuario.
            ElevatedButton(
                onPressed: _signOut,
                child: const Text("Sign out")), // Botón para cerrar sesión.
          ],
        ),
      ),
    );
  }
}
