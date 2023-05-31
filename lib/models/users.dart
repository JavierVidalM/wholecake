import 'dart:convert';

class Users {
  Users({
    required this.userslist,
  });

  List<Listado> userslist;

  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        userslist:
            List<Listado>.from(json["List"].map((x) => Listado.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "List": List<dynamic>.from(userslist.map((x) => x.toMap())),
      };
}

class Listado {
  Listado({
    required this.userId,
    required this.userName,
    required this.userFirstName,
    required this.userLastName,
    required this.userEmail,
    required this.tipo,
    required this.rut,
    required this.local,
    required this.direccion,
    required this.ntelefono,
    required this.nemergencia,
    required this.imagen_user,
  });

  int userId;
  String userName;
  String userFirstName;
  String userLastName;
  String userEmail;
  String tipo;
  String rut;
  String local;
  String direccion;
  String ntelefono;
  String nemergencia;
  String imagen_user;

  factory Listado.fromJson(String str) => Listado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Listado.fromMap(Map<String, dynamic> json) => Listado(
        userId: json["id"],
        userName: json["username"],
        userFirstName: json["first_name"],
        userLastName: json["last_name"],
        userEmail: json["email"],
        tipo: json["tipo"],
        rut: json["rut"],
        direccion: json["direccion"],
        ntelefono: json["ntelefono"],
        nemergencia: json["nemergencia"],
        local: json["local"],
        imagen_user: json["imagen_user"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "user_name": userName,
        "first_name": userFirstName,
        "last_name": userLastName,
        "user_email": userEmail,
        "tipo": tipo,
        "rut": rut,
        "direccion": direccion,
        "ntelefono": ntelefono,
        "nemergencia": nemergencia,
        "local": local,
        "imagen_user": imagen_user,
      };

  Listado copy() => Listado(
      userId: userId,
      userName: userName,
      userFirstName: userFirstName,
      userLastName: userLastName,
      userEmail: userEmail,
      tipo: tipo,
      rut: rut,
      direccion: direccion,
      ntelefono: ntelefono,
      nemergencia: nemergencia,
      local: local,
      imagen_user: imagen_user);
}
