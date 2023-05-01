// To parse this JSON data, do
//
//     final productos = productosFromMap(jsonString);

import 'dart:convert';

class Productos {
    List<Listado> listado;

    Productos({
        required this.listado,
    });

    factory Productos.fromJson(String str) => Productos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Productos.fromMap(Map<String, dynamic> json) => Productos(
        listado: List<Listado>.from(json["List"].map((x) => Listado.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "Listado": List<dynamic>.from(listado.map((x) => x.toMap())),
    };
}

class Listado {
    int productoId;
    String nombre;
    DateTime fechaElaboracion;
    DateTime fechaVencimiento;
    String precio;
    String categoria;
    String imagen;

    Listado({
        required this.productoId,
        required this.nombre,
        required this.fechaElaboracion,
        required this.fechaVencimiento,
        required this.precio,
        required this.categoria,
        required this.imagen,
    });

    factory Listado.fromJson(String str) => Listado.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Listado.fromMap(Map<String, dynamic> json) => Listado(
        productoId: json["id"],
        nombre: json["nombre"],
        fechaElaboracion: DateTime.parse(json["fecha_elaboracion"]),
        fechaVencimiento: DateTime.parse(json["fecha_vencimiento"]),
        precio: json["precio"],
        categoria: json["categoria"],
        imagen: json["imagen"],
    );

    Map<String, dynamic> toMap() => {
        "productoId": productoId,
        "nombre": nombre,
        "fecha_elaboracion": "${fechaElaboracion.year.toString().padLeft(4, '0')}-${fechaElaboracion.month.toString().padLeft(2, '0')}-${fechaElaboracion.day.toString().padLeft(2, '0')}",
        "fecha_vencimiento": "${fechaVencimiento.year.toString().padLeft(4, '0')}-${fechaVencimiento.month.toString().padLeft(2, '0')}-${fechaVencimiento.day.toString().padLeft(2, '0')}",
        "precio": precio,
        "categoria": categoria,
        "imagen": imagen,
    };
    Listado copy() => Listado(
      productoId: productoId, 
      nombre: nombre, 
      precio: precio, 
      categoria: categoria, 
      fechaVencimiento: fechaVencimiento,
      fechaElaboracion: fechaElaboracion,
      imagen: imagen,
      );
}
