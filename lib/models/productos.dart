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
        listado:
            List<Listado>.from(json["List"].map((x) => Listado.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Listado": List<dynamic>.from(listado.map((x) => x.toMap())),
      };
}

class Listado {
  int productoId;
  String nombre;
  String fechaElaboracion;
  String fechaVencimiento;
  int precio;
  int categoria;
  String imagen;
  String estado;
  int cantidad;
  String lote;

  Listado({
    required this.productoId,
    required this.nombre,
    required this.fechaElaboracion,
    required this.fechaVencimiento,
    required this.precio,
    required this.categoria,
    required this.imagen,
    required this.estado,
    required this.cantidad,
    required this.lote,
  });

  factory Listado.fromJson(String str) => Listado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Listado.fromMap(Map<String, dynamic> json) => Listado(
      productoId: json["id"],
      nombre: json["nombre"],
      fechaElaboracion: json["fecha_elaboracion"],
      fechaVencimiento: json["fecha_vencimiento"],
      precio: json["precio"],
      categoria: json["categoria"],
      imagen: json["imagen"],
      estado: json["estado"],
      cantidad: json["cantidad"],
      lote: json["lote"]);

  Map<String, dynamic> toMap() => {
        "productoId": productoId,
        "nombre": nombre,
        "fecha_elaboracion": fechaElaboracion,
        "fecha_vencimiento": fechaVencimiento,
        "precio": precio,
        "categoria": categoria,
        "imagen": imagen,
        'estado': estado,
        "cantidad": cantidad,
        "lote": lote
      };
  Listado copy() => Listado(
        productoId: productoId,
        nombre: nombre,
        precio: precio,
        categoria: categoria,
        fechaVencimiento: fechaVencimiento,
        fechaElaboracion: fechaElaboracion,
        imagen: imagen,
        estado: estado,
        cantidad: cantidad,
        lote: lote,
      );
}
