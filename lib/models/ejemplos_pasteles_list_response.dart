// To parse this JSON data, do
//
//     final ejemplosPastelesListResponse = ejemplosPastelesListResponseFromMap(jsonString);

import 'dart:convert';

class EjemplosPastelesListResponse {
    EjemplosPastelesListResponse({
        required this.pasteles,
    });

    List<Pastele> pasteles;

    factory EjemplosPastelesListResponse.fromJson(String str) => EjemplosPastelesListResponse.fromMap(json.decode(str));

    // String toJson() => json.encode(toMap());

    factory EjemplosPastelesListResponse.fromMap(Map<String, dynamic> json) => EjemplosPastelesListResponse(
        pasteles: List<Pastele>.from(json["List"].map((x) => Pastele.fromMap(x))),
    );

    // Map<String, dynamic> toMap() => {
    //     "pasteles": List<dynamic>.from(pasteles.map((x) => x.toMap())),
    // };
}

class Pastele {
    Pastele({
        required this.nombre,
        required this.fechaElaboracion,
        required this.fechaVencimiento,
        required this.precio,
    });

    String nombre;
    DateTime fechaElaboracion;
    DateTime fechaVencimiento;
    String precio;

    factory Pastele.fromJson(String str) => Pastele.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Pastele.fromMap(Map<String, dynamic> json) => Pastele(
        nombre: json["nombre"],
        fechaElaboracion: DateTime.parse(json["fecha_elaboracion"]),
        fechaVencimiento: DateTime.parse(json["fecha_vencimiento"]),
        precio: json["precio"],
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "fecha_elaboracion": "${fechaElaboracion.year.toString().padLeft(4, '0')}-${fechaElaboracion.month.toString().padLeft(2, '0')}-${fechaElaboracion.day.toString().padLeft(2, '0')}",
        "fecha_vencimiento": "${fechaVencimiento.year.toString().padLeft(4, '0')}-${fechaVencimiento.month.toString().padLeft(2, '0')}-${fechaVencimiento.day.toString().padLeft(2, '0')}",
        "precio": precio,
    };
}
