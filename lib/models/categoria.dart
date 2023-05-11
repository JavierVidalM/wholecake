// To parse this JSON data, do
//
//     final categorias = categoriasFromMap(jsonString);

import 'dart:convert';

class Categorias {
    List<ListElement> list;

    Categorias({
        required this.list,
    });

    factory Categorias.fromJson(String str) => Categorias.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Categorias.fromMap(Map<String, dynamic> json) => Categorias(
        list: List<ListElement>.from(json["List"].map((x) => ListElement.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "List": List<dynamic>.from(list.map((x) => x.toMap())),
    };
}

class ListElement {
    int categoriaId;
    String nombre;

    ListElement({
        required this.categoriaId,
        required this.nombre,
    });

    factory ListElement.fromJson(String str) => ListElement.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ListElement.fromMap(Map<String, dynamic> json) => ListElement(
        categoriaId: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toMap() => {
        "categoriaId": categoriaId,
        "nombre": nombre,
    };
}
