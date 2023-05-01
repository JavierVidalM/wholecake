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
            List<Listado>.from(json["Listado"].map((x) => Listado.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Listado": List<dynamic>.from(userslist.map((x) => x.toMap())),
      };
}

class Listado {
  Listado({
    required this.userId,
    required this.userName,
    required this.userRut,
    required this.userSede,
    required this.userCargo,
    required this.userDireccion,
    required this.userCorreo,
    required this.userNumero,
    required this.userNemergencia,
  });

  int userId;
  String userName;
  int userRut;
  String userSede;
  String userCargo;
  String userDireccion;
  String userCorreo;
  int userNumero;
  int userNemergencia;

  factory Listado.fromJson(String str) => Listado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Listado.fromMap(Map<String, dynamic> json) => Listado(
        userId: json["user_id"],
        userName: json["user_name"],
        userRut: json["user_rut"],
        userSede: json["user_sede"],
        userCargo: json["user_cargo"],
        userDireccion: json["user_direccion"],
        userCorreo: json["user_correo"],
        userNumero: json["user_numero"],
        userNemergencia: json["user_nemergencia"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "user_name": userName,
        "user_rut": userRut,
        "user_sede": userSede,
        "user_cargo": userCargo,
        "user_direccion": userDireccion,
        "user_correo": userCorreo,
        "user_numero": userNumero,
        "user_nemergencia": userNemergencia,
      };

  Listado copy() => Listado(
        userId: userId,
        userName: userName,
        userRut: userRut,
        userSede: userSede,
        userCargo: userCargo,
        userDireccion: userDireccion,
        userCorreo: userCorreo,
        userNumero: userNumero,
        userNemergencia: userNemergencia,
      );
}
