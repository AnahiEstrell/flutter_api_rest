
// La clase DependencyInjection se utiliza para configurar y proporcionar instancias 
// únicas de las dependencias necesarias en una aplicación, como APIs de autenticación 
// y comunicación con servicios web, permitiendo un acceso centralizado a estas dependencias 
// en toda la aplicación.



import 'package:dio/dio.dart';
import 'package:flutter_api_rest/api/account_api.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/helpers/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInjection {
  static void initialize() {
    // Crea una instancia de Dio con la URL base especificada.
    final Dio dio = Dio(BaseOptions(baseUrl: "http://192.168.0.5:9000"));

    // Crea una instancia de la clase Http para manejar las solicitudes HTTP, habilitando los registros de logs y pasando la instancia de Dio.
    Http http = Http(
      logsEnabled: true,
      dio: dio,
    );

    // Crea una instancia de FlutterSecureStorage para manejar el almacenamiento seguro de datos sensibles.
    const secureStorage = FlutterSecureStorage();

    // Crea instancias de AuthenticationApi, AuthenticationClient y AccountApi con las dependencias necesarias.
    final authenticationApi = AuthenticationApi(http: http);
    final authenticationClient =
        AuthenticationClient(secureStorage, authenticationApi);
    final accountApi = AccountApi(http, authenticationClient);

    // Registra las instancias de las clases creadas en el contenedor de dependencias GetIt como singletons, para que puedan ser accedidas globalmente en la aplicación.
    GetIt.instance.registerSingleton<AuthenticationApi>(authenticationApi);
    GetIt.instance
        .registerSingleton<AuthenticationClient>(authenticationClient);
    GetIt.instance.registerSingleton<AccountApi>(accountApi);
  }
}
