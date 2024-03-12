class Session {
  // Define una clase llamada Session.

  final String token;
  final int expiresIn;
  final DateTime createdAt;
  // Declara las propiedades de la clase Session: token, expiresIn y createdAt.

  Session({
    // Define un constructor de la clase Session que toma argumentos con nombre.
    required this.token,
    required this.expiresIn,
    required this.createdAt,
    // Inicializa las propiedades de la clase Session con los valores pasados como argumentos.
  });

  static Session fromJson(Map<String, dynamic> json) {
    // Define un método estático fromJson que convierte un mapa JSON en una instancia de Session.
    return Session(
      // Crea una nueva instancia de Session con valores obtenidos del mapa JSON.
      token: json[
          'token'], // Asigna el valor de "token" del mapa JSON a la propiedad token.
      expiresIn: json[
          'expiresIn'], // Asigna el valor de "expiresIn" del mapa JSON a la propiedad expiresIn.
      createdAt: DateTime.parse(json[
          'createdAt']), // Convierte y asigna el valor de "createdAt" a un objeto DateTime.
    );
  }

  Map<String, dynamic> toJson() {
    // Define un método toJson que convierte una instancia de Session en un mapa JSON.
    return {
      "token":
          token, // Agrega la propiedad token al mapa JSON con la clave "token".
      "expiresIn":
          expiresIn, // Agrega la propiedad expiresIn al mapa JSON con la clave "expiresIn".
      "createdAt": createdAt
          .toString(), // Convierte createdAt a una cadena de texto y lo agrega al mapa JSON con la clave "createdAt".
    };
  }
}
