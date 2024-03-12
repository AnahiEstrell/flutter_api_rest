class User {
  // Define una clase llamada User.

  final String id;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String avatar;
  // Declara las propiedades de la clase User: id, email, createdAt, updatedAt y avatar.

  User({
    // Define un constructor de la clase User que toma argumentos con nombre.
    required this.id,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
    // Inicializa las propiedades de la clase User con los valores pasados como argumentos.
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      // Define un método de fábrica llamado fromJson que convierte un mapa JSON en una instancia de User.
      id: json[
          "_id"], // Asigna el valor de "_id" del mapa JSON a la propiedad id.
      email: json[
          "email"], // Asigna el valor de "email" del mapa JSON a la propiedad email.
      createdAt: DateTime.parse(json[
          "createdAt"]), // Convierte y asigna el valor de "createdAt" a un objeto DateTime.
      updatedAt: DateTime.parse(json[
          "updatedAt"]), // Convierte y asigna el valor de "updatedAt" a un objeto DateTime.
      avatar: json[
          'avatar']); // Asigna el valor de "avatar" del mapa JSON a la propiedad avatar.

  Map<String, dynamic> toJson() => {
        // Define un método toJson que convierte una instancia de User en un mapa JSON.
        "_id": id, // Agrega la propiedad id al mapa JSON con la clave "_id".
        "email":
            email, // Agrega la propiedad email al mapa JSON con la clave "email".
        "createdAt": createdAt
            .toIso8601String(), // Convierte createdAt a un formato ISO8601 y lo agrega al mapa JSON.
        "updatedAt": updatedAt
            .toIso8601String(), // Convierte updatedAt a un formato ISO8601 y lo agrega al mapa JSON.
        "avatar":
            avatar, // Agrega la propiedad avatar al mapa JSON con la clave "avatar".
      };

  User copyWith({
    // Define un método copyWith que crea una copia de la instancia actual con valores actualizados.
    String? id,
    String? email,
    String? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        // Crea una nueva instancia de User con valores actualizados.
        id: id ??
            this.id, // Si id no es nulo, úsalo; de lo contrario, usa el valor actual de id.
        email: email ??
            this.email, // Si email no es nulo, úsalo; de lo contrario, usa el valor actual de email.
        createdAt: createdAt ??
            this.createdAt, // Si createdAt no es nulo, úsalo; de lo contrario, usa el valor actual de createdAt.
        updatedAt: updatedAt ??
            this.updatedAt, // Si updatedAt no es nulo, úsalo; de lo contrario, usa el valor actual de updatedAt.
        avatar: avatar ??
            this.avatar, // Si avatar no es nulo, úsalo; de lo contrario, usa el valor actual de avatar.
      );
}
