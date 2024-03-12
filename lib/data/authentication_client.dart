import 'dart:async';
import 'dart:convert';

import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/models/authentication_response.dart';
import 'package:flutter_api_rest/models/session.dart';
import 'package:flutter_api_rest/utils/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationClient {
  // Un cliente para manejar la autenticación del usuario.

  final FlutterSecureStorage _secureStorage;
  // Un almacenamiento seguro para guardar y recuperar la sesión del usuario.
  final AuthenticationApi _authenticationApi;
  // Una API para realizar operaciones relacionadas con la autenticación.

  // Un completer que se usa para controlar las solicitudes concurrentes de tokens de acceso.
  // ignore: avoid_init_to_null
  Completer? completer = null;

  // Constructor que inicializa el cliente con un almacenamiento seguro y una API de autenticación.
  AuthenticationClient(this._secureStorage, this._authenticationApi);

  // Marca la tarea como completada si aún no ha finalizado.
  void _complete() {
    if (completer != null && completer?.isCompleted == false) {
      completer?.complete();
    }
  }

  // Obtiene el token de acceso del almacenamiento seguro.
  Future<String?> get accessToken async {
    if (completer != null) {
      await completer!.future;
    }

    Logs.p.i("called ${DateTime.now()}");

    completer = Completer();
    final data = await _secureStorage.read(key: 'SESSION');
    // Lee la sesión almacenada del almacenamiento seguro.

    if (data != null) {
      final session = Session.fromJson(jsonDecode(data));
      // Convierte los datos de la sesión de JSON a un objeto `Session`.

      final DateTime currentDate = DateTime.now();
      final DateTime createdAt = session.createdAt;
      final int expiredIn = session.expiresIn;
      final int diff = currentDate.difference(createdAt).inSeconds;
      // Calcula la diferencia entre la fecha actual y la fecha de creación de la sesión para determinar si ha expirado.

      Logs.p.i("session life time ${expiredIn - diff}");

      if (expiredIn - diff >= 3550) {
        _complete();
        return session.token;
      }
      // Si el token de acceso aún no ha expirado, devuelve el token existente.

      final response =
          await _authenticationApi.refreshToken(expiredToken: session.token);
      // Actualiza el token de acceso si ha expirado.

      if (response.data != null) {
        await saveSession(response.data!);
        // Guarda la nueva sesión actualizada en el almacenamiento seguro.
        _complete();
        return response.data!.token;
      }
      // Si no se puede actualizar el token de acceso, devuelve null.
      _complete();
      return null;
    }
    // Si no hay datos de sesión almacenados, devuelve null.
    _complete();
    return null;
  }

  // Guarda la sesión en el almacenamiento seguro.
  Future<void> saveSession(
      AuthenticationResponse authenticationResponse) async {
    final Session session = Session(
        token: authenticationResponse.token,
        expiresIn: authenticationResponse.expiresIn,
        createdAt: DateTime.now());

    final data = jsonEncode(session.toJson());
    // Convierte la sesión en un formato JSON para guardarla en el almacenamiento seguro.
    await _secureStorage.write(key: 'SESSION', value: data);
    // Escribe la sesión en el almacenamiento seguro.
  }

  // Elimina todas las sesiones del almacenamiento seguro al cerrar sesión.
  Future<void> signOut() async {
    await _secureStorage.deleteAll();
    // Elimina todas las sesiones almacenadas del almacenamiento seguro.
  }
}
