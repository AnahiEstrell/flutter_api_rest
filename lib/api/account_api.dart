import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/helpers/http.dart';
import 'package:flutter_api_rest/helpers/http_response.dart';
import 'package:flutter_api_rest/models/user.dart';

class AccountApi {
  // Una clase para manejar las operaciones relacionadas con la cuenta del usuario en la API.

  final Http _http;
  // Una instancia de la clase `Http` para realizar solicitudes HTTP.
  final AuthenticationClient _authenticationClient;
  // Una instancia de la clase `AuthenticationClient` para obtener el token de sesión.

  // Constructor que inicializa la API de la cuenta con una instancia de `Http` y `AuthenticationClient`.
  AccountApi(this._http, this._authenticationClient);

  // Método para obtener la información del usuario.
  Future<HttpResponse<User>> getUserInfo() async {
    final token = await _authenticationClient.accessToken;
    // Obtiene el token de sesión del cliente de autenticación.

    if (token != null) {
      // Si se obtiene el token de sesión, realiza una solicitud GET para obtener la información del usuario.
      return _http.request<User>(
        '/api/v1/user-info',
        method: "GET",
        headers: {
          "token": token,
        },
        // Parsea los datos de la respuesta JSON a un objeto `User`.
        parser: (data) {
          return User.fromJson(data);
        },
      );
    } else {
      // Si no se puede obtener el token de sesión, devuelve una respuesta de error.
      return HttpResponse.fail<User>(
          statusCode: -1, message: "No se pudo obtener el token de sesión");
    }
  }

  // Método para actualizar el avatar del usuario.
  Future<HttpResponse<String>> updateAvatar(
      Uint8List bytes, String filename) async {
    final token = await _authenticationClient.accessToken;
    // Obtiene el token de sesión del cliente de autenticación.

    if (token != null) {
      // Si se obtiene el token de sesión, realiza una solicitud POST para actualizar el avatar.
      return _http.request<String>('/api/v1/update-avatar', method: "POST", headers: {
        "token": token,
      }, formData: {
        // Adjunta el archivo de imagen en formato bytes a la solicitud.
        "attachment": MultipartFile.fromBytes(bytes, filename: filename),
      });
    } else {
      // Si no se puede obtener el token de sesión, devuelve una respuesta de error.
      return HttpResponse.fail<String>(
          statusCode: -1, message: "No se pudo obtener el token de sesión");
    }
  }
}
