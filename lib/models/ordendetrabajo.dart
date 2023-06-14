// To parse this JSON data, do
//
//     final ordenTrabajo = ordenTrabajoFromMap(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

class OrdenTrabajo {
  List<ListTrabajo> listTrabajos;

  OrdenTrabajo({
    required this.listTrabajos,
  });

  factory OrdenTrabajo.fromJson(String str) =>
      OrdenTrabajo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrdenTrabajo.fromMap(Map<String, dynamic> json) => OrdenTrabajo(
        listTrabajos: List<ListTrabajo>.from(
            json["ListTrabajos"].map((x) => ListTrabajo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ListTrabajos": List<dynamic>.from(listTrabajos.map((x) => x.toMap())),
      };
}

class ListTrabajo {
  int id;
  String nombreProducto;
  int precioProducto;
  String estadoProducto;
  int cantidadProducto;
  String lote;
  String? fechaElaboracion;
  String? fechaVencimiento;
  int categoria;
  String imagen;
  List<OrdenesTrabajo> ordenesTrabajo;

  ListTrabajo({
    required this.id,
    required this.nombreProducto,
    required this.precioProducto,
    required this.estadoProducto,
    required this.cantidadProducto,
    required this.lote,
    this.fechaElaboracion,
    this.fechaVencimiento,
    required this.categoria,
    required this.imagen,
    required this.ordenesTrabajo,
  });

  factory ListTrabajo.fromJson(String str) =>
      ListTrabajo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListTrabajo.fromMap(Map<String, dynamic> json) => ListTrabajo(
        id: json["id"],
        nombreProducto: json["nombre_producto"],
        precioProducto: json["precio_producto"],
        estadoProducto: json["estado_producto"],
        cantidadProducto: json["cantidad_producto"],
        lote: json["lote"],
        fechaElaboracion: json["fecha_elaboracion"] == null
            ? null
            : json["fecha_elaboracion"],
        fechaVencimiento: json["fecha_vencimiento"] == null
            ? null
            : json["fecha_vencimiento"],
        categoria: json["categoria"],
        imagen: json["imagen"],
        ordenesTrabajo: List<OrdenesTrabajo>.from(
            json["ordenes_trabajo"].map((x) => OrdenesTrabajo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre_producto": nombreProducto,
        "precio_producto": precioProducto,
        "estado_producto": estadoProducto,
        "cantidad_producto": cantidadProducto,
        "lote": lote,
        "fecha_elaboracion": fechaElaboracion,
        "fecha_vencimiento": fechaVencimiento,
        "categoria": categoria,
        "imagen": imagen,
        "ordenes_trabajo":
            List<dynamic>.from(ordenesTrabajo.map((x) => x.toMap())),
      };

  ListTrabajo copy() => ListTrabajo(
        id: id,
        nombreProducto: nombreProducto,
        cantidadProducto: cantidadProducto,
        fechaElaboracion: fechaElaboracion,
        fechaVencimiento: fechaVencimiento,
        precioProducto: precioProducto,
        estadoProducto: estadoProducto,
        lote: lote,
        categoria: categoria,
        imagen: imagen,
        ordenesTrabajo: ordenesTrabajo,
      );
}

class OrdenesTrabajo {
  int id;
  int admin;
  int? trabajador;
  List<InsumosUtilizado> insumosUtilizados;

  OrdenesTrabajo({
    required this.id,
    required this.admin,
    this.trabajador,
    required this.insumosUtilizados,
  });

  factory OrdenesTrabajo.fromJson(String str) =>
      OrdenesTrabajo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrdenesTrabajo.fromMap(Map<String, dynamic> json) => OrdenesTrabajo(
        id: json["id"],
        admin: json["admin"],
        trabajador: json["trabajador"],
        insumosUtilizados: List<InsumosUtilizado>.from(
            json["insumos_utilizados"].map((x) => InsumosUtilizado.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "admin": admin,
        "trabajador": trabajador,
        "insumos_utilizados":
            List<dynamic>.from(insumosUtilizados.map((x) => x.toMap())),
      };
}

class InsumosUtilizado {
  int id;
  String nombre;
  int cantidadUtilizada;

  InsumosUtilizado({
    required this.id,
    required this.nombre,
    required this.cantidadUtilizada,
  });

  factory InsumosUtilizado.fromJson(String str) =>
      InsumosUtilizado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InsumosUtilizado.fromMap(Map<String, dynamic> json) =>
      InsumosUtilizado(
        id: json["id"],
        nombre: json["nombre"],
        cantidadUtilizada: json["cantidad_utilizada"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "cantidad_utilizada": cantidadUtilizada,
      };
}
